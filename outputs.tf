
# output "service_enpoint_info_json" {
#   depends_on = [ ]
#   value = jsonencode( 
#     {
#      "test": "test"
#     }
#   )
# }



data "kubernetes_resource" "k0s_cluster_service_lb" {
  depends_on = [ kubernetes_manifest.k0s_cluster ]
  api_version = "v1"
  kind        = "Service"
  metadata {
    name      = "kmc-k0smotron-palim-lb"
    namespace = "default"
  }
}

data "kubernetes_resource" "k0s_cluster_join_token_secret" {
  depends_on = [ kubernetes_manifest.k0s_cluster_join_token ]
  api_version = "v1"
  kind        = "Secret"
  metadata {
    name      = "k0smotron-palim-token"
    namespace = "default"
  }
}

data "kubernetes_resource" "k0s_cluster_join_kubeconfig" {
  depends_on = [ kubernetes_manifest.k0s_cluster_join_token ]
  api_version = "v1"
  kind        = "Secret"
  metadata {
    name      = "k0smotron-palim-kubeconfig"
    namespace = "default"
  }
}

output "test" {
  value = {
    external_ip = data.kubernetes_resource.k0s_cluster_service_lb.object.status.loadBalancer.ingress[0].ip
    internal_ip = data.kubernetes_resource.k0s_cluster_service_lb.object.spec.clusterIP
    k8s_api_port = data.kubernetes_resource.k0s_cluster_service_lb.object.spec.ports[0].port
    k8s_konnectivity_port = data.kubernetes_resource.k0s_cluster_service_lb.object.spec.ports[1].port
    cluster_join_token = base64decode(data.kubernetes_resource.k0s_cluster_join_token_secret.object.data.token)
    kubeconfig = base64decode(data.kubernetes_resource.k0s_cluster_join_kubeconfig.object.data.value)
  }
}