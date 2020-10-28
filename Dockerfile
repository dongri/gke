FROM golang:1.15.2-alpine
LABEL maintainer "Dongri Jin <dongri@hey.com>"

RUN apk add --no-cache alpine-sdk

ADD . /go/src/github.com/dongri/gke
WORKDIR /go/src/github.com/dongri/gke
RUN go install -v .

EXPOSE 8080

CMD ["/go/bin/gke"]

