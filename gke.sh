#!/bin/sh

function create() {
  echo "🍺 create cluster"
  gcloud container clusters create gke \
    --machine-type=e2-micro \
    --num-nodes=1
}

function delete() {
  echo "🍺 delete cluster"
  gcloud container clusters delete gke
}

function gcr() {
  echo "🍺 gcr auth"
  gcloud auth configure-docker
}

function image() {
  echo "🍺 push image"
  docker build -t gke .
  docker tag gke gcr.io/dongri/gke:v1
  docker push gcr.io/dongri/gke:v1
}

function apply() {
  echo "🍺 apply k8s"
  kubectl apply -f k8s/
}

case "$1" in
  create)
    create
    ;;
  gcr)
    gcr
    ;;
  image)
    image
    ;;
  apply)
    apply
    ;;
  delete)
    delete
    ;;
  *)
    echo "$ gke.sh [ create | gcr | image | apply | delete ]"
    ;;
esac
