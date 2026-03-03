---
page_title: "Terrifi Provider"
subcategory: ""
description: |-
  Terraform provider for managing Ubiquiti UniFi network infrastructure.
---

# Terrifi Provider

The Terrifi provider lets you manage resources on a Ubiquiti UniFi controller.
It communicates with the UniFi API to create, read, update, and delete network configuration such as DNS records, networks, WLANs, firewall zones, firewall zone rules, and client devices.
We leverage hardware-in-the-loop testing to ensure that all resources are fully functional with real UniFi hardware.

## Example Usage

### Environment variable configuration

```terraform
provider "terrifi" {}
```

Set the following environment variables:

- `UNIFI_API` — Controller URL, including the port.
- `UNIFI_API_KEY` OR `UNIFI_USERNAME` and `UNIFI_PASSWORD` - either the API key or the username and password are required to authenticate with the controller. The API key is preferred, as it's arguably more secure and I've seen instances of rate-limiting with the username and password.
- `UNIFI_INSECURE` — Set to `true` if the controller is using a self-signed TLS certificate.

### Explicit configuration

```terraform
provider "terrifi" {
  api_url       = "https://192.168.1.1"
  api_key       = var.unifi_api_key
  site          = "default"
  allow_insecure = true
}
```


## Schema

- `api_url` (String) — URL of the UniFi controller API. Do not include the `/api` path — the SDK discovers API paths automatically to support both UDM-style and classic controller layouts. Can also be set with the `UNIFI_API` environment variable.
- `api_key` (String, Sensitive) — API key for the UniFi controller. If set, `username` and `password` are ignored. Can also be set with the `UNIFI_API_KEY` environment variable.
- `username` (String, Sensitive) — Local username for the UniFi controller API. Can also be set with the `UNIFI_USERNAME` environment variable.
- `password` (String, Sensitive) — Password for the UniFi controller API. Can also be set with the `UNIFI_PASSWORD` environment variable.
- `site` (String) — The UniFi site to manage. Defaults to `default`. Can also be set with the `UNIFI_SITE` environment variable.
- `allow_insecure` (Boolean) — Skip TLS certificate verification. Useful for local controllers with self-signed certs. Can also be set with the `UNIFI_INSECURE` environment variable.

## Performance on Low-End Hardware

If the UniFi controller is running on low-end hardware (e.g., Raspberry Pi), Terraform's default parallelism of 10 concurrent operations can overwhelm the API server, causing slowdowns or crashes. Reduce parallelism to limit concurrent API requests:

```sh
tofu plan -parallelism=1
tofu apply -parallelism=1
```

You can experiment with intermediate values like `-parallelism=2` or `-parallelism=5` to find the right balance between speed and stability.

## Authentication

The provider supports two authentication methods:

1. **API key** (`api_key`) — Recommended. When set, `username` and `password` are ignored.
2. **Username + password** (`username` and `password`) — Legacy local-account authentication.

The API key is preferred, as it's arguably more secure and I've seen instances of rate-limiting with the username and password.
