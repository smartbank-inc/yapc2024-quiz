FROM golang:1.22.0-bullseye

WORKDIR /api-go

COPY go.mod go.sum app.go ./
RUN go build -o app app.go

CMD ["./app"]
