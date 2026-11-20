FROM golang:1.23 AS builder
WORKDIR /go/src/github.com/prometheus-community/jiralert
COPY . /go/src/github.com/prometheus-community/jiralert
RUN go mod tidy && GO111MODULE=on GOBIN=/tmp/bin make


# Multi-arch busybox: the shared build workflow now builds linux/amd64 and
# linux/arm64, and busybox-linux-amd64 only has an amd64 image (SRE-3657).
FROM quay.io/prometheus/busybox:latest

COPY --from=builder /go/src/github.com/prometheus-community/jiralert/jiralert /bin/jiralert
COPY /examples/jiralert.tmpl /config/jiralert.tmpl
COPY /examples/jiralert.sh /config/jiralert.sh

CMD ["./config/jiralert.sh"]
