# Registry Proxy Tests

Test scripts to be used as acceptance criteria for registry proxy deployments

## Usage
Build and run the scripts locally using podman/docker:

```
docker build -t registry-proxy-tests .

docker run -e HOST={HOST} \
-e IMAGE={IMAGE} \
-e TAG={TAG} \
-e REGISTRY_USERNAME={REGISTRY_USERNAME} \
-e REGISTRY_PASSWORD={REGISTRY_PASSWORD} \
registry-proxy-tests
```
