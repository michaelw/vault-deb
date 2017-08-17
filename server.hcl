listener "tcp" {
  address       = "127.0.0.1:8200"
  tls_disable   = 1
  # tls_cert_file = "/etc/ssl/certs/vault.crt"
  # tls_key_file  = "/etc/ssl/private/vault.key"
  # tls_client_ca_file = ""
  # tls_require_and_verify_client_cert = "false"
}

storage "file" {
  path = "/var/lib/vault/data"
}

# storage "consul" {
#   address = "127.0.0.1:8500"
#   path    = "vault"
# }

# telemetry {
#   statsite_address = "127.0.0.1:8125"
#   disable_hostname = true
# }
