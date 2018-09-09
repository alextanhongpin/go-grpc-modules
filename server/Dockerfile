FROM golang:1.11-stretch as builder

WORKDIR /grpcconsul
COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -mod=vendor -o app server/server.go 


FROM alpine:3.8

RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /grpcconsul/app .

CMD ["./app"]
