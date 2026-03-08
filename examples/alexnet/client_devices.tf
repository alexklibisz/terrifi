resource "terrifi_client_device" "akmbpro2021_redwood_main_5" {
  mac                 = "00:00:00:00:00:01"
  name                = "AKMBPRO2021 (myhome-main-5)"
  network_override_id = terrifi_network.personal_devices.id
  device_type_id      = 4663 # Apple MacBook Pro 16" M1 Max
}

resource "terrifi_client_device" "alex_desk_hub" {
  mac            = "00:00:00:00:00:02"
  name           = "Alex Desk Hub"
  device_type_id = 3798 # Generic Ethernet Port
  network_id     = terrifi_network.internal.id
  fixed_ip       = "192.168.1.29"
}

resource "terrifi_client_device" "alex_iphone_15_pro_iot_24" {
  mac                 = "00:00:00:00:00:03"
  name                = "Alex's iPhone 15 Pro (iot-24)"
  network_override_id = terrifi_network.personal_devices.id
  device_type_id      = 5114 # Apple iPhone 15 Pro
}

resource "terrifi_client_device" "alex_iphone_15_pro_redwood_main_5" {
  mac                 = "00:00:00:00:00:04"
  name                = "Alex's iPhone 15 Pro (myhome-main-5)"
  network_override_id = terrifi_network.personal_devices.id
  device_type_id      = 5114 # Apple iPhone 15 Pro
}

resource "terrifi_client_device" "alex_tesla_mbp" {
  mac                 = "00:00:00:00:00:05"
  name                = "Alex Tesla MBP"
  network_override_id = terrifi_network.personal_devices.id
  device_type_id      = 4934 # Apple MacBook Air M2 - 2022
}

resource "terrifi_client_device" "amazon_alexa_echo_dot" {
  mac                 = "00:00:00:00:00:06"
  name                = "Amazon Alexa Echo Dot"
  network_override_id = terrifi_network.iot.id
  device_type_id      = 4488 # Amazon Echo Dot (4th Gen)
}

resource "terrifi_client_device" "apple_airport_indoor_speakers" {
  mac                 = "00:00:00:00:00:07"
  name                = "Apple Airport Indoor Speakers"
  fixed_ip            = "192.168.3.6"
  network_id          = terrifi_network.apple_home.id
  network_override_id = terrifi_network.apple_home.id
  device_type_id      = 3770 # Apple AirPort Express
}

resource "terrifi_client_device" "apple_airport_outdoor_speakers" {
  mac                 = "00:00:00:00:00:08"
  name                = "Apple Airport Outdoor Speakers"
  fixed_ip            = "192.168.3.7"
  network_override_id = terrifi_network.apple_home.id
  device_type_id      = 3770 # Apple AirPort Express
}

resource "terrifi_client_device" "apple_homepod_mini_studio" {
  mac                 = "00:00:00:00:00:09"
  name                = "Apple HomePod Mini Studio"
  device_type_id      = 5723 # Apple HomePod Mini Orange
  fixed_ip            = "192.168.3.4"
  network_id          = terrifi_network.apple_home.id
  network_override_id = terrifi_network.apple_home.id
}

resource "terrifi_client_device" "apple_tv_garage" {
  mac            = "00:00:00:00:00:0a"
  name           = "Apple TV Garage"
  device_type_id = 4405 # Apple TV 4K
  fixed_ip       = "192.168.1.23"
  network_id     = terrifi_network.internal.id
}

resource "terrifi_client_device" "apple_tv_garage_wi_fi" {
  mac            = "00:00:00:00:00:0b"
  name           = "Apple TV Garage (Wi-Fi)"
  device_type_id = 4405 # Apple TV 4K
}

resource "terrifi_client_device" "apple_tv_living_room" {
  mac                 = "00:00:00:00:00:0c"
  name                = "Apple TV Living Room"
  device_type_id      = 4405 # Apple TV 4K
  fixed_ip            = "192.168.3.5"
  network_override_id = terrifi_network.apple_home.id
}

resource "terrifi_client_device" "aqara_hub_m100" {
  mac                 = "00:00:00:00:00:0d"
  name                = "Aqara Hub M100"
  device_type_id      = 3545 # Aqara Hub
  fixed_ip            = "192.168.4.5"
  network_override_id = terrifi_network.iot.id
}

