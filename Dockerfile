FROM golang:1.15 AS builder
WORKDIR /go/src/github.com/prometheus-community/jiralert
COPY . /go/src/github.com/prometheus-community/jiralert
RUN GO111MODULE=on GOBIN=/tmp/bin make

FROM quay.io/prometheus/busybox-linux-amd64:latest

COPY --from=builder /go/src/github.com/prometheus-community/jiralert/jiralert /bin/jiralert
COPY /examples/jiralert.tmpl /config/jiralert.tmpl
COPY /examples/jiralert.sh /config/jiralert.sh

CMD ["./config/jiralert.sh"]

