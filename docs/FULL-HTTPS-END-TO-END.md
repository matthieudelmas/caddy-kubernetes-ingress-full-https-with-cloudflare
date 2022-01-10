# Full https end-to-end

![schema](https://user-images.githubusercontent.com/95386861/148813601-614fc92f-3789-4d2a-b3e0-bc473b45421c.png)

As you can see, there are multiple certificat depending which step you are to setup full https end to end :

### step 1 : Browser => 🔒 Cloudflare
[cloudflare certificat](https://support.cloudflare.com/hc/fr-fr/articles/360019093151-Gestion-des-enregistrements-DNS-dans-Cloudflare) : automatically with «proxied» option. Setup SSL/TLS encryption mode as «Full (strict)».
### step 2 : Cloudflare => 🔒 Ingress
[ingress certificat](https://cloud.google.com/kubernetes-engine/docs/how-to/ingress-multi-ssl#specifying_certificates_for_your_ingress) : we are using mkcert then upload pre-shared cert to gcp on deployment same namespace.

*For production please use own trusted cert or create google managed cert. We are using mkcert here just to show you how this work.*

### step 3 : Ingress => 🔒 Caddy Server

[caddy certificat](https://caddyserver.com/docs/caddyfile/directives/tls), tls mode choice : 
- tls internal to use Caddy's internal, locally-trusted CA to produce certificates for this site (*not for production ! please prefer letsencrypt or custom cert*)
- letsencrypt to generate publicly-trusted certificates
- custom cert+key to upload your own trusted certificate

*For production please use own cert or generate one with Letsencrypt for a publicly-trusted certificate. This repository is just example configuration of caddy https with ingress etc.. using `tls internal` to simplify.*