resource "terrifi_client_device" "bond_bridge_living_room" {
  mac                 = "00:00:00:00:00:0f"
  name                = "Bond Bridge Living Room"
  device_type_id      = 3141 # Bond Bridge
  network_override_id = terrifi_network.iot.id
}

resource "terrifi_client_device" "broadlink_rm4_mini_studio" {
  mac                 = "00:00:00:00:00:10"
  name                = "Broadlink RM4 Mini Studio"
  device_type_id      = 3129 # Broadlink RM Mini 3
  network_override_id = terrifi_network.iot.id
}

resource "terrifi_client_device" "brother_printer" {
  mac                 = "00:00:00:00:00:11"
  name                = "Brother Printer"
  device_type_id      = 1607 # Brother Printer
  network_override_id = terrifi_network.personal_devices.id
}

resource "terrifi_client_device" "cusdis" {
  mac              = "00:00:00:00:00:12"
  name             = "cusdis"
  device_type_id   = 1908 # Linux
  network_id       = terrifi_network.internal.id
  fixed_ip         = "192.168.1.30"
  local_dns_record = "cusdis.example.com"
}

resource "terrifi_client_device" "devbox" {
  mac              = "00:00:00:00:00:13"
  name             = "devbox"
  device_type_id   = 1908 # Linux
  fixed_ip         = "192.168.1.27"
  network_id       = terrifi_network.internal.id
  local_dns_record = "devbox.example.com"
}

resource "terrifi_client_device" "eight_sleep_pod" {
  mac            = "00:00:00:00:00:14"
  name           = "Eight Sleep Pod"
  device_type_id = 5536 # Eight Sleep Pod 4
  fixed_ip       = "192.168.5.6"
  network_id     = terrifi_network.untrusted.id
}

resource "terrifi_client_device" "flic_hub_mini" {
  mac            = "00:00:00:00:00:15"
  name           = "Flic Hub Mini"
  device_type_id = 3279 # Flic Hub LR
}

resource "terrifi_client_device" "home_assistant" {
  mac              = "00:00:00:00:00:16"
  name             = "home-assistant"
  device_type_id   = 5142 # Home Assistant
  fixed_ip         = "192.168.1.14"
  network_id       = terrifi_network.internal.id
  local_dns_record = "home-assistant.example.com"
}

resource "terrifi_client_device" "immich" {
  mac              = "00:00:00:00:00:17"
  device_type_id   = 1908 # Linux
  fixed_ip         = "192.168.1.21"
  network_id       = terrifi_network.internal.id
  local_dns_record = "immich.example.com"
}

resource "terrifi_client_device" "jessica_iphone_15_pro" {
  mac                 = "00:00:00:00:00:18"
  name                = "Jessica's iPhone 15 Pro"
  network_override_id = terrifi_network.personal_devices.id
  device_type_id      = 5114 # Apple iPhone 15 Pro
}

resource "terrifi_client_device" "jessica_macbook_pro_2017" {
  mac                 = "00:00:00:00:00:19"
  name                = "Jessica's MacBook Pro 2017"
  network_override_id = terrifi_network.personal_devices.id
  device_type_id      = 5764 # Apple MacBook Pro 16" - 2016
}

resource "terrifi_client_device" "jessica_macbook_pro_2023" {
  mac                 = "00:00:00:00:00:1a"
  name                = "Jessica MacBook Pro 2023"
  network_override_id = terrifi_network.personal_devices.id
  device_type_id      = 5183 # Apple MacBook Pro 14" M3
}

resource "terrifi_client_device" "jetkvm" {
  mac              = "00:00:00:00:00:1b"
  name             = "jetkvm"
  device_type_id   = 5447 # JetKVM
  fixed_ip         = "192.168.1.26"
  network_id       = terrifi_network.internal.id
  local_dns_record = "jetkvm.example.com"
}

resource "terrifi_client_device" "joplin" {
  mac              = "00:00:00:00:00:1c"
  name             = "joplin"
  device_type_id   = 1908 # Linux
  fixed_ip         = "192.168.1.17"
  network_id       = terrifi_network.internal.id
  local_dns_record = "joplin.example.com"
}

