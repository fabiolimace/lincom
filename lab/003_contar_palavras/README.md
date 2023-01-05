
Coleta do corpus
-----------------------

As notícias foram extraídas um pouco de cada vez de três sites de notícias durante os meses de novembro e dezembro de 2022.

Foi criado o diretório para a guarda do corpus de notícias:

```bash
cd lincom
mkdir corpora/
mkdir corpora/noticias/
```

Foram selecionadas as notícias com tamanho maior que 4k:

```bash
mkdir corpora/noticias/site1
find ~/extract-news/site1/ -type f -name "*.txt" -size +4k -exec cp "{}" "corpora/noticias/site1/" \;
```

```bash
mkdir corpora/noticias/site2
find ~/extract-news/site2/ -type f -name "*.txt" -size +4k -exec cp "{}" "corpora/noticias/site2/" \;
```

```bash
mkdir corpora/noticias/site3
find ~/extract-news/site3/ -type f -name "*.txt" -size +4k -exec cp "{}" "corpora/noticias/site3/" \;
```

```bash
# criar uma copia para caso precise recomeçar
cp -a corpora/noticias/ corpora/noticias.original/
```

```bash
find corpora/noticias -type f -name "*.txt" | wc -l
6905
```

```bash
du -sh corpora/noticias/*
17M	corpora/noticias/site1
28M	corpora/noticias/site2
20M	corpora/noticias/site3
```

O tamanho 4k corresponde aproximadamente a uma página de texto cheia no LibreOffice Writer, usando a fonte Liberation Serif 12pt.

Limpeza do corpus coletado
----------------------------

Foram removidas as linhas que não terminam com pontuação final (.!?):

```
for file in `find corpora/noticias/*/ -type f -name "*.txt"`; do
    echo "$file"
    grep -E --only-matching "^.*[\.\?\!]$" "$file" > "$file".tmp ; mv "$file".tmp "$file"
done;
```

Só precisamos das linhas que parecem conter períodos.

O script abaixo serviu apenas para listar as linhas que correspondem com um determinado padrão de período esperado.

```
find corpora/noticias/*/ -type f -name "*.txt" | xargs cat \
    | grep -E --only-matching "^.*[\.\?\!]$" \
    | grep -E --only-matching \
    "^[A-ZÁÉÍÓÚÀÂÊÔÃÕÜÇ] ?(([a-zA-ZáéíóúÁÉÍÓÚàÀâêôÂÊÔãõÃÕüÜçÇªº°0-9\$\%-]+|[0-9]+([,. ]?[0-9]+[ªº°\%]?)*)( |[,:;\.\?\!] ))+(([a-zA-ZáéíóúÁÉÍÓÚàÀâêôÂÊÔãõÃÕüÜçÇªº°0-9\$\%-]+|[0-9]+([,. ]?[0-9]+[ªº°\%]?)*)[\.\?\!])" \
    > corpora/noticias/frases-no-formato-esperado.txt
