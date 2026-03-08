variable "admin_5_wlan_password" {
  description = "Password for admin 5GHz WiFi network"
  type        = string
  sensitive   = true
}

variable "guest_wlan_password" {
  description = "Password for guest WiFi network"
  type        = string
  sensitive   = true
}

variable "iot_wlan_password" {
  description = "Password for IoT WiFi network"
  type        = string
  sensitive   = true
}

variable "main_5_wlan_password" {
  description = "Password for main 5GHz WiFi network"
  type        = string
  sensitive   = true
}
