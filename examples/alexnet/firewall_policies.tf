locals {
  tapo_cam_mac_addresses = [
    terrifi_client_device.tapo_cam_front_1.mac,
    terrifi_client_device.tapo_cam_alley.mac,
    terrifi_client_device.tapo_cam_kitchen.mac,
    terrifi_client_device.tapo_cam_garage.mac,
    terrifi_client_device.tapo_cam_courtyard.mac,
    terrifi_client_device.tapo_cam_backyard.mac,
    terrifi_client_device.tapo_cam_sideyard_1.mac,
    terrifi_client_device.tapo_cam_front_2.mac,
    terrifi_client_device.tapo_cam_sideyard_2.mac,
    terrifi_client_device.tapo_cam_cat_food.mac
  ]

  smart_plug_mac_addresses = [
    terrifi_client_device.tp_link_hs105_1.mac,
    terrifi_client_device.tp_link_hs105_2.mac,
    terrifi_client_device.tp_link_plug_ep25_1.mac,
    terrifi_client_device.tp_link_plug_ep25_2.mac,
    terrifi_client_device.tp_link_plug_kp115_1.mac
  ]
}

# IOT / Personal Devices

resource "terrifi_firewall_policy" "allow_some_personal_devices_to_iot" {
  name                 = "✅ Some Personal Devices to IoT"
  action               = "ALLOW"
  create_allow_respond = true

  source {
    zone_id = terrifi_firewall_zone.personal_devices.id
    device_ids = [
      terrifi_client_device.akmbpro2021_redwood_main_5.mac
    ]
  }

  destination {
    zone_id = terrifi_firewall_zone.iot.id
  }
}

resource "terrifi_firewall_policy_order" "personal_devices_to_iot" {
  source_zone_id      = terrifi_firewall_zone.personal_devices.id
  destination_zone_id = terrifi_firewall_zone.iot.id
  policy_ids = [
    terrifi_firewall_policy.allow_some_personal_devices_to_iot.id
  ]
}

# Apple Home / Internal

resource "terrifi_firewall_policy" "allow_some_apple_home_to_some_internal" {
  name                 = "✅ Some Apple Home to Some Internal"
  action               = "ALLOW"
  create_allow_respond = true

  source {
    zone_id = terrifi_firewall_zone.apple_home.id
    device_ids = [
      terrifi_client_device.apple_tv_living_room.mac,
      terrifi_client_device.apple_homepod_mini_studio.mac
    ]
  }

  destination {
    zone_id = terrifi_firewall_zone.internal.id
    ips = [
      terrifi_client_device.alex_desk_hub.fixed_ip,
      terrifi_client_device.apple_tv_garage.fixed_ip,
      terrifi_client_device.home_assistant.fixed_ip,
      terrifi_client_device.macaroon.fixed_ip,
      terrifi_client_device.scrypted.fixed_ip
    ]
  }
}

resource "terrifi_firewall_policy" "allow_some_internal_to_apple_home" {
  name                 = "✅ Some Internal to Apple Home"
  action               = "ALLOW"
  create_allow_respond = true

  source {
    zone_id = terrifi_firewall_zone.internal.id
    device_ids = [
      terrifi_client_device.alex_desk_hub.mac,
      terrifi_client_device.apple_tv_garage.mac,
      terrifi_client_device.home_assistant.mac,
      terrifi_client_device.macaroon.mac
    ]
  }

  destination {
    zone_id = terrifi_firewall_zone.apple_home.id
  }
}

resource "terrifi_firewall_policy_order" "apple_home_to_internal" {
  source_zone_id      = terrifi_firewall_zone.apple_home.id
  destination_zone_id = terrifi_firewall_zone.internal.id
  policy_ids = [
    terrifi_firewall_policy.allow_some_apple_home_to_some_internal.id
  ]
}

resource "terrifi_firewall_policy_order" "internal_to_apple_home" {
  source_zone_id      = terrifi_firewall_zone.internal.id
  destination_zone_id = terrifi_firewall_zone.apple_home.id
  policy_ids = [
    terrifi_firewall_policy.allow_some_internal_to_apple_home.id
  ]
}

# Apple Home / Personal Devices

