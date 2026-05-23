-- sl.lua (Simple Lua)
-- Biblioteca para facilitar desenvolvimento de sistemas

local sl = {}

-- CRIA TODAS AS TABELAS NECESSARIAS
sl.state = {}
sl.file = {}
sl.event = {}
sl.config = {}

-- ============================================
-- ENTRADA E SAIDA
-- ============================================

function sl.input(msg)
    io.write(msg or "")
    return io.read()
end

function sl.printl(...)
    print(...)
end

-- ============================================
-- CONVERSOES E VALIDACOES
-- ============================================

function sl.num(valor)
    return tonumber(valor) or 0
end

function sl.str(valor)
    return tostring(valor)
end

function sl.bool(valor)
    if type(valor) == "boolean" then return valor end
    if type(valor) == "number" then return valor ~= 0 end
    if type(valor) == "string" then
        local lower = valor:lower()
        return lower == "true" or lower == "1" or lower == "yes" or lower == "sim"
    end
    return false
end

function sl.isEmpty(valor)
    if valor == nil then return true end
    if type(valor) == "string" then return valor == "" end
    if type(valor) == "table" then return next(valor) == nil end
    return false
end

function sl.isNumber(valor)
    return type(valor) == "number" and valor == valor
end

function sl.isString(valor)
    return type(valor) == "string"
end

function sl.isTable(valor)
    return type(valor) == "table"
end

-- ============================================
-- MANIPULACAO DE STRINGS
-- ============================================

function sl.trim(str)
    if not str then return "" end
    return str:match("^%s*(.-)%s*$")
end

function sl.split(str, sep)
    if not str or str == "" then return {} end
    sep = sep or ","
    local partes = {}
    for parte in string.gmatch(str, "([^" .. sep .. "]+)") do
        table.insert(partes, sl.trim(parte))
    end
    return partes
end

function sl.join(lista, sep)
    if not lista or #lista == 0 then return "" end
    sep = sep or ","
    return table.concat(lista, sep)
end

