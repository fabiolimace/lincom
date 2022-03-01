
function inicia_com(palavra::String, inicio::String)::Bool
    return length(palavra) > length(inicio) && palavra[begin:length(inicio)] == inicio
end

function termina_com(palavra::String, fim::String)::Bool
    return length(palavra) > length(fim) && palavra[end-(length(fim)-1):end] == fim
end

function inicia_com(palavra::String, inicio::Array{String})::Bool
	for i in inicio
		if inicia_com(palavra, i)
			return true
		end
	end
	return false
end

function termina_com(palavra::String, fim::Array{String})::Bool
	for i in fim
		if termina_com(palavra, i)
			return true
		end
	end
	return false
end

const LISTA_SUFIXOS_SUBSTANTIVO = ["ção", "mento"]
const LISTA_SUFIXOS_ADJETIVO = ["íssima", "íssimo"]
const LISTA_SUFIXOS_ADVERBIO = ["mente"]

# classes fechadas de palavras
const LISTA_ADVERBIOS = ["bem", "mal", "muito", "pouco"]
const LISTA_PREPOSICOES = ["a", "de", "para"] # implementar contracoes "à", "ao", "da", "do", "pra", "pro" etc

# verificacao morfologica (PODE ser)
function pode_ser_substantivo(palavra::String)::Bool
	return termina_com(palavra, LISTA_SUFIXOS_SUBSTANTIVO)
end

# verificacao morfossintatica (DEVE ser)
function deve_ser_substantivo(palavra::String)::Bool
	return false # TODO: implementar
end

# verificacao morfologica (PODE ser)
function pode_ser_adjetivo(palavra::String)::Bool
	return termina_com(palavra, LISTA_SUFIXOS_ADJETIVO)
end

# verificacao morfossintatica (DEVE ser)
function deve_ser_adjetivo(palavra::String)::Bool
	return false # TODO: implementar
end

# verificacao morfologica (PODE ser)
function pode_ser_adverbio(palavra::String)::Bool
	return in(palavra, LISTA_ADVERBIOS) || termina_com(palavra, LISTA_SUFIXOS_ADVERBIO)
end

# verificacao morfossintatica (DEVE ser)
function deve_ser_adverbio(palavra::String)::Bool
	return false # TODO: implementar
end

# verificacao morfologica (PODE ser)
function pode_ser_preposicao(palavra::String)::Bool
	return in(palavra, LISTA_PREPOSICOES)
end

# verificacao morfossintatica (DEVE ser)
function deve_ser_preposicao(palavra::String)::Bool
	return false # TODO: implementar
end
