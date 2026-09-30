FROM registry.redhat.io/ubi9/podman:9.8-1790645735@sha256:e17e8d9baea9b9119f4cf4cbdaebb6a1d2b1cbc2a69af0b8c2e1ce270362ff26

LABEL com.redhat.component="registry-proxy-tests" \
      description="Registry proxy test suite for Quay.io" \
      distribution-scope="public" \
      io.k8s.description="Registry proxy test suite for Quay.io" \
      release="1" \
      url="https://github.com/quay/registry-proxy-tests" \
      vendor="Red Hat, Inc." \
      name="registry-proxy-tests"

ENV HOME=/home/podman
RUN mkdir -p /home/podman/.config/containers && \
    chmod -R 777 /home/podman

# Copy the test script
COPY test-sigstore.sh /test-sigstore.sh
RUN chmod +x /test-sigstore.sh

COPY test-pull.sh /test-pull.sh
RUN chmod +x /test-pull.sh

COPY execute.sh /execute.sh
RUN chmod +x /execute.sh

ENTRYPOINT ["/execute.sh"]
