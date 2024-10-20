#!/bin/bash

# Instalar Git
sudo apt install -y git

# Verificar instalação do Git
git --version

if [ $? -eq 0 ]; then
    echo "Git instalado com sucesso!"
else
    echo "Erro na instalação do Git."
    exit 1
fi

# Carregar configurações de arquivo .config.txt
if [ -f .config.txt ]; then
    username=$(sed -n '1p' .config.txt)
    email=$(sed -n '2p' .config.txt)

    if [ -n "$username" ] && [ -n "$email" ]; then
        # Configurar o Git
        git config --global user.name "$username"
        git config --global user.email "$email"
        
        echo "Git configurado com:"
        git config --list
    else
        echo "Arquivo .config.txt vazio ou incompleto, ignorando configuração do Git."
    fi
else
    echo "Arquivo .config.txt não encontrado, ignorando configuração do Git."
fi