function sl.startsWith(str, inicio)
    if not str or not inicio then return false end
    return str:sub(1, #inicio) == inicio
end

function sl.endsWith(str, final)
    if not str or not final then return false end
    return str:sub(-#final) == final
end

function sl.replace(str, busca, substitui)
    if not str then return "" end
    return str:gsub(busca, substitui)
end

function sl.upper(str)
    return string.upper(str or "")
end

function sl.lower(str)
    return string.lower(str or "")
end

-- ============================================
-- MANIPULACAO DE TABELAS
-- ============================================

function sl.push(lista, valor)
    if not lista then return end
    table.insert(lista, valor)
end

function sl.remove(lista, index)
    if not lista then return nil end
    return table.remove(lista, index)
end

function sl.contains(lista, valor)
    if not lista then return false end
    for _, v in ipairs(lista) do
        if v == valor then return true end
    end
    return false
end

function sl.each(lista, func)
    if not lista or not func then return end
    for i = 1, #lista do
        func(lista[i], i)
    end
end

function sl.filter(lista, func)
    if not lista or not func then return {} end
    local resultado = {}
    for i, v in ipairs(lista) do
        if func(v, i) then
            table.insert(resultado, v)
        end
    end
    return resultado
end

function sl.map(lista, func)
    if not lista or not func then return {} end
    local resultado = {}
    for i, v in ipairs(lista) do
        resultado[i] = func(v, i)
    end
    return resultado
end

function sl.reduce(lista, func, inicial)
    if not lista then return inicial end
    local acc = inicial
    for i, v in ipairs(lista) do
        acc = func(acc, v, i)
    end
    return acc
end

function sl.clone(tabela)
    if not tabela then return {} end
    local destino = {}
    for k, v in pairs(tabela) do
        if type(v) == "table" then
            destino[k] = sl.clone(v)
        else
            destino[k] = v
        end
    end
    return destino
end

function sl.merge(destino, origem)
    if not destino then return origem or {} end
    if not origem then return destino end
    for k, v in pairs(origem) do
        destino[k] = v
    end
    return destino
end

-- ============================================
-- SISTEMA DE ARQUIVOS
-- ============================================

function sl.file.exists(nome)
    local f = io.open(nome, "r")
    if f then
        f:close()
        return true
    end
    return false
end

function sl.file.write(nome, texto)
    local f = io.open(nome, "w")
    if f then
        f:write(texto or "")
        f:close()
        return true
    end
    return false
end

function sl.file.read(nome)
    local f = io.open(nome, "r")
    if f then
        local conteudo = f:read("*a")
        f:close()
        return conteudo
    end
    return nil
end

function sl.file.append(nome, texto)
    local f = io.open(nome, "a")
    if f then
        f:write(texto or "")
        f:close()
        return true
    end
    return false
end

function sl.file.lines(nome)
    local linhas = {}
    for linha in io.lines(nome) do
        table.insert(linhas, linha)
    end
    return linhas
end

-- ============================================
-- VALIDACOES COMUNS
-- ============================================

function sl.isEmail(email)
    if not email then return false end
    return email:match("^[%w._%-]+@[%w._%-]+%.%w+$") ~= nil
end

function sl.isCPF(cpf)
    if not cpf then return false end
    local numeros = cpf:gsub("%D", "")
    if #numeros ~= 11 then return false end
    
    local repetido = true
    for i = 2, 11 do
        if numeros:sub(i, i) ~= numeros:sub(1, 1) then
            repetido = false
            break
        end
    end
    if repetido then return false end
    
    local soma = 0
    for i = 1, 9 do
        soma = soma + tonumber(numeros:sub(i, i)) * (11 - i)
    end
    local resto = (soma * 10) % 11
    local digito1 = (resto == 10 or resto == 11) and 0 or resto
    
    if tonumber(numeros:sub(10, 10)) ~= digito1 then
        return false
    end
    
    soma = 0
    for i = 1, 10 do
        soma = soma + tonumber(numeros:sub(i, i)) * (12 - i)
    end
    resto = (soma * 10) % 11
    local digito2 = (resto == 10 or resto == 11) and 0 or resto
    
    return tonumber(numeros:sub(11, 11)) == digito2
end

function sl.isTelefone(fone)
    if not fone then return false end
    local numeros = fone:gsub("%D", "")
    return #numeros >= 10 and #numeros <= 11
end

-- ============================================
-- OPERACOES MATEMATICAS
-- ============================================

function sl.isPar(n)
    return n % 2 == 0
end

function sl.isImpar(n)
    return n % 2 ~= 0
end

function sl.getNumber(texto)
    if not texto then return nil end
    local n = texto:match("%d+")
    return n and tonumber(n) or nil
end

function sl.clamp(valor, min, max)
    return math.max(min, math.min(max, valor))
end

function sl.randomInt(min, max)
    math.randomseed(os.time())
    return math.random(min, max)
end

function sl.round(num, decimal)
    decimal = decimal or 0
    local mult = 10 ^ decimal
    return math.floor(num * mult + 0.5) / mult
end

-- ============================================
-- DATAS E TEMPO
-- ============================================

function sl.now()
    return os.time()
end

function sl.date(fmt, timestamp)
    fmt = fmt or "%Y-%m-%d %H:%M:%S"
    return os.date(fmt, timestamp or os.time())
end

function sl.wait(segundos)
    segundos = tonumber(segundos) or 0
    if segundos <= 0 then return end
    
    local socket_ok, socket = pcall(require, "socket")
    if socket_ok then
        socket.sleep(segundos)
        return
    end
    
    local fim = os.time() + segundos
    while os.time() < fim do
    end
end

-- ============================================
-- SISTEMA DE LOG
-- ============================================

local niveis = {
    DEBUG = 1,
    INFO = 2,
    WARN = 3,
    ERROR = 4,
    NONE = 5
}

sl.nivelLog = niveis.INFO
sl.niveis = niveis

function sl.setNivelLog(nivel)
    sl.nivelLog = nivel
end

function sl.debug(...)
    if sl.nivelLog <= niveis.DEBUG then
        print("[DEBUG]", sl.date("%H:%M:%S"), ...)
    end
end

function sl.info(...)
    if sl.nivelLog <= niveis.INFO then
        print("[INFO]", sl.date("%H:%M:%S"), ...)
    end
end

function sl.warn(...)
    if sl.nivelLog <= niveis.WARN then
        print("[WARN]", sl.date("%H:%M:%S"), ...)
    end
end

function sl.error(...)
    if sl.nivelLog <= niveis.ERROR then
        print("[ERROR]", sl.date("%H:%M:%S"), ...)
    end
end

-- ============================================
-- SISTEMA DE ESTADO/CONDICOES
-- ============================================

function sl.state.is(valor, esperado)
    return valor == esperado
end

function sl.state.isNot(valor, esperado)
    return valor ~= esperado
end

function sl.state.isTrue(valor)
    return not (valor == nil or valor == false)
end

function sl.state.isFalse(valor)
    return valor == nil or valor == false
end

-- ============================================
-- SISTEMA DE EVENTOS
-- ============================================

local eventos = {}

function sl.event.on(nome, func)
    if not eventos[nome] then
        eventos[nome] = {}
    end
    table.insert(eventos[nome], func)
end

function sl.event.emit(nome, ...)
    if eventos[nome] then
        for i = 1, #eventos[nome] do
            eventos[nome][i](...)
        end
    end
end

function sl.event.off(nome, func)
    if not eventos[nome] then return end
    if not func then
        eventos[nome] = {}
        return
    end
    for i = #eventos[nome], 1, -1 do
        if eventos[nome][i] == func then
            table.remove(eventos[nome], i)
        end
    end
end

function sl.event.clear()
    eventos = {}
end

-- ============================================
-- SISTEMA DE CONFIGURACAO
-- ============================================

local config = {}

function sl.config.set(chave, valor)
    config[chave] = valor
end

function sl.config.get(chave, padrao)
    local valor = config[chave]
    return valor ~= nil and valor or padrao
end

function sl.config.getAll()
    return sl.clone(config)
end

function sl.config.load(caminho)
    if not sl.file.exists(caminho) then
        return false
    end
    
    local conteudo = sl.file.read(caminho)
    if not conteudo then return false end
    
    local func = load("return " .. conteudo)
    if func then
        local tabela = func()
        if type(tabela) == "table" then
            sl.merge(config, tabela)
            return true
        end
    end
    return false
end

function sl.config.save(caminho)
    local conteudo = "{\n"
    for k, v in pairs(config) do
        if type(v) == "string" then
            conteudo = conteudo .. string.format('  ["%s"] = "%q",\n', k, v)
        elseif type(v) == "number" then
            conteudo = conteudo .. string.format('  ["%s"] = %s,\n', k, tostring(v))
        elseif type(v) == "boolean" then
            conteudo = conteudo .. string.format('  ["%s"] = %s,\n', k, v and "true" or "false")
        elseif type(v) == "table" then
            conteudo = conteudo .. string.format('  ["%s"] = {},\n', k)
        end
    end
    conteudo = conteudo .. "}"
    return sl.file.write(caminho, conteudo)
end

-- ============================================
-- LOOP SIMPLIFICADO
-- ============================================

function sl.repeatN(vezes, func)
    if not func then return end
    for i = 1, vezes do
        func(i)
    end
end

-- ============================================
-- EXPORTA BIBLIOTECA
-- ============================================

return sl
