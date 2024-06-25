variable "kube_api_url" {
  type = string
}

variable "kube_token" {
  type = string
}

variable "k0s_version" {
  type = string
#   default = "v1.30.2-k0s.0"
}
variable "control_plane_replicas" {
  type = number
  default = 2
}

variable "service_id" {
  type = string
  default = "k0smotron-controlplane"
}

variable "service_namespace" {
  type = string
  default = "default"
}

variable "service_endpoint_type" {
  type = string
  default = "ClusterIP"
}

variable "datastore_size"{
  type = number
  default = 1
  description = "Datastore size in GB ( min 1 - max 10 )"
}