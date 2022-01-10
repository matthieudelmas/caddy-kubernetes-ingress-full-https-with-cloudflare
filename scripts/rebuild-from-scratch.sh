#!/bin/bash

IMAGE=${1}
BRANCH_NAME=${2:-$(git branch | sed -n -e 's/^\* \(.*\)/\1/p' | iconv -t ascii//TRANSLIT | sed -r s/[^a-zA-Z0-9]+/-/g | sed -r s/^-+\|-+$//g | tr A-Z a-z)}
TAG=${2:-$(echo $RANDOM | md5sum | head -c 8; echo;)}

rm -rf .temp-k8s
docker build -t eu.gcr.io/gidurt-caddy-k8s-full-https/caddy-kubernetes/caddy:"${TAG}" --target caddy .
docker push eu.gcr.io/gidurt-caddy-k8s-full-https/caddy-kubernetes/caddy:"${TAG}"
kubectl delete namespace ${BRANCH_NAME}
kubectl create namespace ${BRANCH_NAME}
kubectl create serviceaccount sa-caddy --namespace ${BRANCH_NAME}
cp -r k8s .temp-k8s
sed -i -e "s/\${TAG}/${TAG}/g" .temp-k8s/caddy/*.yml
sed -i -e "s/\${BRANCH_NAME}/${BRANCH_NAME}/g" .temp-k8s/caddy/*.yml
kubectl apply -f .temp-k8s/caddy/deployment.yml -f .temp-k8s/caddy/service.yml -f .temp-k8s/caddy/ingress.yml
rm -rf .temp-k8s

