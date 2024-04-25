FROM --platform=${BUILDPLATFORM:-linux/amd64}  golang:1.22.2 as builder

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH

WORKDIR /builder

COPY --link go.mod main.go /builder/

RUN CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -ldflags="-w -s" -o staticserver main.go

FROM --platform=${TARGETPLATFORM:-linux/amd64} scratch

EXPOSE 8080

WORKDIR /app/

COPY --from=builder /builder/staticserver /staticserver
COPY index.html /var/www/index.html

ENTRYPOINT ["/staticserver"]
