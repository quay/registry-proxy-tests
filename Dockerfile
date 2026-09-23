FROM registry.redhat.io/ubi9/podman:9.8-1790171163@sha256:8ac33cec5d778ba8eae43dc608fdeab785b9ba63aee1285968f39426bbfa77fe

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
