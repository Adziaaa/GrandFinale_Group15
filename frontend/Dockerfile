FROM golang:1.16

WORKDIR /app

# copy the go.mod file first
COPY go.mod .
# then copy everything else
COPY . .

# build the application
RUN go build -o frontend

EXPOSE 8080

CMD ["./frontend"]
