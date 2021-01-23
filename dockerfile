FROM golang:1.7.3 as BUILD1
WORKDIR /go/src/github.com/alexellis/href-counter/
RUN go get -d -v golang.org/x/net/html
COPY hello-world.go .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=BUILD1 /go/src/github.com/alexellis/href-counter/app .
CMD ["./app"]
