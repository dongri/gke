#!/bin/sh

function create_cluster() {
  echo "🍺 create cluster"
  gcloud container clusters create gke \
    --machine-type=e2-micro \
    --num-nodes=1 \
    --region=asia-northeast1
}

function delete_cluster() {
  echo "🍺 delete cluster"
  gcloud container clusters delete gke --region=asia-northeast1
}

function gcr_auth() {
  echo "🍺 gcr auth"
  gcloud auth configure-docker
}

function image_push() {
  echo "🍺 push image"
  docker build -t gke .
  docker tag gke gcr.io/dongri/gke:v3
  docker push gcr.io/dongri/gke:v3
}

function apply_deployment() {
  echo "🍺 apply deployment"
  kubectl apply -f k8s/deployment.yml
}

function apply_service() {
  echo "🍺 apply service"
  kubectl apply -f k8s/service.yml
}

function apply_ingress() {
  echo "🍺 apply ingress"
  kubectl apply -f k8s/ingress.yml
}

case "$1" in
  create_cluster)
    create_cluster
    ;;
  delete_cluster)
    delete_cluster
    ;;
  gcr_auth)
    gcr_auth
    ;;
  image_push)
    image_push
    ;;
  apply_deployment)
    apply_deployment
    ;;
  apply_service)
    apply_service
    ;;
  apply_ingress)
    apply_ingress
    ;;
  *)
    echo "$ gke.sh [ create_cluster | delete_cluster | gcr_auth | image_push | apply_deployment | apply_service | apply_ingress ]"
    ;;
esac
