terraform {
  backend "s3" {
    bucket                      = "redacted"
    key                         = "terrifi.tfstate"
    region                      = "auto"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
    use_path_style              = true
    endpoints                   = { s3 = "https://redacted.r2.cloudflarestorage.com" }
  }
}
