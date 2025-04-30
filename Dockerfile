# Use Caddy as base image
FROM caddy:2-alpine

# Install Node.js
RUN apk add --no-cache nodejs npm

# Create app directory
WORKDIR /usr/src/app

# Create data directory
RUN mkdir -p /data && chmod 777 /data

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy source code
COPY . .

# Copy Caddyfile
COPY Caddyfile /etc/caddy/Caddyfile

# Expose ports
EXPOSE 80 443

# Start both Caddy and Node.js server
CMD ["sh", "-c", "node css-exfiltrator-server.js & caddy run --config /etc/caddy/Caddyfile"] 