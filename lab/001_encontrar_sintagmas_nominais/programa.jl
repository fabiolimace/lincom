
include("../../src/Morfossintaxe.jl")

entrada = "bigramas.txt"
saida = "resultado.txt"

sn = []

# ler arquivo linha por linha
for line in readlines(entrada)
	tokens = split(line)
	# Procurar SNs neste formatos:
	# 1. SN = Det + Subst
	# 2. SN = Prep + Det + Subst
	if (eh_artigo(tokens[1]) || eh_artigo_contraido(tokens[1])) && eh_substantivo(tokens[2])
		push!(sn, line)
	end
end

# escrever em arquivo a lista de SNs
open(saida, "w") do io
	write(io, join(sort(sn), "\n"));
end

