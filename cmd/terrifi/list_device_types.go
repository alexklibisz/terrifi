package main

import (
	"context"
	"encoding/csv"
	"fmt"
	"html"
	"io"
	"net/http"
	"os"
	"path/filepath"
	"sort"
	"strconv"
	"sync"

	"github.com/alexklibisz/terrifi/internal/provider"
	"github.com/spf13/cobra"
)

func listDeviceTypesCmd() *cobra.Command {
	cmd := &cobra.Command{
		Use:   "list-device-types",
		Short: "List available device types (fingerprint IDs) from the UniFi controller",
		Long: "Queries the UniFi controller's fingerprint database and outputs all known " +
			"device types with their IDs as CSV. These IDs can be used as dev_id_override " +
			"values to set custom icons on client devices.\n\n" +
			"Use --html to generate a browsable HTML page with icons, fuzzy search, " +
			"and filterable type/vendor dropdowns.\n\n" +
			"Requires UNIFI_* environment variables to be configured.",
		Args: cobra.NoArgs,
		RunE: runListDeviceTypes,
	}
	cmd.Flags().Bool("html", false, "Generate a browsable directory (unifi-device-types/) with icons and fuzzy search")
	return cmd
}

func runListDeviceTypes(cmd *cobra.Command, args []string) error {
	ctx := context.Background()

	cfg := provider.ClientConfigFromEnv()
	client, err := provider.NewClient(ctx, cfg)
	if err != nil {
		return fmt.Errorf("connecting to UniFi controller: %w", err)
	}

	devices, err := client.ListFingerprintDevices(ctx, 0)
	if err != nil {
		return fmt.Errorf("listing device types: %w", err)
	}

	if len(devices) == 0 {
		fmt.Fprintln(os.Stderr, "No device types found.")
		return nil
	}

	fmt.Fprintf(os.Stderr, "Found %d device types.\n", len(devices))

	htmlFlag, _ := cmd.Flags().GetBool("html")
	if htmlFlag {
		site := cfg.Site
		if site == "" {
			site = "default"
		}
		version, err := client.GetControllerVersion(ctx, site)
		if err != nil {
			version = "unknown"
		}
		return writeDeviceTypesHTML(devices, version)
	}

	return writeDeviceTypesCSV(devices)
}

func iconURL(id int64) string {
	return fmt.Sprintf("https://static.ui.com/fingerprint/0/%d_257x257.png", id)
}

func writeDeviceTypesCSV(devices []provider.FingerprintDevice) error {
	w := csv.NewWriter(os.Stdout)
	defer w.Flush()

	if err := w.Write([]string{"id", "name", "dev_type", "family", "vendor", "icon_url"}); err != nil {
		return err
	}

	for _, d := range devices {
		record := []string{
			strconv.FormatInt(d.ID, 10),
			d.Name,
			d.DevType,
			d.Family,
			d.Vendor,
			iconURL(d.ID),
		}
		if err := w.Write(record); err != nil {
			return err
		}
	}
	return nil
}

// downloadIcons downloads device icons into imgDir, skipping any that already
// exist on disk. Uses concurrent downloads with progress reporting.
func downloadIcons(devices []provider.FingerprintDevice, imgDir string) {
	const concurrency = 50
	sem := make(chan struct{}, concurrency)

	var mu sync.Mutex
	var wg sync.WaitGroup
	done := 0
	skipped := 0
	total := len(devices)

	for _, d := range devices {
		wg.Add(1)
		sem <- struct{}{}
		go func(id int64) {
			defer wg.Done()
			defer func() { <-sem }()

			path := filepath.Join(imgDir, fmt.Sprintf("%d.png", id))

			// Skip if already downloaded.
			if _, err := os.Stat(path); err == nil {
				mu.Lock()
				done++
				skipped++
				mu.Unlock()
				return
			}

			url := fmt.Sprintf("https://static.ui.com/fingerprint/0/%d_51x51.png", id)
			resp, err := http.Get(url)
			if err != nil {
				return
			}
			defer resp.Body.Close()
			if resp.StatusCode != http.StatusOK {
				return
			}
			data, err := io.ReadAll(resp.Body)
			if err != nil {
				return
			}

			os.WriteFile(path, data, 0o644)

			mu.Lock()
			done++
			if done%200 == 0 || done == total {
				fmt.Fprintf(os.Stderr, "Icons: %d / %d (%d already existed)...\n", done, total, skipped)
			}
			mu.Unlock()
		}(d.ID)
	}

	wg.Wait()
	fmt.Fprintf(os.Stderr, "Icons: %d / %d (%d downloaded, %d already existed).\n", done, total, done-skipped, skipped)
}

