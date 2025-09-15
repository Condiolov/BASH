#!/usr/bin/bash
#------------------------------------------------------------------------------
# Script : bash_BACKUP.sh
# Versão : 1.0 (/home/thiago/Documentos/_Projetos/BASH/bash_BACKUP/bash_BACKUP.sh)
# Autor  : Thiago Condé
# Data   : 14-09-2025 18:41:29
# Info   : - Evitar duplicidade (Criar links simbolicos)
# 			  - Funcionar nativamente
# 			  - Possibilitar backup automatizados
# 			  -
# Requis.:
# FUTURO : - ver se o arquivo realmente existe para criar o link simbolico.
# 			  - tabela de excluidos para poder nao copiar aquilo que ja foi excluidos
# 			  - criar script para exluir arquivos ou pastas para nao excluir arquivos originais que tem links simbolicos.
# 			  - fazer o script para copiar os arquivos original sem copiar o link "cp -L -r" comando que restaura no destino o arquivo original
#------------------------------------------------------------------------------

#!/bin/bash

# Recebe como parâmetros a pasta de origem e a pasta de destino
ORIGEM="$1"
DESTINO="/run/media/thiago/SAM_BACKUP"
DB="$DESTINO/bash_BACKUP.db"

# Cria a pasta de destino caso não exista
# mkdir -p "$DESTINO"

# Cria o banco de dados SQLite com duas tabelas:
# 'arquivos' para armazenar hash, caminho principal e data de criação
# 'links' para armazenar caminhos de links simbólicos relacionados aos arquivos
sqlite3 "$DB" "CREATE TABLE IF NOT EXISTS arquivos (hash TEXT PRIMARY KEY, caminho_principal TEXT NOT NULL, data_criacao TEXT NOT NULL);"
sqlite3 "$DB" "CREATE TABLE IF NOT EXISTS links (hash TEXT NOT NULL, caminho_link TEXT NOT NULL, FOREIGN KEY(hash) REFERENCES arquivos(hash));"

# exit
# Percorre todos os arquivos dentro da pasta de origem
find "$ORIGEM" -type f | while read -r ARQ; do
	# Remove o caminho base da origem para criar o caminho relativo
	# 	echo $(realpath "$ARQ")
	REAL_PASTA=$(realpath "$ARQ")
	REL_PATH="${REAL_PASTA#$HOME/}"
	# 	echo $REL_PATH
	# Define o caminho de destino do arquivo
	DEST_PATH="$DESTINO/$REL_PATH"
	# Define o diretório de destino
	DIR_PATH=$(dirname "$DEST_PATH")

	# Cria o diretório de destino se não existir
	mkdir -p "$DIR_PATH"

	# Calcula o hash SHA256 do arquivo
	HASH=$(md5sum "$ARQ" | awk '{print $1}')
	# 	echo $HASH
	# Obtém a data de criação do arquivo (em segundos desde 1970)
	DATA_CRIACAO=$(stat -c %W "$ARQ")
	DATA_MODIFICACAO=$(stat -c %Y "$ARQ")
	if [ "$DATA_CRIACAO" -eq 0 ]; then
		DATA_ANTIGA=$DATA_MODIFICACAO
	else
		# Escolher a menor das duas
		if [ "$DATA_CRIACAO" -lt "$DATA_MODIFICACAO" ]; then
			DATA_ANTIGA=$DATA_CRIACAO
		else
			DATA_ANTIGA=$DATA_MODIFICACAO
		fi
	fi

	# Verifica se o arquivo com o mesmo hash já existe no banco
	EXISTE=$(sqlite3 "$DB" "SELECT caminho_principal FROM arquivos WHERE hash='$HASH';")

	if [ -z "$EXISTE" ]; then
		echo "O Arquivo não exite $(basename "$REL_PATH") "
		# Se não existir, copia o arquivo para o destino
		cp "$ARQ" "$DEST_PATH"
		# Insere registro no banco informando o hash, caminho e data de criação
		sqlite3 "$DB" "INSERT INTO arquivos (hash, caminho_principal, data_criacao) VALUES ('$HASH', '$REL_PATH', '$DATA_ANTIGA');"
		# 		continue
	else
		echo "O Arquivo exite $(basename "$REL_PATH") "
		# Se já existir, cria um link simbólico apontando para o arquivo original
		REL_LINK=$(realpath --relative-to="$(dirname "$DEST_PATH")" "$DESTINO/$EXISTE")

		[ ! -f "$DEST_PATH" ] && ln -s "$REL_LINK" "$DEST_PATH"
		# Insere registro no banco informando o hash e o caminho do link
		sqlite3 "$DB" "INSERT INTO links (hash, caminho_link) VALUES ('$HASH', '$REL_PATH');"
	fi
done
