# CNCF Istio Cloudflare

We have a Cloudflare worker that redirects registry.istio.io to a configurable container registry.
The code for the Cloudflare worker lives in [here](https://github.com/howardjohn/registry-redirector).
To apply terraform, first clone the registry redirector:

```bash
git clone https://github.com/howardjohn/registry-redirector.git
```

Then build the registry redirector

```bash
cd registry-redirector
wrangler build
```

Then, configure credentials. See the [Terraform docs](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs#schema).

Finally, you can apply the terraform in this directory, which will upload the worker to Cloudflare and set up the DNS records.

```bash
terraform init  # If you haven't done so already
terraform plan
terraform apply
```
