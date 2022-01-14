#!/bin/bash

NODE_VERSION=17
SOLIDITY_VERSION=0.8.11

echo "Building and pushing multi-arch solidity-node container..."
echo "NODE_VERSION: $NODE_VERSION"
echo "SOLIDITY_VERSION: $SOLIDITY_VERSION"

docker buildx build \
    --build-arg NODE_VERSION=$NODE_VERSION \
    --build-arg SOLIDITY_VERSION=$SOLIDITY_VERSION \
    --platform linux/amd64,linux/arm64 \
    --push \
    -t mtaleksa/solidity-node:latest \
    -t mtaleksa/solidity-node:$NODE_VERSION-$SOLIDITY_VERSION \
    .