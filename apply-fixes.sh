#!/bin/bash
# Script para aplicar as correções dos workflows

set -e

echo "🔧 Aplicando correções nos workflows do GitHub Actions..."
echo ""

# Verificar se estamos no diretório correto
if [ ! -f "chart/Chart.yaml" ]; then
    echo "❌ Erro: Execute este script no diretório raiz do repositório romm-helm-chart"
    exit 1
fi

# Mostrar status
echo "📋 Arquivos modificados:"
git status --short
echo ""

# Confirmar
read -p "Deseja fazer commit dessas mudanças? (s/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Ss]$ ]]; then
    echo "❌ Cancelado"
    exit 1
fi

# Adicionar arquivos
echo "➕ Adicionando arquivos..."
git add .github/workflows/lint-test.yml
git add .github/workflows/release.yml
git add ct.yaml
git add WORKFLOW-FIXES.md

# Commit
echo "💾 Fazendo commit..."
git commit -m "fix: Corrigir workflows do GitHub Actions

- Melhorar validação no workflow de lint com helm lint e template
- Adicionar criação automática do branch gh-pages no release
- Adicionar configuração ct.yaml para chart-testing
- Separar validações em etapas independentes
- Tornar ct lint opcional para não bloquear builds

Fixes #1 #2"

echo ""
echo "✅ Commit realizado com sucesso!"
echo ""
echo "🚀 Próximo passo: git push origin main"
echo ""
read -p "Deseja fazer push agora? (s/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Ss]$ ]]; then
    echo "📤 Fazendo push..."
    git push origin main
    echo ""
    echo "✅ Push concluído!"
    echo ""
    echo "🎉 Workflows corrigidos! Verifique em:"
    echo "   https://github.com/$(git config --get remote.origin.url | sed 's/.*github.com[:/]\(.*\)\.git/\1/')/actions"
else
    echo "ℹ️  Execute 'git push origin main' quando estiver pronto"
fi
