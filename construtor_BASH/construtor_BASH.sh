#!/usr/bin/env bash
###################################################################################
# Script : construtor_BASH.sh
# Versão : 1.0 (/home/thiago/Documentos/_imp/_scripts/bashweb/bash-server-master/construtor_BASH.sh)
# Autor  : Thiago Condé
# Data   : 2022-06-25 18:59:03
# Info   :
# Requis.:
###################################################################################

IFS=$'\n' # Separador de quebra de linhas
declare -A block
function set_file() {
	unico_bloco=""
	nome_bloco=""
	conteudo_pagina="$2"
	[ ! -f $conteudo_pagina ] && echo "compilador_BASH => page does not exist in this path: [$conteudo_pagina]"
	guarda_variavel=("$1") # Responsavel por saber em qual BLOBO esta

	for line in $(cat $conteudo_pagina); do

		bloco_inicio="(.*)<!-- ON ([A-Z0-9_]+?) -->(.*)"
		bloco_fim="(.*)<!-- OFF ${guarda_variavel[-1]} -->(.*)"
		bloco_de_uma_lina="(.*?)<!-- ON ([A-Z0-9_]+) -->(.*)<!-- OFF \2 -->(.*)"

		#### BLOCO de uma unica linha <ON> texto <OFF>
		if [[ $line =~ $bloco_de_uma_lina ]]; then

			while true; do
				if [[ $line =~ $bloco_de_uma_lina ]]; then
					nome_bloco=${BASH_REMATCH[2]} # pego o nome do bloco
					line=${BASH_REMATCH[1]}{VAR_${BASH_REMATCH[2]}}${BASH_REMATCH[4]}
					block["BO_$nome_bloco"]=${BASH_REMATCH[3]}
				fi

				para_em="<!-- ON (.*) -->"
				if [[ $line =~ $para_em ]]; then
					continue
				else
					block["BO_${guarda_variavel[-1]}"]+=$line"\n"
					break
				fi
			done
			continue # Zera loop
		fi

		#### ON - pego o nome do bloco principal
		if [[ $line =~ $bloco_inicio ]]; then
			nome_bloco=${BASH_REMATCH[2]} # pego o nome do bloco
			unico_bloco=1                 #controle de bloco unico
			line=${BASH_REMATCH[3]}       # removo as tags de bloco

			tem="{VAR_$nome_bloco}\n"
			block["BO_${guarda_variavel[-1]}"]+=${BASH_REMATCH[1]}$tem #$(awk '{gsub(/<!--\s[ONOFF]+\s.*\s-->/,"\n"); print }' <<<$tem$line"\n")
			guarda_variavel+=($nome_bloco)                             # crio um array de blocos caso existam mais
		fi

		#### OFF - caso tenha mais BLOCOS gero um mas VAR_BLOCO
		if [[ $line =~ $bloco_fim ]]; then
			# 			nome_bloco=${BASH_REMATCH[2]}                              # pego o nome do bloco
			#controle de bloco unico
			line=${BASH_REMATCH[2]} # removo as tags de bloco

			block["BO_${guarda_variavel[-1]}"]+=${BASH_REMATCH[1]} #$(awk '{gsub(/<!--\s[ONOFF]+\s.*\s-->/,"\n"); print }' <<<$tem$line"\n")

			unico_bloco=0
			# 			tem="{VAR_${guarda_variavel[-1]}}\n"
			unset 'guarda_variavel[-1]' # apago o ultimo bloco da casca
			# 			line=$(awk '{gsub(/<!--[^>]*-->/,"\n"); print }' <<<$line)
			# 			return
		fi
		#### MEIO - Guardo BLOCO tudo que há no meio do BLOCO, conteudo do BLOCO
		block["BO_${guarda_variavel[-1]}"]+=$(awk '{gsub(/<!--\s[ONOFF]+\s.*\s-->/,"\n"); print }' <<<$line"\n")
		[[ $unico_bloco == 0 ]] && tem=""
	done
}

function set_var() {
	regex_var="\{([A-Z0-9_]+?)\}(.*?)" # {VARIAVEL}(Mais alguma coisa)

	[[ "$1" =~ $regex_var ]] && tem_var="${BASH_REMATCH[1]}"                             # Se tiver VARIAVEL
	[[ -z ${BASH_REMATCH} ]] && echo "${1//\\n/}" && return                              # Retorna se não encontrou nenhuma VARIAVEL
	[[ -n $tem_var ]] && var_name=${!tem_var} && final=${1//\{$tem_var\}/${var_name[@]}} # Monta a VARIAVEL se ela existir
	[[ -z ${BASH_REMATCH[2]} ]] && echo -e "$final"                                      # Não tem mais VARIAVEL nessa linha terminal a busca
	[[ -n ${BASH_REMATCH[2]} ]] && set_var $final                                        # Tem mais VARIAVEL nessa linha
}

function set_block() {
	local bloco_nome=$1

	# Pego o BO_ (BLOCO ORIGINAL) percorro e preencho as VARIAVEIS existentes
	for line in $(echo -e "${block[BO_$bloco_nome]}"); do
		linha_montada=$(set_var "$line")
		[[ -n $linha_montada ]] && block[$bloco_nome]+=$linha_montada"\n"
	done

	# Avaria a variavel do bloco
	unset "VAR_$bloco_nome"

	#Crio a variavel do bloco
	export "VAR_$bloco_nome"+="${block[$bloco_nome]}"

	# Apago restos de outros sub blobos dentro do bloco atual
	regex_apaga="\{VAR_([A-Z0-9_]+)\}"
	for line in $(echo -e "${block[BO_$bloco_nome]}"); do
		[[ $line =~ $regex_apaga ]] && block["${BASH_REMATCH[1]}"]="" && unset "VAR_${BASH_REMATCH[1]}" #&& echo
	done
}

function extract_block() {
	local bloco="VAR_$1"
	printf -- "%b" "${!bloco}"
}

function show_block() {
	set_block "$1"
	# 	echo -e ${block["$1"]}
	printf -- "%b" "${block["$1"]}"
}
