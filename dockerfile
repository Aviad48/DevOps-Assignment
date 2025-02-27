# Stage 1: Build
FROM node:20-alpine AS builder

WORKDIR /app
COPY package*.json /app
RUN npm install --only=production



COPY docker-test.js /app
COPY start.sh /app
COPY k8s-test.js /app
COPY start-k8s.sh /app

RUN chmod +x start.sh  # Make executable in the builder stage
RUN chmod +x start-k8s.sh 
RUN chown 1500:1500 start.sh  # Set ownership in the builder stage
RUN chown 1500:1500 start-k8s.sh  # Set ownership in the builder stage
RUN chown 1500:1500 k8s-test.js


# Stage 2: Final Image
FROM node:20-alpine

# Create the user and group before switching to them
RUN addgroup -g 1500 user && adduser -D -u 1500 -G user user \
    && apk add --no-cache ca-certificates bash vim procps curl

# Set the working directory
WORKDIR /home/user

# Copy files with correct ownership
COPY --from=builder --chown=1500:1500 /app/docker-test.js /home/user/docker-test.js
COPY --from=builder --chown=1500:1500 /app/node_modules /home/user/node_modules
COPY --from=builder --chown=1500:1500 /app/start.sh /home/user/start.sh
COPY --from=builder --chown=1500:1500 /app/start-k8s.sh /home/user/start-k8s.sh
COPY --from=builder --chown=1500:1500 /app/k8s-test.js /home/user/k8s-test.js



# Ensure start.sh is executable
RUN chmod +x /home/user/start.sh

# Switch to non-root user after all file copying
USER user

# Run the script as the user
CMD ["/bin/sh", "/home/user/start-k8s.sh"]


