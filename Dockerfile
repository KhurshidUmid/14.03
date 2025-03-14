# Use official Golang image for building
FROM golang:1.21 AS builder

# Set working directory
WORKDIR /app

# Copy go mod and sum files
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Copy the rest of the application code
COPY . .

# Build the application
RUN go build -o app main.go

# Use a minimal image for running the app
FROM alpine:latest

# Set working directory
WORKDIR /root/

# Copy the built binary from builder stage
COPY --from=builder /app/app .

# Expose port (change it if necessary)
EXPOSE 80

# Run the application
CMD ["./app"]
