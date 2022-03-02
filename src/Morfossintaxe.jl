
function inicia_com(palavra::AbstractString, inicio::Array{String})::Bool
	for i in inicio
		if startswith(palavra, i)
			return true
		end
	end
	return false
end

function termina_com(palavra::AbstractString, fim::Array{String})::Bool
	for i in fim
		if endswith(palavra, i)
			return true
		end
	end
	return false
end


## Function used to sort by length desc
#function sort_by_length(lista::Array{String})
#	return reverse(unique(sort(sort(lista), by=length)))
#end

const LISTA_SUFIXOS_SUBSTANTIVOS = [ # sorted by length desc
	"ência", "ância", "ático", "zinho", "mento", "douro", "cídio", "ório",
	"ício", "ície", "ério", "âneo", "ázio", "ário", "áceo", "ácea", "usco",
	"ugem", "tude", "orra", "onho", "oide", "ista", "ismo", "isco", "inho",
	"esco", "eria", "ença", "ento", "engo", "eiro", "eira", "dade", "culo",
	"cula", "cida", "aréu", "arra", "aria", "ardo", "ança", "aico", "agem",
	"acho", "ção", "vel", "ura", "ume", "ulo", "ula", "ude", "tor", "sor", "ote",
	"ose", "ola", "nte", "iço", "ivo", "ite", "ina", "ico", "ice", "eza", "eto",
	"eta", "eno", "ela", "ejo", "edo", "dão", "dor", "aço", "aça", "ato", "ado",
	"ada", "ão", "ol", "io", "im", "il", "ia", "ez", "al"
]

const LISTA_SUFIXOS_ADJETIVOS = [ # sorted by length desc
	"íssimo", "érrimo", "ático", "zinho", "douro", "cídio", "ório", "ício",
	"âneo", "ário", "áceo", "ácea", "usco", "ugem", "onho", "oide", "ista",
	"isco", "inho", "esco", "ento", "ense", "engo", "eiro", "eira", "culo",
	"cula", "cida", "ardo", "ando", "aico", "acho", "íno", "vel", "ulo",
	"ula", "udo", "tor", "sor", "ote", "ose", "ola", "nte", "iço", "ivo",
	"ite", "ino", "ina", "imo", "ico", "eto", "eta", "eso", "esa", "eno",
	"ela", "ejo", "dor", "ato", "ano", "ado", "ês", "ão", "ol", "im", "il",
	"ia", "eu", "eo", "ar", "al"
]

const LISTA_SUFIXOS_VERBOS = [ # sorted by length desc
	"iscar", "inhar", "ilhar", "ficar", "entar", "izar", "itar",
	"icar", "ejar", "ecer", "açar", "ear", "ir", "er", "ar"
]

const LISTA_SUFIXOS_VERBOS_CONJUGADOS = [ # sorted by length desc
	# TODO
]

const LISTA_ADVERBIOS = [
	"abaixo", "acaso", "acima", "adiante", "agora", "aí",
	"ainda", "além", "ali", "amanhã", "anteontem", "antes",
	"aquém", "aqui", "assaz", "assim", "atrás", "através",
	"bastante", "bem", "breve", "cá", "cedo", "certamente",
	"como", "debalde", "defronte", "demais", "dentro", "depois",
	"depressa", "detrás", "devagar", "efetivamente", "então",
	"fora", "hoje", "já", "jamais", "junto", "lá", "logo",
	"longe", "mais", "mal", "melhor", "menos", "muito", "não",
	"nunca", "onde", "ontem", "outrora", "perto", "pior",
	"porventura", "possivelmente", "pouco", "provavelmente",
	"quando", "quanto", "quão", "quase", "quiçá", "realmente",
	"sempre", "sim", "talvez", "tampouco", "tanto", "tão", "tarde"
]

const LISTA_PREPOSICOES = [
	"a", "ante", "após", "até", "com", "contra", "de", "desde", "em",
	"entre","para", "per", "perante", "por", "sem", "sob", "sobre", "trás"
]

const LISTA_ARTIGOS = [
	"a", "as", "o", "os", "um", "uns", "uma", "umas"
]

const LISTA_ARTIGOS_CONTRAIDOS = [
	"à", "às", "da", "das",
	"na", "nas", "pela", "pelas",
	"ao", "aos", "do", "dos",
	"no", "nos", "pelo", "pelos",
	"dum", "duns", "duma", "dumas",
	"num", "nuns", "numa", "numas",
	"pra", "pras", "pro", "pros"
]

