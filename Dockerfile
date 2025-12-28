# Use a slim version of the official Nginx image
FROM nginx:1.21.6-alpine

# Remove default Nginx configuration
RUN rm /etc/nginx/conf.d/default.conf

# Copy the static site content to the Nginx html directory
COPY site/ /usr/share/nginx/html/

# Copy the Nginx configuration files
COPY nginx/ /etc/nginx/

# Expose port 80 for HTTP and 443 for HTTPS
EXPOSE 80
EXPOSE 443

# Start Nginx when the container launches
CMD ["nginx", "-g", "daemon off;"]
