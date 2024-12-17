#!/bin/bash

set -euo pipefail

# Test configuration
HOST=${HOST:-"localhost:8080"}
TEST_IMAGE=${SIGSTORE_PATH:-""}
EXPECTED_URL="https://access.redhat.com/webassets/docker/content/sigstore/${TEST_IMAGE}"

echo "Testing sigstore endpoint redirection..."
echo "Using host: ${HOST}"
echo "Test image: ${TEST_IMAGE}"

# Use curl to make the request and capture headers
# -s: silent
# -I: headers only
response=$(curl -s -I "https://${HOST}/containers/sigstore/${TEST_IMAGE}")

if [ -z "$response" ]; then
    echo -e "Test failed: No response"
    exit 1
fi
# Extract the Location header
redirect_url=$(echo "$response" | grep -i "location:" | head -n1 | awk '{print $2}' | tr -d '\r')

if [ -z "$redirect_url" ]; then
    echo -e "Test failed: No redirect URL"
    echo "Response:"
    echo "$response"
    exit 1
fi

# Check if we got a redirect (301)
if ! echo "$response" | grep -E "HTTP/1.1 301|HTTP/2 301"; then
    echo -e "Test failed: Expected 301 redirect status code"
    echo "Response:"
    echo "$response"
    exit 1
fi

# Check if redirect URL matches expected URL
if [ "$redirect_url" = "$EXPECTED_URL" ]; then
    echo -e "Test passed: Redirect URL matches expected URL"
    echo "$response"
    exit 0
else
    echo -e "Test failed: Redirect URL doesn't match expected URL"
    echo "Expected: $EXPECTED_URL"
    echo "Got:      $redirect_url"
    echo "Response:"
    echo "$response"
    exit 1
fi
