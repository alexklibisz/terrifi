resource "terrifi_firewall_group" "ntp_ports" {
  name    = "NTP Ports"
  type    = "port-group"
  members = ["123"]
}