const LISTA_NUMERAIS = [
	"zero", "um", "uma", "dois", "duas", "três", "quatro", "cinco", "seis",
	"sete", "oito", "nove", "dez", "onze", "doze", "treze", "quatorze",
	"quinze", "dezesseis", "dezessete", "dezoiteo", "dezenove", "vinte",
	"trinta", "quarenta", "cinquenta", "sessenta", "setenta", "oitenta",
	"noventa", "cem", "duzentos", "duzentas", "trezentos", "trezentas",
	"quatrocentos", "quatrocentas", "quinhentos", "quinhentas",
	"seiscentos", "seiscentas", "setecentos", "setecentas", "oitocentos",
	"oitocentas", "novecentos", "novecentas", "mil", "milhão", "bilhão",
	"primeiro", "primeira", "primeiros", "primeiras", "segundo", "segunda",
	"segundos", "segundas", "terceiro", "terceira", "terceiros", "terceiras",
	"quarto", "quarta", "quartos", "quartas", "quinto", "quinta", "quntos",
	"quintas", "sexto", "sexta", "sextos", "sextas", "sétimo", "sétima",
	"sétimos", "sétimas", "oitavo", "oitava", "oitavos", "oitavas", "nono",
	"nona", "nonos", "nonas", "décimo", "décima", "décimos", "décimas",
	"undécimo", "undécima", "undécimos", "undécimas", "duodécimo",
	"doudécima", "duodécimos", "duodécimas", "vigésimo", "vigésima",
	"vigésimos", "vigésimas", "trigésimo", "trigésima", "trigésimos",
	"trigésimas", "quadragésimo", "quadragésima", "quadragésimos",
	"quadragésimas", "quinquagésimo", "quinquagésima", "quinquagésimos",
	"quinquagésimas", "sexagésimo", "sexagésima", "sexagésimos", "sexagésimas",
	"septuagésimo", "septuagésima", "septuagésimos", "septuagésimas",
	"octogésimo", "octogésima", "octogésimos", "octogésimas", "nonagésimo",
	"nonagésima", "nonagésimos", "nonagésimas", "centésimo", "centésima",
	"centésimos", "centésimas", "duocentésimo", "duocentésima", "duocentésimos",
	"duocentésimas", "trecentésimo", "trecentésima", "trecentésimos",
	"trecentésimas", "tricentésimo", "tricentésima", "tricentésimos",
	"tricentésimas", "quadringentésimo", "quadringentésima", "quadringentésimos",
	"quadringentésimas", "quingentésimo", "quingentésima", "quingentésimos",
	"quingentésimas", "seiscentésimo", "seiscentésima", "seiscentésimos",
	"seiscentésimas", "sexcentésimo", "sexcentésima", "sexcentésimos",
	"sexcentésimas", "septingentésimo", "septingentésima", "septingentésimos",
	"septingentésimas", "octingentésimo", "octingentésima", "octingentésimos",
	"octingentésimas", "nongentésimo", "nongentésima", "nongentésimos",
	"nongentésimas", "noningentésimo", "noningentésima", "noningentésimos",
	"noningentésimas", "milésimo", "milésima", "milésimos", "milésimas",
	"milionésimo", "milionésima", "milionésimos", "milionésimas", "bilionésimo",
	"bilionésima", "bilionésimos", "bilionésimas", "duplo", "dupla", "duplos",
	"duplas", "dobro", "dobra", "dobros", "dobras", "dúplice", "dúplices", "triplo",
	"tripla", "triplos", "triplas", "tríplice", "tríplices", "quádruplo", "quádrupla",
	"quádruplos", "quádruplas", "quíntuplo", "quíntupla", "quíntuplos", "quíntuplas",
	"sêxtuplo", "sêxtupla", "sêxtuplos", "sêxtuplas", "séptuplo", "séptupla",
	"séptuplos", "séptuplas", "octuplo", "octupla", "octuplos", "octuplas", "nônuplo",
	"nônupla", "nônuplos", "nônuplas", "décuplo", "décupla", "décuplos", "décuplas",
	"undécuplo", "undécupla", "undécuplos", "undécuplas", "duodécuplo", "doudécupla",
	"duodécuplos", "doudécuplas", "cêntuplo", "cêntupla", "cêntuplos", "cêntuplas",
	"meio", "meia", "meios", "meias", "metade", "metades", "terço", "terça", "terços",
	"terpas", "quarto", "quarta", "quartos", "quartas", "quinto", "quinta", "quintos",
	"quintas", "sexto", "sexta", "sextos", "sextas", "sétimo", "sétima", "sétimos",
	"sétimas", "oitavo", "oitava", "oitavos", "oitavas", "nono", "nona", "nonos",
	"nonas", "décimo", "décima", "décimos", "décimas", "undécimo", "undécima",
	"undécimos", "undécimas", "centésimo", "centésima", "centésimos", "centésimas",
	"milésimo", "milésima", "milésimos", "milésimas", "milionésimo", "milionésima",
	"milionésimos", "milionésimas", "bilionésimo", "bilionésima", "bilionésimos",
	"bilionésimas", "par", "novena", "dezena", "década", "dúzia", "centena", "cento",
	"lustro", "milhar", "milheiro", "I", "II", "III", "IV", "V", "VI", "VII", "VIII",
	"IX", "X", "XI", "XII", "XIII", "XIV", "XV", "XVI", "XVII", "XVIII", "XIX", "XX",
	"XXI", "XXII", "XXIII", "XXIV", "XXV", "XXVI", "XXVII", "XXVIII", "XXIX", "XXX",
	"XXXI", "XXXII", "XXXIII", "XXXIV", "XXXV", "XXXVI", "XXXVII", "XXXVIII", "XXXIX",
	"XL", "XLI", "XLII", "XLIII", "XLIV", "XLV", "XLVI", "XLVII", "XLVIII", "XLIX", "L"
]

