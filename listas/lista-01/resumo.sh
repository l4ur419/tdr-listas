#!/usr/bin/env bash
set -euo pipefail

## Calcula resumo de uma coluna do arquivo airquality.csv.
## Uso: ./resumo.sh <arquivo.csv> <numero_da_coluna>

if [[ $# -ne 2 ]]; then
    echo "erro: faltando argumentos. Uso: $0 <arquivo.csv> <numero_da_coluna>" >&2
    exit 1
fi

arquivo="$1"
coluna="$2"

## 1. Nome da coluna lido do cabeçalho
nome_coluna=$(head -n 1 "$arquivo" | cut -d',' -f"$coluna")
echo "Variável: $nome_coluna"

## 2. Número de observações
linhas=$(wc -l < "$arquivo")
obs=$((linhas - 1))
echo "Total de observações: $obs"

## 3. Quantos valores da coluna são NA
nas=$(tail -n +2 "$arquivo" | cut -d',' -f"$coluna" | grep -c "NA" || true)
echo "Valores NA: $nas"

## 4. Média da coluna por mês e número de dias medidos
echo "Média por mês (Mês, Média, Dias medidos):"
tail -n +2 "$arquivo" | awk -F',' -v c="$coluna" '{
    mes = $5; val = $c;
    if (val != "NA") {
        soma[mes] += val;
        qtd[mes] += 1;
    }
} END {
    for (m in qtd) {
        printf("Mês %s: média = %.2f (dias = %d)\n", m, soma[m]/qtd[m], qtd[m]);
    }
}' | sort -n