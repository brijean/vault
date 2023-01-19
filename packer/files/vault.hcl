storage "file" {
    path = "/opt/vault/data"
}
listener "tcp" {
 address = "0.0.0.0:8200"
 cluster_address = "0.0.0.0:8201"
 tls_disable = 1
}
api_addr = "http://0.0.0.0:8200"
ui = true
log_level = "INFO"