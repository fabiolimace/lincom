#!/bin/julia

using DelimitedFiles

#=
FAZER

- Criar funçao para gerar amostras com algumas palavras
- Criar um módulo de limpeza de texto chamado `Limpeza.jl` (copiar as Regex do projeto tfidf-simples)
- Criar ferramenta que descobre qual o idioma de uma frase com base na lista de bigramas coletados.

=#


home = pwd()
homecorpus = home * "/" * "corpus"

function get_linguas()::Array{String,1}
	lis = readdir(homecorpus)
	return lis
end

function get_textos(lingua::String)::Array{String,1}
	return readdir(homecorpus * "/" * lingua)
end

function ler(lingua::String, texto::String)::String
	arquivo = homecorpus * "/" * lingua * "/" * texto
	return read(arquivo, String)
end

function lerlinhas(lingua::String, texto::String)::Array{String,1}
	arquivo = homecorpus * "/" * lingua * "/" * texto
	return readlines(arquivo)
end

function pushdict!(dict::Dict, item::Any)
	if (item in keys(dict))
		dict[item] += 1
	else
		push!(dict, item => 1)
	end
end

function bigramas!(tokens::Dict, texto::String)::Dict{Any,Any}

	words = split(lowercase(texto))

	for w in words

		#   | margem |        meio        | margem |
		#   |    1   |        0..n        |   1    |
		# 
		# a:     [[a_,1,1]]
		# de:    [[de,1,1]]
		# com:   [[co,1,0], [om,0,1]]
		# para:  [[pa,1,0], [ar,0,0], [ra,0,1]]
		# arara: [[ar,1,0], [ra,0,0], [ar,0,0], [ra,0,1]]
		chars = split(w, "")
		len = length(chars)
		margin = 1 # margen direita e esquerda
		
		if len == 1
			token = Any[]
			push!(token, chars[1])
			push!(token, nothing)
			push!(token, 1)
			push!(token, 1)
			pushdict!(tokens, token)
			continue
		end
		
		i = 1
		while i < len
			token = Any[]
			push!(token, chars[i])
			push!(token, chars[i+1])
			if i <= margin # margem direita
				push!(token, i)
			else
				push!(token, 0)
			end
			if i >= len - margin # margem esquerda
				push!(token, len - i)
			else
				push!(token, 0)
			end
			pushdict!(tokens, token)
			i += 1
		end
	end
	
	return tokens
end

function main()
	linguas = Dict{String, Dict}(map(x -> Pair(x, Dict()), get_linguas()))
	for lingua in keys(linguas)
		tokens = Dict()
		textos = get_textos(lingua)
		for texto in textos
			bigramas!(tokens, ler(lingua, texto))
		end
		linguas[lingua] = tokens
		println(lingua, ": ", length(tokens))
	end

	# CSV: [lingua, countsum]
	L = map(k -> [k, sum(values(linguas[k])) ], collect(keys(linguas)))
	writedlm( "linguas.csv",  L, ',')
	
	# CSV: [char1, char2, margin1, margin2, df, idf]
	d = Dict()
	foreach(x -> foreach(y -> pushdict!(d, y), keys(x[2])), collect(linguas))
	B = map(k -> vcat(k[1], k[2], log(length(linguas)/k[2])), collect(d))
	writedlm("bigramas.csv",  B, ',')
	
end

main()

