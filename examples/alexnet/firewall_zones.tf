resource "terrifi_firewall_zone" "internal" {
  name = "Internal"
  network_ids = [
    terrifi_network.internal.id
  ]
}

resource "terrifi_firewall_zone" "external" {
  name = "External"
  # I don't see a corresponding network for this.
  network_ids = ["redacted1234567890"]
}

resource "terrifi_firewall_zone" "iot" {
  name = "IoT"
  network_ids = [
    terrifi_network.iot.id
  ]
}

resource "terrifi_firewall_zone" "untrusted" {
  name = "Untrusted"
  network_ids = [
    terrifi_network.untrusted.id
  ]
}

resource "terrifi_firewall_zone" "apple_home" {
  name = "Apple Home"
  network_ids = [
    terrifi_network.apple_home.id
  ]
}

resource "terrifi_firewall_zone" "personal_devices" {
  name = "Personal Devices"
  network_ids = [
    terrifi_network.personal_devices.id
  ]
}
