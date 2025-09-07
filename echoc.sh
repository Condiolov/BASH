#!/usr/bin/env bash
####################################################################
# Script : colorir.sh
# Versão : 1.0 (/home/conde/Documentos/_scripts/jogo/colorir.sh)
# Autor  : Thiago Condé
# Data   : 2022-08-08 12:52:28
# Info   : usando o echoc vc é capaz de colorir seus echo
# Requis.:
# Uso: echoc "<v>Vermelho</v>"
####################################################################

# echo -e "\e[42mC\e[0mO\e[43mR\e[0m"
# echo -e "\e[32mC\e[0mO\e[33mR\e[0m"
# clear

# cores "palavra" "arg1" "arg2"
cores() {
	opt=$3 #abcd
	bg=""
	while [[ -n $opt ]]; do # loop de letras!!

		resto=${opt:1} # Tudo menos a primeira letra # bcd
		opt=${opt:0:1} # Apenas uma letra # a

		case "$opt" in
		n) bg+="1;" ;;  # Negrito
		m) bg+="2;" ;;  # Menos intensidade
		i) bg+="3;" ;;  # Italico
		s) bg+="4;" ;;  # Sublinhado
		\*) bg+="5;" ;; # Piscante
		@) bg+="7;" ;;  # Inverso
		-) bg+="9;" ;;  # Risca

		g) bg+="42;" ;; # fundo verde
		r) bg+="41;" ;; # fundo vermelho
		y) bg+="43;" ;; # fundo amarelo
		b) bg+="44;" ;; # fundo azul
		p) bg+="45;" ;; # fundo rosa
		c) bg+="46;" ;; # fundo ciano
		0) bg+="47;" ;; # fundo preto
		*) bg+="40;" ;; # fundo branco

		esac
		opt=$resto
	done

	case $2 in

	r | v) bg+="31" ;; # letra vermelho
	g | d) bg+="32" ;; # letra verde
	y | a) bg+="33" ;; # letra amarelo
	b | l) bg+="34" ;; # letra azul
	p | s) bg+="35" ;; # letra rosa
	c | z) bg+="36" ;; # letra cinza
	0) bg+="30" ;;     # letra branco normal
	*) bg+="37" ;;     # letra preto
	esac

	echo -e "\e["$bg"m$1\e[0m"
}

cores="(.*)<(.)(.*)>(.*)<\/\2>(.*)" # antes-arg1-arg2-conteudo-depois    <\b> \3
#   antes meio depois
# echoc() {
#  echo -n "-" #debug tempo de excução
# se tiver tag colore, senao exibe
[[ $@ =~ $cores ]] && final=${BASH_REMATCH[1]}$(cores "${BASH_REMATCH[4]}" "${BASH_REMATCH[2]}" "${BASH_REMATCH[3]}")${BASH_REMATCH[5]} || echo "$@"
# se tiver mais tags volte senão exiba colorido!!
[[ $final =~ $cores ]] && [[ -n ${BASH_REMATCH[4]} ]] && echoc "$final" || echo "${final}" && final=""
# }
