provider "kubernetes" {
  host = var.kube_api_url
  # token = var.kube_token
  config_path    = var.kube_config_path
  insecure = true
}