local elua = {}

-- Modulos

elua.file = {}

-- Entradas

function elua.input(msg)
    io.write(msg or "")
    return io.read()
end

-- Procuras de tabelas

function elua.has(tabela, valor)
    for _, item in ipairs(tabela) do
        if item == valor then
            return true
        end
    end
    return false
end

-- Criar arquivos

function elua.file.create(nome)
    local arquivo = io.open(nome, "w")

    if arquivo then
        arquivo:close()
        return true
    end

    return false
end

-- Verificar arquivo

function elua.file.exists(nome)
    local arquivo = io.open(nome, "r")

    if arquivo then
        arquivo:close()
        return true
    end

        return false
end

-- Editar arquivo

function elua.file.write(nome, texto)
    local arquivo = io.open(nome, "w")

    if not arquivo then
        return false
    end

    arquivo:write(texto)
    arquivo:close()

    return true
end

return elua
