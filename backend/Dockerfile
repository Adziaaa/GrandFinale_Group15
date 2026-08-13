FROM golang:1.16

WORKDIR /app

# copy dependencies first
COPY go.mod .
COPY go.sum .
# copy source code
COPY . .

# build it
RUN go build -o backend

EXPOSE 9000

CMD ["./backend"]
