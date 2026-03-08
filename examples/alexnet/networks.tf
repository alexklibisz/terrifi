resource "terrifi_network" "internal" {
  name         = "Internal"
  purpose      = "corporate"
  subnet       = "192.168.1.1/24"
  dhcp_enabled = true
  dhcp_start   = "192.168.1.100"
  dhcp_stop    = "192.168.1.254"
}

resource "terrifi_network" "personal_devices" {
  name         = "Personal Devices"
  purpose      = "corporate"
  vlan_id      = 2
  subnet       = "192.168.2.1/24"
  dhcp_enabled = true
  dhcp_start   = "192.168.2.7"
  dhcp_stop    = "192.168.2.254"
  dhcp_lease   = 86400
}

resource "terrifi_network" "apple_home" {
  name         = "Apple Home"
  purpose      = "corporate"
  vlan_id      = 3
  subnet       = "192.168.3.1/24"
  dhcp_enabled = true
  dhcp_start   = "192.168.3.6"
  dhcp_stop    = "192.168.3.254"
}

resource "terrifi_network" "iot" {
  name         = "IoT"
  purpose      = "corporate"
  vlan_id      = 4
  subnet       = "192.168.4.1/24"
  dhcp_enabled = true
  dhcp_start   = "192.168.4.6"
  dhcp_stop    = "192.168.4.254"
}

resource "terrifi_network" "untrusted" {
  name         = "Untrusted"
  purpose      = "corporate"
  vlan_id      = 5
  subnet       = "192.168.5.1/24"
  dhcp_enabled = true
  dhcp_start   = "192.168.5.6"
  dhcp_stop    = "192.168.5.254"
}
