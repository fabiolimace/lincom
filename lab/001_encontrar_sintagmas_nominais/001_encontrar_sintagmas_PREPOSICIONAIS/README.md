
Encontrar sintagmas nominais #1
===============================

O objetivo desta tarefa é encontrar sintagmas nominais em uma lista grande de bigramas.

O escopo desta tarefa está restrito a estas construções:

*   SN = Det + Subst, em que Det são artigos.
*   SN = Prep + Det + Subst, em que Prep e Det estão combinados/contraídos.

A segunda construção é um SP que contém um SN.

Entrada
-------------------------------

Uma lista 10 mil de bigramas foi extraída de uma base de dados gerada com o [`tfidf-simples`](https://github.com/fabiolimace/tfidf-simples).

O arquivo `bigramas.txt` foi gerado com este comando:

```
sqlite3 database.db "select token from tb_token t where ng = 2 order by random() limit 10000;" > bigramas.txt
```

Roteiro
-------------------------------

As funções de `Morfossintaxe.jl` serão usadas para identificar os determinantes e substantivos.

O arquivo `bigramas.txt` será lido, e suas linhas serão convertidas em um vetor de bigramas.

Os sintagmas nominais serão identificados na lista de bigramas.

No final, uma lista de sintagmas nominais será escrita no arquivo `resultado.txt`.

Resultado
-------------------------------

Foi gerado um arquivo `resultado.txt` com 320 sintagmas nominais. Quase 100% das linhas contém de fato a SNs.

O `programa.jl` cumpriu o objetivo da tarefa com êxito.
