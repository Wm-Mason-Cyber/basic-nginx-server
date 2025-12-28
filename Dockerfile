# Use a slim version of the official Nginx image
FROM nginx:1.21.6-alpine

# Install openssl
RUN apk add --no-cache openssl

# Create a directory for the certificates
RUN mkdir -p /etc/nginx/certs

# Generate self-signed certificates
RUN openssl req -x509 -newkey rsa:4096 -keyout /etc/nginx/certs/server.key -out /etc/nginx/certs/server.crt -sha256 -days 365 -nodes -subj "/C=US/ST=Virginia/L=Williamsburg/O=William & Mary/OU=Cyber/CN=localhost"

# Remove default Nginx configuration
RUN rm /etc/nginx/conf.d/default.conf

# Copy the static site content to the Nginx html directory
COPY site/ /usr/share/nginx/html/

# Copy the Nginx configuration files
COPY nginx/ /etc/nginx/



# Expose port 80 for HTTP and 443 for HTTPS
EXPOSE 80
EXPOSE 443

COPY scripts/start.sh /usr/local/bin/start.sh

# Make start.sh executable
RUN chmod +x /usr/local/bin/start.sh

# Start Nginx when the container launches
CMD ["/usr/local/bin/start.sh"]
