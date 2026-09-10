FROM registry.redhat.io/ubi9/podman:9.8-1789046121@sha256:0815a8802fb736b5892004517d35da987d53b1d89f2f9014b700c83e08f3da8b

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
