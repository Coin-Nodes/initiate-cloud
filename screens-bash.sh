#!/bin/bash

# Função para limpar as sessões do tmux
clean_tmux_sessions() {
    echo "[+] Limpando todas as sessões ativas do tmux"
    sessions=$(tmux ls 2>/dev/null)

    if [ -n "$sessions" ]; then
        echo "[-] Deletando sessões ativas"
        tmux ls | awk -F: '{print $1}' | xargs -I {} tmux kill-session -t {}
    fi

    echo "[+] Sessões atuais do tmux:"
    tmux ls 2>/dev/null || echo "Nenhuma sessão ativa"
}

# Função para verificar serviços ativos no Docker
check_docker_services() {
    echo "[+] Verificando serviços ativos"
    docker ps --format "{{.ID}}" > /tmp/docker_services.txt
    services=$(cat /tmp/docker_services.txt)
    if [ -z "$services" ]; then
        echo "[!] Nenhum serviço Docker ativo encontrado"
        exit 1
    fi
}

# Função para criar a sessão tmux com telas divididas
create_tmux_session() {
    session_name="mysession"
    services=$(cat /tmp/docker_services.txt)
    num_services=$(echo "$services" | wc -l)

    tmux new-session -d -s $session_name

    for id in $services; do
        tmux split-window -h -t $session_name
        tmux select-layout -t $session_name even-horizontal
        tmux send-keys -t $session_name "docker logs -f $id" C-m
    done

    tmux kill-pane -t $session_name:0.0

    echo "[+] Screens criadas, utilize o comando 'tmux attach -t $session_name' para verificar"
}

# Limpar sessões do tmux
clean_tmux_sessions

# Verificar serviços Docker
check_docker_services

# Criar a sessão tmux
create_tmux_session

# Limpar arquivo temporário
rm /tmp/docker_services.txt

