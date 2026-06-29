# Agent Guide: registry-proxy-tests

## Purpose

Containerized acceptance tests for `quay/registry-proxy`.

## Start Here

- Entrypoint: `execute.sh`
- Pull test: `test-pull.sh`
- Sigstore redirect test: `test-sigstore.sh`
- OpenShift job: `openshift/acceptance.yaml`
- Konflux pipelines: `.tekton/`

## Common Tasks

- Add test: create a script, call it from `execute.sh`, document new env vars.
- Debug failure: check `HOST`, image/tag, credentials, `SIGSTORE_PATH`, and target proxy reachability.
- Change image: keep `Dockerfile` aligned with commands used by scripts.
- Change OpenShift job inputs: update `openshift/acceptance.yaml` parameters and README variable docs together.

## Commands

```bash
./pr-check.sh
docker run --rm -e HOST=... -e IMAGE=... -e TAG=... \
  -e REGISTRY_USERNAME=... -e REGISTRY_PASSWORD=... \
  -e SIGSTORE_PATH=... registry-proxy-test:pr-check
```

## Guardrails

- Do not commit real credentials or private image names.
- `REGISTRY_USERNAME` and `REGISTRY_PASSWORD` are live registry credentials; keep them in CI/job configuration, not source.
- Quote shell variables unless word splitting is intentional.
- Avoid sleeps; poll concrete service conditions.
