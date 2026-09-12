FROM headscale/headscale:latest

# Create directory for state and config
RUN mkdir -p /etc/headscale /var/lib/headscale

# Copy configuration
COPY config.yaml /etc/headscale/config.yaml

EXPOSE 8080
EXPOSE 50443/udp

# Health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD headscale v 2>/dev/null || exit 1

CMD ["headscale", "serve"]
