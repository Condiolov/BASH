Scripts úteis para programadores entusiastas do shell são pequenas ferramentas que automatizam tarefas repetitivas, aceleram fluxos de trabalho e ampliam o poder do terminal. Eles ajudam a organizar projetos, manipular arquivos, monitorar processos e criar atalhos inteligentes, tornando o uso do Linux mais produtivo e eficiente.


# Como Instalar os Scripts Bash 

Este instalador permite que você execute seus scripts Bash diretamente no terminal, usando apenas o nome do script (sem precisar especificar o caminho completo ou a extensão `.sh`).

## Como funciona

O instalador cria links simbólicos para todos os scripts marcados como executáveis (`chmod +x meu_script.sh`) dentro da pasta onde o instalador está localizado. Esses links são colocados no diretório `~/.local/bin`, que é adicionado ao `PATH` do sistema. Assim, você pode chamar os scripts como comandos diretamente no terminal.

Se algum link simbólico apontar para um arquivo que não existe mais, ele será automaticamente removido.

Além disso, o instalador cria funções que permitem rodar scripts via source.

## Pré-requisitos

- Ter instalado o `instalador_BASH.sh` na mesma pasta onde estão os scripts.


## Instalação

1. Coloque o `instalador_BASH.sh` na pasta dos seus scripts Bash .
2. Dê permissão de execução aos scripts que deseja habilitar:
   ```bash
   chmod +x meu_script.sh
   ```
3. Dê permissão de execução e execute o instalador:
   ```bash
   chmod +x instalador_BASH.sh
   ./instalador_BASH.sh
   ```
4. Feche e reabra o terminal ou execute:
   ```bash
   source ~/.bashrc
   ```

## Uso

Após a instalação, você pode executar seus scripts diretamente pelo nome, como comandos normais no terminal ou scripts ou via source Exemplo:
```bash
meu_script
criar
backup
```
```bash
# source ../construtor_BASH.sh #necessario especificar o caminho valido
source construtor_BASH #sem necessidade de especificar o caminho
```

## Observações

- **Conflitos de nome**: Se já existir um comando com o mesmo nome de um script, o instalador exibirá um aviso e solicitará que você renomeie o script.
- **Atualizações**: De forma automatica, mesmo que remova o script.
- **Permissões**: Apenas scripts com permissão de execução (`chmod +x`) serão adicionados como comandos.

