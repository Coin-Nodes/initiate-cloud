#!/usr/bin/env bash

# Fail on any error
set -e

# Variáveis de versão
NVM_VERSION="v0.39.5"
NODE_VERSION="18.5.0"
NPM_VERSION="9.9.3"

# Atualiza lista de pacotes e instala dependências
sudo apt-get update -y
sudo apt-get install -y build-essential curl

# Instala NVM (versão especificada)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh | bash

# Carrega NVM no ambiente atual
export NVM_DIR="$HOME/.nvm"
# Verifica se o script nvm.sh existe e executa
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Verifica se NVM foi instalado corretamente
echo "NVM versão: $(nvm --version)"

# Instala Node.js na versão desejada
nvm install $NODE_VERSION
nvm use $NODE_VERSION
nvm alias default $NODE_VERSION

# Verifica versão do Node
echo "Node.js versão: $(node --version)"

# Instala versão específica do NPM
npm install -g npm@$NPM_VERSION

# Verifica versão do NPM
echo "NPM versão: $(npm --version)"

echo "Instalação concluída com sucesso!"

