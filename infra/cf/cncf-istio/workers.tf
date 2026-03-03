resource "cloudflare_workers_script" "registry_redirect_istio" {
  account_id         = var.account_id
  script_name        = "registry-redirect-istio" # is this right?
  content_file       = "./registry-redirector/dist/index.js"
  content_sha256     = filesha256("./registry-redirector/dist/index.js")
  main_module        = "index.js"
  compatibility_date = "2025-12-02"
  observability = {
    enabled = true
  }

  bindings = [{
    name = "TARGET_REGISTRIES"
    json = jsonencode({
      "registry-redirect-istio.cncf-istio.workers.dev" = { mappings = local.istio_registry_mappings }
      "registry.istio.io"                              = { mappings = local.istio_registry_mappings }
    })
    type = "json"
    },
    {
      name    = "IMAGE_PULLS"
      type    = "analytics_engine"
      dataset = "image_pulls"
  }]
}

resource "cloudflare_workers_route" "registry_redirect_istio" {
  zone_id    = var.zone_id
  pattern    = "registry.istio.io/*"
  script     = cloudflare_workers_script.registry_redirect_istio.id
}
