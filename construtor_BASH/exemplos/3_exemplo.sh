#!/bin/bash
###################################################################################
# Script : 3_exemplo.sh
# Versão : 1.0 (3_exemplo.sh)
# Autor  : Thiago Condé
# Data   : 2025-09-02
# Info   :
# Requis.:
###################################################################################

# 1º passo é adicionar o construtor_BASH.sh
source ../construtor_BASH.sh

# 2º é setar o arquivo dar um nome ao arquivo e o caminho do arquivo
# obs.: você pode setar varios arquivos com nome diferentes
set_file "TESTE_BLOCO" "3_bloco_dentro_de_bloco.html"

# Ordem correta de setar os blocos dentro de bloco
set_block "SUB"
set_block "CONTENT"
show_block "TESTE_BLOCO"
