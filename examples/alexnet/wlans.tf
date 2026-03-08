resource "terrifi_wlan" "redwood_main_5" {
  name       = "myhome-main-5"
  passphrase = var.main_5_wlan_password
  # Intentionally landing on the untrusted network.
  # Devices can be promoted to other networks as needed.
  network_id = terrifi_network.untrusted.id
  wifi_band  = "5g"
}

resource "terrifi_wlan" "redwood_iot_24" {
  name       = "myhome-iot-24"
  passphrase = var.iot_wlan_password
  # Intentionally landing on the untrusted network.
  # Devices can be promoted to other networks as needed.
  network_id = terrifi_network.untrusted.id
  wifi_band  = "2g"
}

resource "terrifi_wlan" "redwood_admin_5" {
  name       = "myhome-admin-5"
  passphrase = var.admin_5_wlan_password
  network_id = terrifi_network.internal.id
  wifi_band  = "5g"
  hide_ssid  = true
}

resource "terrifi_wlan" "redwood_guest" {
  name       = "myhome-guest"
  passphrase = var.guest_wlan_password
  network_id = terrifi_network.untrusted.id
  wifi_band  = "5g"
}
