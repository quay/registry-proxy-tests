FROM registry.redhat.io/ubi9/podman:9.7@sha256:4da223c28f0eae7806738f7430ced585d616f98d0de0b6f5b0de9d9f67f45503

LABEL com.redhat.component="registry-proxy-tests" \
      description="Registry proxy test suite for Quay.io" \
      distribution-scope="public" \
      io.k8s.description="Registry proxy test suite for Quay.io" \
      release="1" \
      url="https://github.com/quay/registry-proxy-tests" \
      vendor="Red Hat, Inc." \
      name="registry-proxy-tests"

# Copy the test script
COPY test-sigstore.sh /test-sigstore.sh
RUN chmod +x /test-sigstore.sh

COPY test-pull.sh /test-pull.sh
RUN chmod +x /test-pull.sh

COPY execute.sh /execute.sh
RUN chmod +x /execute.sh

ENTRYPOINT ["/execute.sh"]
