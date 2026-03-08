terraform {
  required_providers {
    terrifi = {
      source  = "alexklibisz/terrifi"
      version = "0.2.0"
    }
  }
}

provider "terrifi" {
  response_caching = true
}
