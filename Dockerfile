# Dockerfile

# Base image
FROM gcc:13

# Set working directory
WORKDIR /app

# Copy all files
COPY . .

# Build project
RUN make

# Expose port (we'll map this at runtime, so no need to hardcode)
EXPOSE 8080

# Default entrypoint to the built server
ENTRYPOINT ["./proxy_server"]
