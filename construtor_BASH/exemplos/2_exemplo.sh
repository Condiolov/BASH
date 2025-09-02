#!/bin/bash
###################################################################################
# Script : 2_exemplo.sh
# Versão : 1.0 (2_exemplo.sh)
# Autor  : Thiago Condé
# Data   : 2025-09-02
# Info   :
# Requis.:
###################################################################################

# 1º passo é adicionar o construtor_BASH.sh
source ../construtor_BASH.sh

# 2º é setar o arquivo dar um nome ao arquivo e o caminho do arquivo
# obs.: você pode setar varios arquivos com nome diferentes
set_file "LISTA_DE_TELEFONES" "2_modelo_lista_telefonica.txt"

# 3º Usando o json como possivel banco de dados ou informações de preenchimendo para modelos
json=$(cat "2_lista.json")

# 4º Posso setar varios blocos ao mesmo tempo com as mesmas variaveis
for row in $(echo "$json" | jq -c '.[]'); do
  NOME=$(echo $row | jq -r '.nome')
  TELEFONE=$(echo $row | jq -r '.telefone')
  set_block "MODELO_1"
  set_block "MODELO_2"
done

# 5º Extraindo listas para diferentes modelos e exibindo no terminal
extract_block "MODELO_2" >2_resultado_modelo_2.txt
extract_block "MODELO_1" >2_resultado_modelo_1.txt

show_block "LISTA_DE_TELEFONES"
