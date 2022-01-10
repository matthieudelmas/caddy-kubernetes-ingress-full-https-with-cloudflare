# Project installation

## Prerequisite

To run this project, please check [required configuration](REQUIRED_CONFIG.md)

## Installation step by step

- clone project : `git clone git@github.com:matthieudelmas/caddy-kubernetes-ingress-full-https-with-cloudflare.git`
- go to project : `cd caddy-kubernetes-ingress-full-https-with-cloudflare`

## Run project locally

- start caddy : `docker-compose up --build --force-recreate`
- check url ✅ :
   - [HTTP](http://caddy-kubernetes-ingress-full-https-with-cloudflare.localhost)
   - [HTTPS](https://caddy-kubernetes-ingress-full-https-with-cloudflare.localhost)

## Deploy GCP

replace variables :
- replace ${NAMESPACE} in k8s/caddy/*.yml
- ingress.yml host replace yourdomain.example.com with your domain
- deployment.yml image ${GCR_PROJECT_IMAGE}, ${GCR_FOLDER_IMAGE} and ${GCR_TAG_IMAGE}
- deployment.yml environment variable SERVER_NAME replace yourdomain.example.com with your domain

### 1. Generate certificate
- [Install mkcert](https://github.com/FiloSottile/mkcert#installation)
- generate cert+key : `mkcert yourdomaine.example.com`
- upload cert (with key) as [Google pre-shared certificate](https://cloud.google.com/kubernetes-engine/docs/how-to/ingress-multi-ssl#specifying_certificates_for_your_ingress) *(note : It must have same name as kubernetes.io/ingress.global-static-ip-name ingress annotation value)*

### 2. Build image to GCR
- build docker image : `docker build -t eu.gcr.io/your-gcp-project/your-gcr-folder/caddy:yourtag --target caddy .`
- push builded image to registry`docker push eu.gcr.io/your-gcp-project/your-gcr-folder/caddy:yourtag`

### 3. Deployment kubernetes
- create k8s namespace : `kubectl create namespace yournamespace`
- deploy k8s : `kubectl apply -f k8s/caddy/deployment.yml -f k8s/caddy/service.yml -f k8s/caddy/ingress.yml`

### 4. Test
- check urls ✅ :
    - [HTTP](http://yourdomain.example.com)
    - [HTTPS](https://yourdomain.example.com)
