FROM golang:1.15.2-alpine
LABEL maintainer "Dongri Jin <dongri@hey.com>"

RUN apk add --no-cache alpine-sdk

RUN go get -u github.com/githubnemo/CompileDaemon

ADD . /go/src/github.com/dongri/gke
WORKDIR /go/src/github.com/dongri/gke

CMD PORT=8080 CompileDaemon -command="./gke"

EXPOSE 8080
