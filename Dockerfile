ARG GO_VERSION=1.17
ARG NODE_VERSION=17
ARG SOLIDITY_VERSION=0.8.11

# # # # # # # # # # # # # # # # # # 
# BUILD SOLC
# # # # # # # # # # # # # # # # # # 
FROM golang:${GO_VERSION}-alpine AS solc
ARG SOLIDITY_VERSION
RUN apk --update add --virtual build-dependencies curl g++ make cmake boost-dev boost-static z3-dev
WORKDIR /go/src/github.com/solc
RUN curl -fsSLO https://github.com/ethereum/solidity/releases/download/v${SOLIDITY_VERSION}/solidity_${SOLIDITY_VERSION}.tar.gz
RUN tar -xzf solidity_${SOLIDITY_VERSION}.tar.gz && rm solidity_${SOLIDITY_VERSION}.tar.gz
RUN cd solidity_${SOLIDITY_VERSION} && mkdir build && cd build && cmake .. && make
RUN cp /go/src/github.com/solc/solidity_${SOLIDITY_VERSION}/build/solc/solc /go/bin/solc

# # # # # # # # # # # # # # # # # # 
# SETUP ZSH, NODE, TRUFFLE, GANACHE, SOLC
# # # # # # # # # # # # # # # # # # 
FROM node:${NODE_VERSION}-alpine
# setup shell environment: zsh, oh-my-zsh and plugins, nano
RUN apk --no-cache add zsh git curl nano
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
COPY docker-zshrc /root/.zshrc
RUN touch /root/.z
RUN sed -i 's/\/bin\/ash/\/bin\/zsh/g' /etc/passwd
# copy solc binary
COPY --from=solc /go/bin/solc /bin/solc
# install truffle, ganache-cli
RUN npm install -g truffle ganache-cli coveralls
ENTRYPOINT [ "/bin/zsh" ]