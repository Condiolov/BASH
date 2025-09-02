#!/bin/bash
###################################################################################
# Script : 1_exemplo.sh
# Versão : 1.0 (1_exemplo.sh)
# Autor  : Thiago Condé
# Data   : 2025-09-02
# Info   :
# Requis.:
###################################################################################

# 1º passo é adicionar o construtor_BASH.sh
source ../construtor_BASH.sh

# 2º é setar o arquivo dar um nome ao arquivo e o caminho do arquivo
# obs.: você pode setar varios arquivos com nome diferentes
set_file "HTML_PRINCIPAL" "1_page.html"

# VARIAVEIS
# 3º setar uma variavel qualquer presente no arquivo setado
VARIAVEL1="Thiago Condé"
#TRECHO_HTML="<h1> teste contrutor_BASH.sh</h1>"

# BLOCOS
# 4º Os blocos podem ser repetidos quando chamados varias vezes
set_block "MENU"
#set_block "MENU"

# 5º Exibe o conteudo do arquivo ou bloco especifico
show_block "HTML_PRINCIPAL"
show_block "FOOTER"
