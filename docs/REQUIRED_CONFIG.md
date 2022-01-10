# Required configuration

## GCP

You will need a GCP project with : 
- private GKE cluster on project
- google static IP (the name needs to match with k8s/ingress.yml annotation)
- [pre-shared cert on google](https://cloud.google.com/kubernetes-engine/docs/how-to/ingress-multi-ssl#pre-shared-certs) or other GLB certs  (the name needs to match with k8s/ingress.yml annotation)

## Cloudflare (or other DNS provider will work)

- you need to register your domain and manage it with cloudflare
- Add the google static IP as DNS record type A