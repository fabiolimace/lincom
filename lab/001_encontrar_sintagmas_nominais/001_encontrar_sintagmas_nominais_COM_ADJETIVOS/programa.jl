
include("../../src/Morfossintaxe.jl")

entrada = "trigramas.txt"
saida = "resultado.txt"

sn = []

# ler arquivo linha por linha
for line in readlines(entrada)
	tokens = split(line)
	# Procurar SNs neste formatos:
	# 1. SN = Det + Subst + Adj
	# 2. SN = Det + Adj + Subst
	# 3. SN = Prep + Det + Subst + Adj
	# 4. SN = Prep + Det + Adj + Subst
	if (eh_artigo(tokens[1]) || eh_artigo_contraido(tokens[1])) &&
	((eh_substantivo(tokens[2]) && eh_adjetivo(tokens[3])) || (eh_adjetivo(tokens[2]) && eh_substantivo(tokens[3])))
		push!(sn, line)
	end
end

# escrever em arquivo a lista de SNs
open(saida, "w") do io
	write(io, join(sort(sn), "\n"));
end