```

Foram identificadas todas as todas as entidades HTML utilizadas no corpus:

```bash
grep --extended-regexp --recursive --only-matching --no-filename '&#?[a-zA-Z0-9]+;' corpora/noticias/ | sort --unique | tr '\n' ' '
&#038; &#039; &#13; &#160; &#170; &#215; &#224; &#225; &#226; &#227; &#231; &#233; &#234; &#237; &#243; 
&#244; &#245; &#250; &#34; &#39; &#8211; &#8212; &#8216; &#8217; &#8220; &#8221; &#8230; &#8243; &aacute; 
&acirc; &agrave; &Agrave; &amp; &atilde; &ccedil; &eacute; &Eacute; &ecirc; &gt; &hellip; &iacute; 
&lsquo; &lt; &mdash; &minus; &ndash; &oacute; &ocirc; &ordm; &otilde; &quot; &rdquo; &uacute; &#x27;
```

Foi necessário substituir todas essas entidades HTML para harmonizar os textos.

Foram substituídas todas as entidades HTML do corpus por caracteres equivalentes:

```bash
# replace HTML entities with equivalent chars
for file in `find corpora/noticias -type f -name "*.txt"`; do
    echo "$file";
    cat "$file" \
    | sed -E 's/(&Agrave;|&#192;)/À/g' \
    | sed -E 's/(&Aacute;|&#193;)/Á/g' \
    | sed -E 's/(&Acirc;|&#194;)/Â/g' \
    | sed -E 's/(&Atilde;|&#195;)/Ã/g' \
    | sed -E 's/(&Ccedil;|&#199;)/Ç/g' \
    | sed -E 's/(&Eacute;|&#201;)/É/g' \
    | sed -E 's/(&Ecirc;|&#202;)/Ê/g' \
    | sed -E 's/(&Iacute;|&#205;)/Í/g' \
    | sed -E 's/(&Oacute;|&#211;)/Ó/g' \
    | sed -E 's/(&Ocirc;|&#212;)/Ô/g' \
    | sed -E 's/(&Otilde;|&#213;)/Õ/g' \
    | sed -E 's/(&Uacute;|&#218;)/Ú/g' \
    | sed -E 's/(&Ucirc;|&#219;)/Û/g' \
    | sed -E 's/(&Uuml;|&#220;)/Ü/g' \
    | sed -E 's/(&agrave;|&#224;)/à/g' \
    | sed -E 's/(&aacute;|&#225;)/á/g' \
    | sed -E 's/(&acirc;|&#226;)/â/g' \
    | sed -E 's/(&atilde;|&#227;)/ã/g' \
    | sed -E 's/(&ccedil;|&#231;)/ç/g' \
    | sed -E 's/(&eacute;|&#233;)/é/g' \
    | sed -E 's/(&ecirc;|&#234;)/ê/g' \
    | sed -E 's/(&iacute;|&#237;)/í/g' \
    | sed -E 's/(&oacute;|&#243;)/ó/g' \
    | sed -E 's/(&ocirc;|&#244;)/ô/g' \
    | sed -E 's/(&otilde;|&#245;)/õ/g' \
    | sed -E 's/(&uacute;|&#250;)/ú/g' \
    | sed -E 's/(&uuml;|&#252;)/ü/g' \
    | sed -E 's/(&ordf;|&#170;)/ª/g' \
    | sed -E 's/(&reg;|&#174;)/®/g' \
    | sed -E 's/(&deg;|&#176;)/°/g' \
    | sed -E 's/(&sup2;|&#178;)/²/g' \
    | sed -E 's/(&sup3;|&#179;)/³/g' \
    | sed -E 's/(&sup1;|&#185;)/¹/g' \
    | sed -E 's/(&ordm;|&#186;)/º/g' \
    | sed -E 's/(&frac14;|&#188;)/¼/g' \
    | sed -E 's/(&frac12;|&#189;)/½/g' \
    | sed -E 's/(&frac34;|&#190;)/¾/g' \
    | sed -E 's/(&copy;|&#169;)/©/g' \
    | sed -E 's/(&sect;|&#167;)/§/g' \
    | sed -E 's/(&pound;|&#163;)/£/g' \
    | sed -E 's/(&lt;|&#60;|&#x3c;)/</g' \
    | sed -E 's/(&gt;|&#62;|&#x3e;)/>/g' \
    | sed -E 's/(&amp;|&#38;|&#x26;)/&/g' \
    | sed -E 's/(&quot;|&#34;|&#x22;)/"/g' \
    | sed -E "s/(&apos;|&#39;|&#x27;)/'/g" \
    | sed -E 's/(&ndash;|&#8211;)/–/g' \
    | sed -E 's/(&mdash;|&#8212;)/—/g' \
    | sed -E 's/(&lsquo;|&#8216;)/‘/g' \
    | sed -E 's/(&rsquo;|&#8217;)/’/g' \
    | sed -E 's/(&ldquo;|&#8220;)/“/g' \
    | sed -E 's/(&rdquo;|&#8221;)/”/g' \
    | sed -E 's/(&hellip;|&#8230;)/…/g' \
    | sed -E 's/(&bull;|&#8226;)/•/g' \
    | sed -E 's/(&nbsp;|&#160;)/ /g' \
    | sed -E 's/&[^;]+;//g' \
    > "$file".tmp && mv "$file".tmp "$file"
done;
```

Foram removidos todos os pares de aspas do corpus:

```bash
# remove quotes: '', "", ‘’, “”, «»
for file in `find corpora/noticias -type f -name "*.txt"`; do
    echo "$file"
    # remove pairs of quotes
    sed -E -i  "s/\«([^\«]+)\»/\1/g" "$file"
    sed -E -i  "s/\‘([^\‘]+)\’/\1/g" "$file"
    sed -E -i  "s/\“([^\“]+)\”/\1/g" "$file"
    sed -E -i  "s/\'([^\']+)\'/\1/g" "$file"
    sed -E -i  "s/\"([^\"]+)\"/\1/g" "$file"
    # remove pairs of mixed quotes: “'
    sed -E -i  "s/[\«\»\‘\’\“\”\"]/\'/g" "$file"
    sed -E -i  "s/\'([^\']+)\'/\1/g" "$file"
