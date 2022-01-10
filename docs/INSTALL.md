# Project installation

## Prerequisite

To run this project, please check [required configuration](REQUIRED_CONFIG.md)

## Installation step by step

- clone project : `git clone git@github.com:matthieudelmas/caddy-kubernetes-ingress-full-https-with-cloudflare.git`
- go to project : `cd caddy-kubernetes-ingress-full-https-with-cloudflare`

## Run project locally

- start caddy : `docker-compose up --build --force-recreate`
- check urls ✅ :
   - [HTTP](http://caddy-kubernetes-ingress-full-https-with-cloudflare.localhost)
   - [HTTPS](https://caddy-kubernetes-ingress-full-https-with-cloudflare.localhost)

## Deploy GCP

- build docker image : `docker build -t eu.gcr.io/your-gcp-project/your-gcr-folder/caddy:yourtag --target caddy .`
- push builded image to registry`docker push eu.gcr.io/your-gcp-project/your-gcr-folder/caddy:yourtag`
- create k8s namespace : `kubectl create namespace yournamespace`
- create k8s SA : `kubectl create serviceaccount sa-caddy --namespace yournamespace`
- deploy k8s : `kubectl apply -f k8s/caddy/deployment.yml -f k8s/caddy/service.yml -f k8s/caddy/ingress.yml`

- check urls ✅ :
    - [HTTP](http://yourdomain.example.com)
    - [HTTPS](https://yourdomain.example.com)