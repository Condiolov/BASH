#!/usr/bin/env bash

if [ -n "$EDITOR" ]; then
    editor="$EDITOR"
elif command -v kate >/dev/null 2>&1; then
    editor="kate"
else
    editor="nano"
fi

data_de_hoje=$(date '+%d-%m-%Y %H:%M:%S')
#echo $PWD
corpo_do_arquivo="
#------------------------------------------------------------------------------
# Script : $1
# Versão : 1.0 ($PWD/$1)
# Autor  : Thiago Condé
# Data   : $data_de_hoje
# Info   : $2
# Requis.:
#------------------------------------------------------------------------------
"
# echo "$1" '---->' "$2"
# Verifico se o numero de parametros é menor que 1
[[ $# -lt 1 ]] && echo "Digite o nome de um Arquivo.." && exit 1

# Verifico se tem extensão
if [[ $1 = *['.']* ]]; then
    extensao=${1##*\.} # se tiver ja identifico!!
else
    echo "Digite uma extensão!!" && exit 1
fi

# Verifico se ja existe o arquivo
[[ -f "$1" ]] && {
    echo "Arquivo já existe! Saindo.."
} && exit 1

# exit

# Verifico se a extensão é SH
if [[ $extensao = *py* ]]; then
    echo "$corpo_do_arquivo" >>"$PWD/$1"
    #     chmod +x "$PWD/$1"
    $editor "$PWD/$1" 2>/dev/null
    exit 0
fi

# Verifico se a extensão é SH
if [[ $extensao = *sh* ]]; then
    echo "#!/usr/bin/bash$corpo_do_arquivo" >>"$PWD/$1"
    [[ $2 == "x" ]] && chmod +x "$PWD/$1"
    $editor "$PWD/$1" 2>/dev/null
    exit
fi

# Verifico se a extensão é PHP
if [[ $extensao = *php* ]]; then
    echo -e "<?php $corpo_do_arquivo \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n?>" >>"$PWD/$1"
    $editor "$PWD/$1" 2>/dev/null
fi

# Verifico se a extensão é TXT
if [[ $extensao = *txt* ]]; then
    echo -e "$1$corpo_do_arquivo \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" >>"$PWD/$1"
    $editor "$PWD/$1" 2>/dev/null
fi

# Verifico se a extensão é TXT
if [[ $extensao = *html* ]]; then
    echo -e "<!--- ini $1 - $data_de_hoje ---> \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n<!--- fim $1 - $data_de_hoje --->" >>"$PWD/$1"
    $editor "$PWD/$1" 2>/dev/null
fi

# Verifico se a extensão é TXT
if [[ $extensao = *h* ]]; then
    echo -e "// $1 - $data_de_hoje\n\n\n\n" >>"$PWD/$1"
    $editor "$PWD/$1" 2>/dev/null
fi
echo ${extensao}
exit

exit 0
