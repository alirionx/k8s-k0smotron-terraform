
resource "kubernetes_manifest" "k0s_cluster" {
  depends_on = [ ]
  manifest = yamldecode (
    templatefile( "./templates/k0s-cluster.yaml", {
      service_id = var.service_id
      service_namespace = var.service_namespace
      control_plane_replicas = var.control_plane_replicas
      service_endpoint_type = var.service_endpoint_type
      k0s_version = var.k0s_version
      datastore_size = var.datastore_size
    })
  )
  computed_fields = [
    "metadata.annotations",
    "metadata.labels",
  ]
  wait {
    fields = {
      "status.ready" = true
    }
  }
  timeouts {
    create = "10m"
    update = "10m"
    delete = "2m"
  }
}


resource "kubernetes_manifest" "k0s_cluster_join_token" {
  depends_on = [ kubernetes_manifest.k0s_cluster ]
  manifest = yamldecode (
    templatefile( "./templates/k0s-cluster_join-token.yaml", {
      service_id = var.service_id
      service_namespace = var.service_namespace
    })
  )
  computed_fields = [
    "metadata.annotations",
    "metadata.labels",
  ]
  wait {
    fields = {
      "status.reconciliationStatus" = "Reconciliation successful"
    }
  }
  timeouts {
    create = "3m"
    update = "3m"
    delete = "1m"
  }
}