resource "terrifi_firewall_policy" "allow_apple_home_to_personal_devices" {
  name                 = "✅ Apple Home to Personal Devices"
  action               = "ALLOW"
  create_allow_respond = true

  source {
    zone_id = terrifi_firewall_zone.apple_home.id
  }

  destination {
    zone_id = terrifi_firewall_zone.personal_devices.id
  }
}

resource "terrifi_firewall_policy" "allow_personal_devices_to_apple_home" {
  name                 = "✅ Personal Devices to Apple Home"
  action               = "ALLOW"
  create_allow_respond = true

  source {
    zone_id = terrifi_firewall_zone.personal_devices.id
  }

  destination {
    zone_id = terrifi_firewall_zone.apple_home.id
  }
}

resource "terrifi_firewall_policy_order" "apple_home_to_personal_devices" {
  source_zone_id      = terrifi_firewall_zone.apple_home.id
  destination_zone_id = terrifi_firewall_zone.personal_devices.id
  policy_ids = [
    terrifi_firewall_policy.allow_apple_home_to_personal_devices.id
  ]
}

resource "terrifi_firewall_policy_order" "personal_devices_to_apple_home" {
  source_zone_id      = terrifi_firewall_zone.personal_devices.id
  destination_zone_id = terrifi_firewall_zone.apple_home.id
  policy_ids = [
    terrifi_firewall_policy.allow_personal_devices_to_apple_home.id
  ]
}

# Apple Home / IoT

resource "terrifi_firewall_policy" "allow_some_apple_home_to_some_iot" {
  name                 = "✅ Some Apple Home to Some IoT"
  action               = "ALLOW"
  create_allow_respond = true

  source {
    zone_id = terrifi_firewall_zone.apple_home.id
    device_ids = [
      terrifi_client_device.apple_tv_living_room.mac,
      terrifi_client_device.apple_homepod_mini_studio.mac
    ]
  }

  destination {
    zone_id = terrifi_firewall_zone.iot.id
    ips = [
      terrifi_client_device.aqara_hub_m100.fixed_ip,
    ]
  }
}

resource "terrifi_firewall_policy_order" "apple_home_to_iot" {
  source_zone_id      = terrifi_firewall_zone.apple_home.id
  destination_zone_id = terrifi_firewall_zone.iot.id
  policy_ids = [
    terrifi_firewall_policy.allow_some_apple_home_to_some_iot.id
  ]
}

# External / IoT

resource "terrifi_firewall_policy" "block_tapo_cams_to_external" {
  name        = "❌ Tapo Cams to External"
  action      = "BLOCK"
  description = "Block all traffic from the Tapo cameras to the external network, except for NTP traffic which is required for the cameras to function properly."

  source {
    zone_id    = terrifi_firewall_zone.iot.id
    device_ids = local.tapo_cam_mac_addresses
  }

  destination {
    zone_id              = terrifi_firewall_zone.external.id
    port_matching_type   = "OBJECT"
    port_group_id        = terrifi_firewall_group.ntp_ports.id
    match_opposite_ports = true
  }
}

resource "terrifi_firewall_policy" "block_smart_plugs_to_external" {
  name        = "❌ Smart Plugs to External"
  action      = "BLOCK"
  description = "Block all traffic from smart plugs to the external network."

  source {
    zone_id    = terrifi_firewall_zone.iot.id
    device_ids = local.smart_plug_mac_addresses
  }

  destination {
    zone_id = terrifi_firewall_zone.external.id
  }
}

resource "terrifi_firewall_policy_order" "iot_to_external" {
  source_zone_id      = terrifi_firewall_zone.iot.id
  destination_zone_id = terrifi_firewall_zone.external.id
  policy_ids = [
    terrifi_firewall_policy.block_tapo_cams_to_external.id,
    terrifi_firewall_policy.block_smart_plugs_to_external.id
  ]
}

# Internal / Internal

resource "terrifi_firewall_policy" "block_ring_ethernet_to_internal" {
  name   = "❌ Ring Ethernet to Internal"
  action = "BLOCK"

  source {
    zone_id = terrifi_firewall_zone.internal.id
    device_ids = [
      terrifi_client_device.ring_base_station_ethernet.mac
    ]
  }

  destination {
    zone_id = terrifi_firewall_zone.internal.id
  }
}

resource "terrifi_firewall_policy_order" "internal_to_internal" {
  source_zone_id      = terrifi_firewall_zone.internal.id
  destination_zone_id = terrifi_firewall_zone.internal.id
  policy_ids = [
    terrifi_firewall_policy.block_ring_ethernet_to_internal.id
  ]
}