resource "terrifi_client_device" "kitchen_air_quality_monitor" {
  mac                 = "00:00:00:00:00:1d"
  name                = "Kitchen Air Quality Monitor"
  device_type_id      = 3797 # Generic Wifi Device
  network_override_id = terrifi_network.iot.id
}

resource "terrifi_client_device" "macaroon" {
  mac              = "00:00:00:00:00:1e"
  name             = "macaroon"
  device_type_id   = 4513 # Apple Mac Mini - 2021
  fixed_ip         = "192.168.1.15"
  network_id       = terrifi_network.internal.id
  local_dns_record = "macaroon.example.com"
}

resource "terrifi_client_device" "macaroon_redwood_main_5" {
  mac                 = "00:00:00:00:00:1f"
  name                = "macaroon (myhome-main-5)"
  network_override_id = terrifi_network.personal_devices.id
  device_type_id      = 4513 # Apple Mac Mini - 2021
}

resource "terrifi_client_device" "macaroon_wi_fi" {
  mac            = "00:00:00:00:00:20"
  name           = "macaroon (mini) (Wi-Fi)"
  device_type_id = 4513 # Apple Mac Mini - 2021
}

resource "terrifi_client_device" "moen_flo_water_monitor" {
  mac            = "00:00:00:00:00:21"
  name           = "Moen Flo Water Monitor"
  device_type_id = 5501 # Moen Flo Smart Water Monitor
}

resource "terrifi_client_device" "myq_garage_door" {
  mac            = "00:00:00:00:00:22"
  name           = "MyQ Garage Door"
  device_type_id = 2874 # MyQ Garage Door Opener
}

resource "terrifi_client_device" "proxmox1" {
  mac              = "00:00:00:00:00:23"
  name             = "proxmox1"
  device_type_id   = 5254 # Proxmox
  fixed_ip         = "192.168.1.28"
  network_id       = terrifi_network.internal.id
  local_dns_record = "proxmox1.example.com"
}

resource "terrifi_client_device" "proxmox2" {
  mac              = "00:00:00:00:00:24"
  name             = "proxmox2"
  device_type_id   = 5254 # Proxmox
  fixed_ip         = "192.168.1.13"
  network_id       = terrifi_network.internal.id
  local_dns_record = "proxmox2.example.com"
}

resource "terrifi_client_device" "proxmox3" {
  mac              = "00:00:00:00:00:25"
  name             = "proxmox3"
  device_type_id   = 5254 # Proxmox
  fixed_ip         = "192.168.1.25"
  network_id       = terrifi_network.internal.id
  local_dns_record = "proxmox3.example.com"
}

resource "terrifi_client_device" "r_home_smart_mower" {
  mac            = "00:00:00:00:00:26"
  name           = "R Home Smart Mower"
  device_type_id = 3797 # Generic Wifi Device
}

resource "terrifi_client_device" "ring_base_station_ethernet" {
  mac            = "00:00:00:00:00:27"
  name           = "Ring Base Station (Ethernet)"
  device_type_id = 3546 # Ring Base Station
}

resource "terrifi_client_device" "ring_base_station_wifi" {
  mac                 = "00:00:00:00:00:28"
  name                = "Ring Base Station (Wifi)"
  device_type_id      = 3546 # Ring Base Station
  network_override_id = terrifi_network.iot.id
}

resource "terrifi_client_device" "ring_floodlight_cam" {
  mac            = "00:00:00:00:00:29"
  name           = "Ring Floodlight Cam"
  device_type_id = 2070 # Ring Floodlight Cam
  network_id     = terrifi_network.untrusted.id
  fixed_ip       = "192.168.5.55"
}

resource "terrifi_client_device" "roborock_vacuum" {
  mac                 = "00:00:00:00:00:2a"
  name                = "Roborock Vacuum"
  device_type_id      = 5223 # Roborock S8 Pro Ultra
  network_override_id = terrifi_network.iot.id
}

resource "terrifi_client_device" "roomba_i7_catmobile" {
  mac                 = "00:00:00:00:00:2b"
  name                = "Roomba i7+ (Catmobile)"
  device_type_id      = 2090 # iRobot Roomba i7
  network_override_id = terrifi_network.iot.id
}

