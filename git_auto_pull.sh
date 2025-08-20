#!/bin/bash

# Script para fazer pull automático de todas as branches em todos os repositórios Git
# Uso: ./git_auto_pull.sh [diretório_base]

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Função para imprimir com cores
print_status() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

# Função para processar um repositório
process_repo() {
    local repo_path=$1
    print_status $BLUE "📁 Processando: $repo_path"
    
    cd "$repo_path" || {
        print_status $RED "❌ Erro: Não foi possível acessar $repo_path"
        return 1
    }
    
    # Verifica se é um repositório Git válido
    if ! git rev-parse --git-dir > /dev/null 2>&1; then 
        print_status $RED "❌ Erro: $repo_path não é um repositório Git válido"
        return 1
    fi
    
    # Fazer fetch de todas as branches remotas
    print_status $YELLOW "🔄 Fazendo fetch das branches remotas..."
    if ! git fetch --all --prune; then
        print_status $RED "❌ Erro no fetch para $repo_path"
        return 1
    fi
    
    # Obter branch atual
    current_branch=$(git branch --show-current)
    print_status $YELLOW "📍 Branch atual: $current_branch"
    
    # Obter todas as branches remotas
    remote_branches=$(git branch -r | grep -v '\->' | sed 's/origin\///g' | tr -d ' ')
    
    # Processar cada branch remota
    for branch in $remote_branches; do
        print_status $YELLOW "🔄 Processando branch: $branch"
        
        # Verificar se a branch local já existe
        if git show-ref --verify --quiet refs/heads/$branch; then
            # Branch local existe, fazer checkout e pull
            if git checkout "$branch" > /dev/null 2>&1; then
                if git pull origin "$branch"; then
                    print_status $GREEN "✅ Pull concluído para branch: $branch"
                else
                    print_status $RED "❌ Erro no pull para branch: $branch"
                fi
            else
                print_status $RED "❌ Erro no checkout para branch: $branch"
            fi
        else
            # Branch local não existe, criar e fazer checkout
            if git checkout -b "$branch" "origin/$branch" > /dev/null 2>&1; then
                print_status $GREEN "✅ Branch local criada e sincronizada: $branch"
            else
                print_status $RED "❌ Erro ao criar branch local: $branch"
            fi
        fi
    done
    
    # Voltar para a branch original
    if git checkout "$current_branch" > /dev/null 2>&1; then
        print_status $GREEN "🔙 Voltou para branch original: $current_branch"
    else
        print_status $RED "❌ Erro ao voltar para branch original: $current_branch"
    fi
    
    print_status $GREEN "✅ Repositório processado: $repo_path"
    echo "----------------------------------------"
}

# Função principal
main() {
    local start_dir=${1:-$(pwd)}
    
    print_status $GREEN "🚀 Iniciando busca por repositórios Git em: $start_dir"
    echo "========================================"
    
    # Contador de repositórios processados
    local repo_count=0
    
    # Encontrar todos os diretórios .git recursivamente
    while IFS= read -r -d '' git_dir; do
        # Obter o diretório pai do .git
        repo_dir=$(dirname "$git_dir")
        
        # Verificar se não é um submódulo ou worktree
        if [[ ! -f "$git_dir" ]]; then
            ((repo_count++))
            process_repo "$repo_dir"
        fi
        
    done < <(find "$start_dir" -name ".git" -type d -print0 2>/dev/null)
    
    echo "========================================"
    print_status $GREEN "🎉 Processamento concluído!"
    print_status $GREEN "📊 Total de repositórios processados: $repo_count"
}

# Verificar se git está instalado
if ! command -v git &> /dev/null; then
    print_status $RED "❌ Erro: Git não está instalado"
    exit 1
fi

# Executar função principal
main "$@"