# Internal / IoT

resource "terrifi_firewall_policy" "allow_some_internal_to_iot" {
  name                 = "✅ Some Internal to IoT"
  action               = "ALLOW"
  create_allow_respond = true

  source {
    zone_id = terrifi_firewall_zone.internal.id
    device_ids = [
      terrifi_client_device.home_assistant.mac,
      terrifi_client_device.alex_desk_hub.mac,
      terrifi_client_device.apple_tv_garage.mac,
      terrifi_client_device.scrypted.mac
    ]
  }

  destination {
    zone_id = terrifi_firewall_zone.iot.id
  }
}

resource "terrifi_firewall_policy_order" "internal_to_iot" {
  source_zone_id      = terrifi_firewall_zone.internal.id
  destination_zone_id = terrifi_firewall_zone.iot.id
  policy_ids = [
    terrifi_firewall_policy.allow_some_internal_to_iot.id
  ]
}

resource "terrifi_firewall_policy" "allow_iot_to_some_internal" {
  name                 = "✅ IoT to Some Internal"
  action               = "ALLOW"
  create_allow_respond = true

  source {
    zone_id = terrifi_firewall_zone.iot.id
  }

  destination {
    zone_id = terrifi_firewall_zone.internal.id
    ips = [
      terrifi_client_device.apple_tv_garage.fixed_ip,
      terrifi_client_device.home_assistant.fixed_ip,
      terrifi_client_device.scrypted.fixed_ip
    ]
  }
}

resource "terrifi_firewall_policy_order" "iot_to_internal" {
  source_zone_id      = terrifi_firewall_zone.iot.id
  destination_zone_id = terrifi_firewall_zone.internal.id
  policy_ids = [
    terrifi_firewall_policy.allow_iot_to_some_internal.id
  ]
}

# Internal / Personal Devices

resource "terrifi_firewall_policy" "allow_some_internal_to_personal_devices" {
  name                 = "✅ Some Internal to Personal Devices"
  action               = "ALLOW"
  create_allow_respond = true

  source {
    zone_id = terrifi_firewall_zone.internal.id
    device_ids = [
      terrifi_client_device.apple_tv_garage.mac,
      terrifi_client_device.macaroon.mac
    ]
  }

  destination {
    zone_id = terrifi_firewall_zone.personal_devices.id
  }
}

resource "terrifi_firewall_policy" "allow_personal_devices_to_some_internal" {
  name                 = "✅ Personal Devices to Some Internal"
  action               = "ALLOW"
  create_allow_respond = true

  source {
    zone_id = terrifi_firewall_zone.personal_devices.id
  }

  destination {
    zone_id = terrifi_firewall_zone.internal.id
    ips = [
      terrifi_client_device.apple_tv_garage.fixed_ip,
      terrifi_client_device.cusdis.fixed_ip,
      terrifi_client_device.devbox.fixed_ip,
      terrifi_client_device.home_assistant.fixed_ip,
      terrifi_client_device.macaroon.fixed_ip,
      terrifi_client_device.joplin.fixed_ip,
      terrifi_client_device.proxmox1.fixed_ip,
      terrifi_client_device.proxmox2.fixed_ip,
      terrifi_client_device.proxmox3.fixed_ip,
      terrifi_client_device.scrypted.fixed_ip,
      terrifi_client_device.tailscale_jump_home.fixed_ip,
      terrifi_client_device.truenas.fixed_ip,
      terrifi_client_device.unifi_os_server.fixed_ip
    ]
  }
}

resource "terrifi_firewall_policy_order" "internal_to_personal_devices" {
  source_zone_id      = terrifi_firewall_zone.internal.id
  destination_zone_id = terrifi_firewall_zone.personal_devices.id
  policy_ids = [
    terrifi_firewall_policy.allow_some_internal_to_personal_devices.id
  ]
}

resource "terrifi_firewall_policy_order" "personal_devices_to_internal" {
  source_zone_id      = terrifi_firewall_zone.personal_devices.id
  destination_zone_id = terrifi_firewall_zone.internal.id
  policy_ids = [
    terrifi_firewall_policy.allow_personal_devices_to_some_internal.id
  ]
}
