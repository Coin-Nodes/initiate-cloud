#!/bin/bash

# Atualizar o sistema
sudo apt update && sudo apt upgrade -y

# Verificar se a atualização deu certo
if [ $? -eq 0 ]; then
    echo "Sistema atualizado com sucesso!"
else
    echo "Erro ao atualizar o sistema."
    exit 1
fi

