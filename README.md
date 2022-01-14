# Solidity-Node Development Docker Image

Docker image for Solidity development that includes:
- Node.js
- Truffle
- Ganache-cli
- Solidity-Compiler (solc)
- zsh, oh-my-zsh, and helpful plugins

---

## Tags

<b>current (17-0.8.11)</b>
- Node: 17
- solc: 0.8.11

---

## Build Instructions

Node and solc versions can be passed as arguments to the docker build command.

The supplied `build-and-push.sh` script can be used to initiate a multi-arch build (linux/arm64, linux/amd64) and push to dockerhub.