const LISTA_LOCUCOES_ADVERBIAIS = [
	"com certeza", "por certo", "sem dúvida", "de muito", "de pouco",
	"de todo", "à direita", "à esquerda", "à distância", "ao lado",
	"de dentro", "de cima", "de longe", "de perto", "em cima",
	"para dentro", "para onde", "por ali", "por aqui", "por dentro",
	"por fora", "por onde", "por perto", "à toa", "à vontade",
	"ao contrário", "ao léu", "às avessas", "às claras", "às direitas",
	"às pressas", "com gosto", "com amor", "de cor", "de regra",
	"em geral", "em silêncio", "em vão", "por acaso", "à noite", "à tarde",
	"à tardinha", "de dia", "de manhã", "de noite", "em breve", "pela manhã"
]

function eh_substantivo(palavra::AbstractString)::Bool
	return termina_com(palavra, LISTA_SUFIXOS_SUBSTANTIVOS)
end

function eh_adjetivo(palavra::AbstractString)::Bool
	return termina_com(palavra, LISTA_SUFIXOS_ADJETIVOS)
end

function eh_verbo(palavra::AbstractString)::Bool
	return termina_com(palavra, LISTA_SUFIXOS_VERBO) || termina_com(palavra, LISTA_SUFIXOS_VERBOS_CONJUGADOS)
end

function eh_adverbio(palavra::AbstractString)::Bool
	return in(palavra, LISTA_ADVERBIOS) || termina_com(palavra, "mente")
end

function eh_preposicao(palavra::AbstractString)::Bool
	return in(palavra, LISTA_PREPOSICOES)
end

function eh_artigo(palavra::AbstractString)::Bool
	return in(palavra, LISTA_ARTIGOS)
end

function eh_artigo_contraido(palavra::AbstractString)::Bool
	return in(palavra, LISTA_ARTIGOS_CONTRAIDOS)
end

function eh_numeral(palavra::AbstractString)::Bool
	return in(palavra, LISTA_NUMERAIS)
end

function eh_nome(palavra::AbstractString)::Bool
	return eh_substantivo(palavra) || eh_adjetivo(palavra)
end

function eh_locucao_adverbial(frase::Array{String})::Bool
	return in(palavra, split(LISTA_LOCUCOES_ADVERBIAIS)) || (eh_preposicao(frase[1]) && eh_adverbio(frase[2]))
end

function eh_sintagma_nominal(frase::Array{String})::Bool
	return false # TODO
end

function eh_sintagma_verbal(frase::Array{String})::Bool
	return false # TODO
end

function eh_sintagma_preposicionado(frase::Array{String})::Bool
	return false # TODO
end