func writeDeviceTypesHTML(devices []provider.FingerprintDevice, controllerVersion string) error {
	const outputDir = "unifi-device-types"
	imgDir := filepath.Join(outputDir, "img")
	if err := os.MkdirAll(imgDir, 0o755); err != nil {
		return fmt.Errorf("creating %s: %w", imgDir, err)
	}

	// Download icons into img/ directory (skips existing files).
	downloadIcons(devices, imgDir)

	// Collect unique types and vendors for the filter dropdowns.
	typeSet := map[string]bool{}
	vendorSet := map[string]bool{}
	for _, d := range devices {
		if d.DevType != "" {
			typeSet[d.DevType] = true
		}
		if d.Vendor != "" {
			vendorSet[d.Vendor] = true
		}
	}
	types := sortedKeys(typeSet)
	vendors := sortedKeys(vendorSet)

	outputFile := filepath.Join(outputDir, "index.html")
	f, err := os.Create(outputFile)
	if err != nil {
		return fmt.Errorf("creating %s: %w", outputFile, err)
	}
	defer f.Close()

	fmt.Fprint(f, `<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>UniFi Device Types</title>
<script src="https://cdn.jsdelivr.net/npm/fuse.js@7.0.0/dist/fuse.min.js"></script>
<style>
  * { box-sizing: border-box; margin: 0; padding: 0; }
  body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; background: #f5f5f5; color: #333; }
  .header { background: #1a1a2e; color: #fff; padding: 24px; position: sticky; top: 0; z-index: 10; }
  .header h1 { font-size: 20px; margin-bottom: 4px; }
  .header .subtitle { font-size: 14px; color: #bbb; margin-bottom: 8px; line-height: 1.4; }
  .header .subtitle a { color: #ccc; text-decoration: underline; }
  .header .version { font-size: 13px; color: #888; margin-bottom: 12px; }
  .controls { display: flex; flex-wrap: wrap; gap: 10px; align-items: center; }
  .controls input {
    flex: 1; min-width: 200px; max-width: 500px; padding: 10px 14px; font-size: 16px;
    border: none; border-radius: 6px; outline: none;
  }
  .controls select {
    padding: 10px 14px; font-size: 14px; border: none; border-radius: 6px;
    background: #fff; color: #333; cursor: pointer; outline: none;
  }
  .header .stats { font-size: 13px; color: #aaa; margin-top: 8px; }
  table { width: 100%; border-collapse: collapse; background: #fff; table-layout: fixed; }
  col.c-icon { width: 64px; }
  col.c-id { width: 100px; }
  col.c-name { width: 30%; }
  col.c-meta { }
  col.c-action { width: 80px; }
  th { background: #e8e8e8; position: sticky; text-align: left; padding: 10px 14px; font-size: 13px; z-index: 5; }
  td { padding: 8px 14px; border-bottom: 1px solid #eee; vertical-align: middle; }
  tr.hidden { display: none; }
  .icon-cell { width: 48px; height: 48px; background: #f0f0f0; border-radius: 6px; }
  .icon { width: 48px; height: 48px; object-fit: contain; }
  .icon:not([src]) { visibility: hidden; }
  @keyframes pulse { 0%, 100% { opacity: 0.4; } 50% { opacity: 1; } }
  .icon-cell:has(.icon:not([src]))::after {
    content: ''; display: block; width: 24px; height: 24px; margin: -36px auto 0;
    border-radius: 50%; background: #ddd; animation: pulse 1.2s ease-in-out infinite;
  }
  .id { font-family: monospace; font-size: 14px; color: #666; }
  .name { font-weight: 500; }
  .meta { font-size: 12px; color: #888; }
  .copy-btn {
    background: #e8e8e8; border: none; border-radius: 4px; padding: 4px 10px;
    font-size: 12px; cursor: pointer; color: #555; white-space: nowrap;
  }
  .copy-btn:hover { background: #ddd; }
  .copy-btn.copied { background: #4caf50; color: #fff; }
</style>
</head>
<body>
<div class="header">
  <h1>UniFi Device Types</h1>
  <p class="subtitle">Browse the UniFi controller fingerprint database to find device type IDs for use with <a href="https://github.com/alexklibisz/terraform-provider-terrifi">Terrifi</a>, a Terraform provider for UniFi.</p>
`)
	fmt.Fprintf(f, "  <div class=\"version\">Generated from controller version %s</div>\n", html.EscapeString(controllerVersion))
	fmt.Fprint(f, `  <div class="controls">
    <input type="text" id="search" placeholder="Search by name or ID..." autofocus>
`)
	fmt.Fprintf(f, "    <select id=\"filter-type\"><option value=\"\">All Types (%d)</option>\n", len(types))

	for _, t := range types {
		fmt.Fprintf(f, "    <option value=\"%s\">%s</option>\n", html.EscapeString(t), html.EscapeString(t))
	}

	fmt.Fprint(f, "    </select>\n")
	fmt.Fprintf(f, "    <select id=\"filter-vendor\"><option value=\"\">All Vendors (%d)</option>\n", len(vendors))

	for _, v := range vendors {
		fmt.Fprintf(f, "    <option value=\"%s\">%s</option>\n", html.EscapeString(v), html.EscapeString(v))
	}

	fmt.Fprint(f, `    </select>
  </div>
`)
	fmt.Fprintf(f, "  <div class=\"stats\" id=\"stats\">%d device types</div>\n", len(devices))
	fmt.Fprint(f, `</div>
<table>
<colgroup><col class="c-icon"><col class="c-id"><col class="c-name"><col class="c-meta"><col class="c-action"></colgroup>
<thead><tr><th>Icon</th><th>ID</th><th>Name</th><th>Type / Vendor</th><th></th></tr></thead>
<tbody id="tbody">
`)

	for _, d := range devices {
		escapedName := html.EscapeString(d.Name)
		fmt.Fprintf(f, `<tr data-id="%d" data-type="%s" data-vendor="%s" data-name="%s"><td class="icon-cell"><img class="icon" data-src="img/%d.png" alt="%s"></td><td class="id">%d</td><td class="name">%s</td><td class="meta">%s · %s</td><td><button class="copy-btn" data-copy="device_type_id = %d # %s">Copy</button></td></tr>
`,
			d.ID,
			html.EscapeString(d.DevType),
			html.EscapeString(d.Vendor),
			escapedName,
			d.ID,
			escapedName,
			d.ID,
			escapedName,
			html.EscapeString(d.DevType),
			html.EscapeString(d.Vendor),
			d.ID,
			escapedName,
		)
	}

	fmt.Fprint(f, `</tbody>
</table>
<script>
const tbody = document.getElementById('tbody');
const rows = Array.from(tbody.querySelectorAll('tr'));
const totalCount = rows.length;
const rowById = {};
rows.forEach(r => rowById[r.dataset.id] = r);

// Pin table header row just below the sticky page header.
// Use ResizeObserver to react to any header height changes (e.g. stats text appearing).
const header = document.querySelector('.header');
const ths = document.querySelectorAll('th');
new ResizeObserver(() => {
  const h = header.offsetHeight + 'px';
  ths.forEach(th => th.style.top = h);
}).observe(header);

// Lazy load images when they scroll into view.
const observer = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      const img = entry.target;
      if (!img.src && img.dataset.src) {
        img.src = img.dataset.src;
        observer.unobserve(img);
      }
    }
  });
}, { rootMargin: '200px' });
document.querySelectorAll('img.icon').forEach(img => observer.observe(img));

// Copy button handler.
document.addEventListener('click', (e) => {
  const btn = e.target.closest('.copy-btn');
  if (!btn) return;
  navigator.clipboard.writeText(btn.dataset.copy).then(() => {
    btn.textContent = 'Copied!';
    btn.classList.add('copied');
    setTimeout(() => { btn.textContent = 'Copy'; btn.classList.remove('copied'); }, 1500);
  });
});

const items = rows.map(row => ({
  id: row.dataset.id,
  name: row.dataset.name || '',
  meta: row.querySelector('.meta')?.textContent || '',
}));

const fuse = new Fuse(items, {
  keys: ['id', 'name', 'meta'],
  threshold: 0.3,
  ignoreLocation: true,
});

const searchInput = document.getElementById('search');
const filterType = document.getElementById('filter-type');
const filterVendor = document.getElementById('filter-vendor');
const stats = document.getElementById('stats');

function updateSelectOptions(sel, allLabel, available) {
  const current = sel.value;
  const sorted = Array.from(available).sort();

  sel.innerHTML = '';
  const allOpt = document.createElement('option');
  allOpt.value = '';
  allOpt.textContent = allLabel + ' (' + sorted.length + ')';
  sel.appendChild(allOpt);

  for (const val of sorted) {
    const opt = document.createElement('option');
    opt.value = val;
    opt.textContent = val;
    if (val === current) opt.selected = true;
    sel.appendChild(opt);
  }

  if (current && !available.has(current)) {
    sel.value = '';
  }
}

function applyFilters() {
  const query = searchInput.value.trim();
  const selectedType = filterType.value;
  const selectedVendor = filterVendor.value;

  // Get search results (ordered by relevance) or null for no query.
  let orderedIds = null;
  let matchIdSet = null;
  if (query) {
    orderedIds = fuse.search(query).map(r => r.item.id);
    matchIdSet = new Set(orderedIds);
  }

  // Single pass: determine visibility and collect dropdown values.
  const typesForVendor = new Set();
  const vendorsForType = new Set();
  const visibleSet = new Set();
  rows.forEach(r => {
    const passSearch = !matchIdSet || matchIdSet.has(r.dataset.id);
    const passType = !selectedType || r.dataset.type === selectedType;
    const passVendor = !selectedVendor || r.dataset.vendor === selectedVendor;
    if (passSearch && passType && passVendor) visibleSet.add(r);
    if (passSearch && passVendor && r.dataset.type) typesForVendor.add(r.dataset.type);
    if (passSearch && passType && r.dataset.vendor) vendorsForType.add(r.dataset.vendor);
  });

  // Build display order: relevance-ranked for search, original for no search.
  const frag = document.createDocumentFragment();
  if (orderedIds) {
    rows.forEach(r => r.classList.add('hidden'));
    for (const id of orderedIds) {
      const row = rowById[id];
      if (visibleSet.has(row)) {
        row.classList.remove('hidden');
        frag.appendChild(row);
      }
    }
  } else {
    rows.forEach(r => {
      r.classList.toggle('hidden', !visibleSet.has(r));
      frag.appendChild(r);
    });
  }
  tbody.appendChild(frag);

  // Trigger lazy load for newly visible images.
  visibleSet.forEach(r => {
    const img = r.querySelector('img.icon');
    if (img && !img.src && img.dataset.src) observer.observe(img);
  });

  updateSelectOptions(filterType, 'All Types', typesForVendor);
  updateSelectOptions(filterVendor, 'All Vendors', vendorsForType);

  if (!query && !selectedType && !selectedVendor) {
    stats.textContent = totalCount + ' device types';
  } else {
    stats.textContent = visibleSet.size + ' / ' + totalCount + ' device types';
  }
}

let debounceTimer;
searchInput.addEventListener('input', () => {
  clearTimeout(debounceTimer);
  debounceTimer = setTimeout(applyFilters, 150);
});
filterType.addEventListener('change', applyFilters);
filterVendor.addEventListener('change', applyFilters);
applyFilters();
</script>
</body>
</html>
`)

	fmt.Fprintf(os.Stderr, "Wrote %s\n", outputFile)
	return nil
}

func sortedKeys(m map[string]bool) []string {
	keys := make([]string, 0, len(m))
	for k := range m {
		keys = append(keys, k)
	}
	sort.Strings(keys)
	return keys
}
