#!/usr/bin/bash
#------------------------------------------------------------------------------
# Script : backup_file.sh
# Versão : 1.0 (/home/thiago/Documentos/_Projetos/BASH/Editaveis/backup_file.sh)
# Autor  : Thiago Condé
# Data   : 02-09-2025 16:33:19
# Info   : x
# Requis.:
#------------------------------------------------------------------------------

NOME_ARQUIVO="$1"
PASTA="./_backup" # /home/thiago/backup

mkdir -p "$PASTA"
cp "$NOME_ARQUIVO" "$PASTA/${NOME_ARQUIVO}_$(date +"%Y-%m-%d_%H:%M:%S")"
command -v kdialog >/dev/null && kdialog --passivepopup "Backup completo $NOME_ARQUIVO!" 3 --icon backup --title "backup_file"