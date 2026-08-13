# Build stage
FROM golang:1.21 AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o backend .

# Runtime stage
FROM alpine:3.20

WORKDIR /app

COPY --from=builder /app/backend .

EXPOSE 9000

CMD ["./backend"]