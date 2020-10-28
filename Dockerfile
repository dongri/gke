FROM golang:1.15.2-alpine
LABEL maintainer "Dongri Jin <dongri@hey.com>"

RUN apk add --no-cache alpine-sdk

ADD . /go/src/github.com/dongri/gke
WORKDIR /go/src/github.com/dongri/gke

# Build the binary.
RUN go mod download
RUN go build -mod=readonly -v -o server

CMD ["/go/src/github.com/dongri/gke/server"]

EXPOSE 8080
