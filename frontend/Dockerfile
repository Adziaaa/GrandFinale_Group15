FROM golang:1.21 AS builder

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o frontend .

FROM alpine:3.20

WORKDIR /app

COPY --from=builder /app/frontend .
COPY static ./static
COPY templates ./templates

EXPOSE 8080

ENV BACKEND_DNS=backend
ENV BACKEND_PORT=9000

CMD ["./frontend"]