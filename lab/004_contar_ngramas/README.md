
Coleta do corpus
-----------------------

Não foi necessário realizar uma nova coleta de corpus, pois reaproveitamos o corpus que foi coletado durante a tarefa de [contagem de palavras](https://github.com/fabiolimace/lincom/issues/3).

Limpeza do corpus coletado
----------------------------

Também não foi necessário realizar limpeza dos documentos do corpus.

Resultado
----------------------------

Foi gerado o arquivo "resultado.csv" de quase 5 milhões de linhas contendo n-gramas de 1 a 3. O arquivo foi truncado para listar apenas as primeiras 16k linhas, pois não queremos preencher este repositório com arquivos muito grandes. Depois de truncado, o arquivo foi zipado.

Listagem das primeiras linhas:

```
"Site","Page","Word","Freq"
"site 1","page 1","a",24
"site 1","page 1","A",5
"site 1","page 1","a abrigar",1
"site 1","page 1","a abrigar cerca",1
"site 1","page 1","a água",1
"site 1","page 1","A água",1
"site 1","page 1","A água ficava",1
"site 1","page 1","a água imprópria",1
"site 1","page 1","A barbárie",1
"site 1","page 1","A barbárie que",1
"site 1","page 1","a chuva",1
"site 1","page 1","a chuva e",1
"site 1","page 1","a cidade",1
"site 1","page 1","a cidade de",1
"site 1","page 1","a Ciência",1
"site 1","page 1","a Ciência e",1
"site 1","page 1","A Colônia",1
"site 1","page 1","A Colônia do",1
```

Como podem notar, não alteramos a caixa das letras.