resource "terrifi_client_device" "scrypted" {
  mac              = "00:00:00:00:00:2c"
  name             = "Scrypted"
  device_type_id   = 1908 # Linux
  fixed_ip         = "192.168.1.22"
  network_id       = terrifi_network.internal.id
  local_dns_record = "scrypted.example.com"
}

resource "terrifi_client_device" "studio_air_quality_monitor" {
  mac                 = "00:00:00:00:00:2d"
  name                = "Studio Air Quality Monitor"
  network_override_id = terrifi_network.iot.id
  device_type_id      = 3797 # Generic Wifi Device
}

resource "terrifi_client_device" "tailscale_jump_home" {
  mac              = "00:00:00:00:00:2e"
  name             = "tailscale-jump-home"
  device_type_id   = 1908 # Linux
  fixed_ip         = "192.168.1.16"
  network_id       = terrifi_network.internal.id
  local_dns_record = "tailscale-jump-home.example.com"
}

resource "terrifi_client_device" "tapo_cam_alley" {
  mac                 = "00:00:00:00:00:2f"
  name                = "Tapo Cam Alley"
  device_type_id      = 4600 # TP-Link Tapo C200
  fixed_ip            = "192.168.4.9"
  network_override_id = terrifi_network.iot.id
}

resource "terrifi_client_device" "tapo_cam_backyard" {
  mac                 = "00:00:00:00:00:30"
  name                = "Tapo Cam Backyard"
  device_type_id      = 4600 # TP-Link Tapo C200
  fixed_ip            = "192.168.4.12"
  network_override_id = terrifi_network.iot.id
}

resource "terrifi_client_device" "tapo_cam_cat_food" {
  mac                 = "00:00:00:00:00:31"
  name                = "Tapo Cam Cat Food"
  device_type_id      = 4600 # TP-Link Tapo C200
  fixed_ip            = "192.168.4.25"
  network_override_id = terrifi_network.iot.id
}

resource "terrifi_client_device" "tapo_cam_courtyard" {
  mac                 = "00:00:00:00:00:32"
  name                = "Tapo Cam Courtyard"
  device_type_id      = 4600 # TP-Link Tapo C200
  fixed_ip            = "192.168.4.13"
  network_override_id = terrifi_network.iot.id
}

resource "terrifi_client_device" "tapo_cam_front_1" {
  mac                 = "00:00:00:00:00:33"
  name                = "Tapo Cam Front 1"
  device_type_id      = 4600 # TP-Link Tapo C200
  fixed_ip            = "192.168.4.8"
  network_override_id = terrifi_network.iot.id
}

resource "terrifi_client_device" "tapo_cam_front_2" {
  mac                 = "00:00:00:00:00:34"
  name                = "Tapo Cam Front 2"
  device_type_id      = 4600 # TP-Link Tapo C200
  fixed_ip            = "192.168.4.16"
  network_override_id = terrifi_network.iot.id
}

resource "terrifi_client_device" "tapo_cam_garage" {
  mac                 = "00:00:00:00:00:35"
  name                = "Tapo Cam Garage"
  device_type_id      = 4600 # TP-Link Tapo C200
  fixed_ip            = "192.168.4.10"
  network_override_id = terrifi_network.iot.id
}

resource "terrifi_client_device" "tapo_cam_kitchen" {
  mac                 = "00:00:00:00:00:36"
  name                = "Tapo Cam Kitchen"
  device_type_id      = 4600 # TP-Link Tapo C200
  fixed_ip            = "192.168.4.11"
  network_override_id = terrifi_network.iot.id
}

resource "terrifi_client_device" "tapo_cam_sideyard_1" {
  mac                 = "00:00:00:00:00:37"
  name                = "Tapo Cam Sideyard 1"
  device_type_id      = 4600 # TP-Link Tapo C200
  fixed_ip            = "192.168.4.14"
  network_override_id = terrifi_network.iot.id
}

