# Contributing to registry-proxy-tests

This repository provides acceptance checks for registry-proxy deployments. Keep changes focused on observable proxy behavior: image pulls, authentication requirements, and sigstore redirects.

## Running Locally

```bash
./pr-check.sh

docker run --rm \
  -e HOST=registry-proxy.example.com \
  -e IMAGE=namespace/repository \
  -e TAG=latest \
  -e REGISTRY_USERNAME=user \
  -e REGISTRY_PASSWORD=password \
  -e SIGSTORE_PATH=namespace/repository@sha256:... \
  registry-proxy-test:pr-check
```

## OpenShift

```bash
oc apply -f openshift/acceptance.yaml
oc logs -f job/registry-proxy-tests
```

Adjust names and secrets to match the target namespace.

The template parameters in `openshift/acceptance.yaml` map directly to the script environment variables. Keep those names in sync when adding inputs.

## Adding Tests

- Add a new script at the repository root or in a clearly named subdirectory.
- Call the new script from `execute.sh`.
- Document any new environment variable in `README.md` and `AGENTS.md`.
- Make failure messages specific enough for CI logs.
- Keep cleanup idempotent.

## Pull Requests

- State the registry-proxy environment tested.
- Include the image build command and run command.
- Do not commit real registry credentials, private image names, or generated logs.
