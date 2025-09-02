#!/usr/bin/bash
#------------------------------------------------------------------------------
# Script : instalador_BASH.sh
# Versão : 1.0 (/home/thiago/Documentos/_Projetos/BASH/instalador_BASH.sh)
# Autor  : Thiago Condé
# Data   : 02-09-2025 15:24:32
# Info   :
# Requis.:
#------------------------------------------------------------------------------

TARGET_DIR="$(cd "$(dirname "$0")" && pwd)"
BIN_LINKS_DIR="$HOME/.local/bin"
BASHRC="$HOME/.bashrc"

mkdir -p "$BIN_LINKS_DIR"

# Trecho que vai no .bashrc
BASHRC_SNIPPET="
# ===== Atualiza scripts BASH executáveis e funções source automaticamente =====
BIN_LINKS_DIR=\"$BIN_LINKS_DIR\"
TARGET_DIR=\"$TARGET_DIR\"

mkdir -p \"\$BIN_LINKS_DIR\"
find \"$HOME/.local/bin\" -type l ! -exec test -e {} \; -print -delete

# Adiciona ~/.local/bin ao PATH se não estiver
case \":\$PATH:\" in
  *\":\$BIN_LINKS_DIR:\"*) ;;
  *) export PATH=\"\$BIN_LINKS_DIR:\$PATH\";;
esac

# Torna apenas scripts executáveis disponíveis
find \"\$TARGET_DIR\" -type f -name \"*.sh\" -executable | while read -r script; do
    name=\"\$(basename \"\$script\" .sh)\"
    target_link=\"\$BIN_LINKS_DIR/\$name\"

    # Cria link simbólico
    if [ -e \"\$target_link\" ] && [ ! \"\$(readlink -f \"\$target_link\")\" = \"\$(readlink -f \"\$script\")\" ]; then
        echo \"⚠ Conflito de comando: '\$name'\"
        echo \"  Já existe um arquivo/link em: \$target_link\"
        echo \"  Script atual: \$script\"
        echo \"  Renomeie o script ou o link antes de continuar.\"
    else
        ln -sf \"\$script\" \"\$target_link\"
    fi

    # Cria função para rodar via source
    eval \"\$name() { source '\$script' \"\$@\"; }\"
done
# ==========================================================
"

# Evita duplicar no .bashrc
if ! grep -Fxq "# ===== Atualiza scripts BASH executáveis e funções source automaticamente =====" "$BASHRC"; then
    echo "$BASHRC_SNIPPET" >>"$BASHRC"
    echo "Trecho automático adicionado ao .bashrc!"
else
    echo "Trecho automático já existe no .bashrc"
fi

# Executa imediatamente para ativar sem reiniciar o terminal
echo "Atualizando scripts executáveis e funções source agora..."
eval "$BASHRC_SNIPPET"

echo "Instalação concluída! Para ativar permanentemente em novos terminais: source ~/.bashrc"
