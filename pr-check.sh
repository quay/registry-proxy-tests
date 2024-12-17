#!/bin/bash
set -exv

BASE_IMG="registry-proxy-test"

IMG="${BASE_IMG}:pr-check"

docker build -t "${IMG}" -f Dockerfile .
