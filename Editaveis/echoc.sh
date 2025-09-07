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
		1) bg+="47;" ;; # fundo preto
		0) bg+="40;" ;; # fundo branco

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
	1) bg+="30" ;;     # letra branco normal
	0) bg+="37" ;;     # letra preto
	esac

	echo -e "\e["$bg"m$1\e[0m"
}
show_help() {
	clear

	cat <<EOF
$(echoc "<v>echoc</v> - Script para colorir seus echos
<c>Autor:</c> Thiago Condé
<y>Versão:</y> 1.0
Uso: echoc \"<[letra cor][letra fundo]>Texto</[cor]>\"")

exemplo:
	 echoc "<v>echoc</v> é um script criado por <c>Thiago Condé</c> (versão <y>1.0</y>) que permite deixar seus echos <0n>negrito</0>, <0i>itálico</0>, <0s>sublinhado</0>, <0*>piscante</0>, <0@>inverso</0> ou <0->riscado</0>. Você pode usar cores como <v>vermelho</v>, <g>verde</g>, <y>amarelo</y>, <b>azul</b>, <p>rosa</p>, <c>cinza</c>, <0>branco</0> ou <0@>preto</0>, e fundos como <1g>fundo verde</1>, <1r>fundo vermelho</1>, <1y>fundo amarelo</1>, <1b>fundo azul</1>, <1p>fundo rosa</1>, <1c>fundo ciano</1>, <00>fundo preto</0>  ou <11>fundo branco</1>. Combine cores, estilos e fundos para criar mensagens <0n>impactantes</0> e visualmente <ai>atraentes</a>!"

Resultado:
	 $(echoc "<v>echoc</v> é um script criado por <c>Thiago Condé</c> (versão <y>1.0</y>) que permite deixar seus echos <0n>negrito</0>, <0i>itálico</0>, <0s>sublinhado</0>, <0*>piscante</0>, <0@>inverso</0> ou <0->riscado</0>. Você pode usar cores como <v>vermelho</v>, <g>verde</g>, <y>amarelo</y>, <b>azul</b>, <p>rosa</p>, <c>cinza</c>, <0>branco</0> ou <0@>preto</0>, e fundos como <1g>fundo verde</1>, <1r>fundo vermelho</1>, <1y>fundo amarelo</1>, <1b>fundo azul</1>, <1p>fundo rosa</1>, <1c>fundo ciano</1>, <00>fundo preto</0>  ou <11>fundo branco</1>. Combine cores, estilos e fundos para criar mensagens <0n>impactantes</0> e visualmente <ai>atraentes</a>!")

Letras para cores do texto:
r | v : <v>vermelho</v>  $(echoc "<v>vermelho</v>")
g | d : <g>verde</g>  $(echoc "<g>verde</g>")
y | a : <y>amarelo</y>  $(echoc "<y>amarelo</y>")
b | l : <b>azul</b>  $(echoc "<b>azul</b>")
p | s : <p>rosa</p>  $(echoc "<p>rosa</p>")
c | z : <c>cinza</c>  $(echoc "<c>cinza</c>")
0     : <0>branco</0>  $(echoc "<0>branco</0>")
1     : <1>preto</1>  $(echoc "<1>preto</1>")

# Estilos
n : <0n>negrito</0>  $(echoc "<0n>negrito</0>")
m : <0m>menos intensidade</0>  $(echoc "<0m>menos intensidade</0>")
i : <ai>itálico</a>  $(echoc "<ai>itálico</a>")
s : <ys>sublinhado</y>  $(echoc "<ys>sublinhado</y>")
* : <p*>piscante</p>  $(echoc "<p*>piscante</p>")
@ : <c@>inverso</c>  $(echoc "<c@>inverso</c>")
- : <r->riscado</r>  $(echoc "<r->riscado</r>")

# Fundos
g : <1g>fundo verde</1>  $(echoc "<1g>fundo verde</1>")
r : <1r>fundo vermelho</1>  $(echoc "<1r>fundo vermelho</1>")
y : <1y>fundo amarelo</1>  $(echoc "<1y>fundo amarelo</1>")
b : <1b>fundo azul</1>  $(echoc "<1b>fundo azul</1>")
p : <1p>fundo rosa</1>  $(echoc "<1p>fundo rosa</1>")
c : <1c>fundo ciano</1>  $(echoc "<1c>fundo ciano</1>")
0 : <00>fundo preto</0>  $(echoc "<00>fundo preto</0>")
1 : <11>fundo branco</1>  $(echoc "<11>fundo branco</1>")

Use --help ou -h para mostrar esta mensagem.
EOF
}

if [[ "$1" == "--help" || "$1" == "-h" ]]; then
	show_help
	exit 0
fi

cores="(.*)<(.)(.*)>(.*)<\/\2>(.*)" # antes-arg1-arg2-conteudo-depois    <\b> \3
#   antes meio depois
# echoc() {
#  echo -n "-" #debug tempo de excução
# se tiver tag colore, senao exibe
[[ $@ =~ $cores ]] && final=${BASH_REMATCH[1]}$(cores "${BASH_REMATCH[4]}" "${BASH_REMATCH[2]}" "${BASH_REMATCH[3]}")${BASH_REMATCH[5]} || echo "$@"
# se tiver mais tags volte senão exiba colorido!!
[[ $final =~ $cores ]] && [[ -n ${BASH_REMATCH[4]} ]] && echoc "$final" || echo "${final}" && final=""
# }
