# Use the official nginx image as the base
FROM nginx:alpine

# Copy the index.html into the default nginx html folder
COPY src/ /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Start nginx in the foreground (default command)
CMD ["nginx", "-g", "daemon off;"]