resource "terrifi_client_device" "tapo_cam_sideyard_2" {
  mac                 = "00:00:00:00:00:38"
  name                = "Tapo Cam Sideyard 2"
  device_type_id      = 4600 # TP-Link Tapo C200
  fixed_ip            = "192.168.4.17"
  network_override_id = terrifi_network.iot.id
}

resource "terrifi_client_device" "tapo_catio_cam" {
  mac                 = "00:00:00:00:00:39"
  name                = "Tapo Catio Cam"
  device_type_id      = 4600 # TP-Link Tapo C200
  fixed_ip            = "192.168.4.15"
  network_override_id = terrifi_network.iot.id
}

resource "terrifi_client_device" "tesla_model_y" {
  mac            = "00:00:00:00:00:3a"
  name           = "Tesla Model Y"
  device_type_id = 4726 # Tesla Model Y
}

resource "terrifi_client_device" "tesla_powerwall_89" {
  mac                 = "00:00:00:00:00:3b"
  name                = "Tesla Powerwall (00:00:00:00:00:3b)"
  device_type_id      = 3604 # Tesla Powerwall 2
  network_override_id = terrifi_network.iot.id
}

resource "terrifi_client_device" "tesla_powerwall_b8" {
  mac                 = "00:00:00:00:00:3c"
  name                = "Tesla Powerwall (00:00:00:00:00:3c)"
  device_type_id      = 3604 # Tesla Powerwall 2
  network_override_id = terrifi_network.iot.id
}

resource "terrifi_client_device" "tp_link_hs105_1" {
  mac                 = "00:00:00:00:00:3d"
  name                = "TP Link Plug HS105 1"
  device_type_id      = 2790 # TP-Link Kasa Smart Wi-Fi Plug Mini HS105
  fixed_ip            = "192.168.4.21"
  network_override_id = terrifi_network.iot.id
}

resource "terrifi_client_device" "tp_link_hs105_2" {
  mac                 = "00:00:00:00:00:3e"
  name                = "TP Link Plug HS105 2"
  device_type_id      = 2790 # TP-Link Kasa Smart Wi-Fi Plug Mini HS105
  fixed_ip            = "192.168.4.20"
  network_override_id = terrifi_network.iot.id
}

resource "terrifi_client_device" "tp_link_plug_ep25_1" {
  mac                 = "00:00:00:00:00:3f"
  name                = "TP Link Plug EP25 1"
  device_type_id      = 4919 # TP-Link Kasa Smart WiFi Plug EP25P4
  fixed_ip            = "192.168.4.23"
  network_override_id = terrifi_network.iot.id
}

resource "terrifi_client_device" "tp_link_plug_ep25_2" {
  mac                 = "00:00:00:00:00:40"
  name                = "TP Link Plug EP25 2"
  device_type_id      = 4919 # TP-Link Kasa Smart WiFi Plug EP25P4
  fixed_ip            = "192.168.4.24"
  network_override_id = terrifi_network.iot.id
}

resource "terrifi_client_device" "tp_link_plug_kp115_1" {
  mac                 = "00:00:00:00:00:41"
  name                = "TP Link Plug KP115 1"
  device_type_id      = 4721 # TP-Link KP115 Smart Plug
  fixed_ip            = "192.168.4.22"
  network_override_id = terrifi_network.iot.id
}

resource "terrifi_client_device" "truenas" {
  mac              = "00:00:00:00:00:42"
  name             = "truenas"
  device_type_id   = 4995 # TrueNAS Scale
  fixed_ip         = "192.168.1.11"
  network_id       = terrifi_network.internal.id
  local_dns_record = "truenas.example.com"
}

resource "terrifi_client_device" "truenas_ilo" {
  mac              = "00:00:00:00:00:43"
  name             = "truenas-ilo"
  device_type_id   = 1908 # Linux
  fixed_ip         = "192.168.1.10"
  network_id       = terrifi_network.internal.id
  local_dns_record = "truenas-ilo.example.com"
}

resource "terrifi_client_device" "unifi_os_server" {
  mac              = "00:00:00:00:00:44"
  name             = "unifi-os-server"
  device_type_id   = 1908 # Linux
  fixed_ip         = "192.168.1.2"
  network_id       = terrifi_network.internal.id
  local_dns_record = "unifi-os-server.example.com"
}