done;
```

Foram removidos todos os trechos dentro de parênteses, colchetes e chaves:

```bash
# remove brackets with text: (text), [text], {text}
for file in `find corpora/noticias -type f -name "*.txt"`; do
    echo "$file"
    sed -E -i  "s/ *\[[^\[]+\]//g" "$file"
    sed -E -i  "s/ *\([^\(]+\)//g" "$file"
    sed -E -i  "s/ *\{[^\{]+\}//g" "$file"
done;
```

Foi decidido descatar esss trechos.

Foram substituídos todos os travessões por virgulas:

```bash
# replace em dashes with commas: — – -
for file in `find corpora/noticias -type f -name "*.txt"`; do
    echo "$file"
    # normalize dashes to '-'
    sed -E -i  "s/–/-/g" "$file"
    sed -E -i  "s/—/-/g" "$file"
    # replace dashes with commas
    sed -E -i  "s/ - ?([^,]+),/, \1, /g" "$file"
    sed -E -i  "s/ - ?([^,]+)\./, \1\. /g" "$file"
    sed -E -i  "s/ - ?([^-]+) ?- /, \1, /g" "$file"
done;
```

Foi decidido substituir esses pares parênteses por apostos separados por vírgula.

Foram removidas as linhas que apareciam em mais de um arquivo:

```bash
bigfile=corpora/noticias/bigfile.txt
repeated=corpora/noticias/repeated.txt

for file in `find corpora/noticias/*/ -type f -name "*.txt"`; do
    echo "[pass 1] $file"
    cat "$file" >> "$bigfile"
done;

# gera lista de linhas repetidas
sort "$bigfile" | uniq --repeated > "$repeated"

for file in `find corpora/noticias/*/ -type f -name "*.txt"`; do
    echo "[pass 2] $file"
    grep --fixed-strings --line-regexp --invert-match --file="$repeated" "$file" > "$file".tmp ; mv "$file".tmp "$file"
done;

rm "$bigfile"
rm "$repeated"
```

O objetivo do script acima foi remover linhas que ocorrem propositais em várias páginas, por exemplo: "Você pode de se inscrever na newsletter". Porém ele tem também remove linhas de repetições acidentais, por exemplo, arquivos que contém receitas de bolo poderão ter linhas que contém ingredientes apagadas, caso esses ingredientes apareçam em mais de um arquivo. Para a tarefa atual, isso não foi um problema.

Mais uma vez, foram removidas as linhas que não terminam com pontuação final (.!?).

```
for file in `find corpora/noticias/*/ -type f -name "*.txt"`; do
    echo "$file"
    grep -E --only-matching "^.*[\.\?\!]$" "$file" > "$file".tmp ; mv "$file".tmp "$file"
done;
```

Os arquivos foram todos normalizados para a codificação UTF-8:

```
# normalize files to UTF-8
for file in `find corpora/noticias/*/ -type f -name "*.txt"`; do
    MIME=`file -bi "$file"`
    if [[ "$MIME" =~ ^text/plain\;\ charset=.+$ ]];
    then
        CHARSET=`echo "$MIME" | sed -E "s/text\/plain; charset=//"`
        if [[ "$CHARSET" != "utf-8" ]];
        then
            echo "[$CHARSET] $file"
            iconv -f $CHARSET -t UTF8//TRANSLIT "$file".tmp > "$file"
        fi;
    fi;
done;
```

O script acima não converteu nenhum arquivo, por estarem todos em UTF-8.

Foram removidos os arquivos menores que 4K.

```bash
# usando -5k porque o find arredonda o tamanho do arquivo para cima
find corpora/noticias/ -type f -name "*.txt" -size -5k -exec rm "{}" \;
```

```bash
find corpora/noticias -type f -name "*.txt" | wc -l
2151
```

```bash
du -sh corpora/noticias/*
6,4M	corpora/noticias/site1
7,2M	corpora/noticias/site2
5,7M	corpora/noticias/site3
```

```bash
# a copia original foi removida no fim do processo
# cp -a corpora/noticias/ corpora/noticias.original/
```

Foi feita uma contagem simples de palavras únicas (formas/tokens):

```bash
bigfile=corpora/noticias/bigfile.txt
wordcount=corpora/noticias/wordcount.txt

cat /dev/null > "$bigfile"

for file in `find corpora/noticias/*/ -type f -name "*.txt"`; do
    echo "[pass 1] $file"
    grep -E --only-matching "\b[[:alpha:]]+\b" "$file" >> "$bigfile"
done;

cat "$bigfile" | tr [:upper:] [:lower:] | sort | uniq --count | sort --reverse --human-numeric-sort > "$wordcount"

wc -l "$wordcount"

rm "$bigfile"
```

Foram contadas cerca de 63 mil palavras únicas (formas/tokens) no corpus. Não foi feito lemmatization nem stemming.

Depois disso o corpus ficou pronto para o processamento pelo script `programa.R`.


