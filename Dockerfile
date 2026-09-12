FROM headscale/headscale:latest

# Create directory for state and config
RUN mkdir -p /etc/headscale /var/lib/headscale

# Copy configuration
COPY config.yaml /etc/headscale/config.yaml

EXPOSE 8080
CMD ["headscale", "serve"]
