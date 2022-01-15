ARG NODE_VERSION=16
ARG SOLIDITY_VERSION=0.8.11

# # # # # # # # # # # # # # # # # # 
# SETUP ZSH, NODE, TRUFFLE, GANACHE
# # # # # # # # # # # # # # # # # # 
FROM node:${NODE_VERSION}-alpine
# setup shell environment: zsh, oh-my-zsh and plugins, nano
RUN apk --update --no-cache add zsh git curl nano
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
COPY docker-zshrc /root/.zshrc
RUN touch /root/.z
RUN sed -i 's/\/bin\/ash/\/bin\/zsh/g' /etc/passwd
# install truffle and ganache-cli
RUN apk add --no-cache python3 gcc g++ make git
RUN npm install -g truffle ganache-cli
ENTRYPOINT [ "/bin/zsh" ]