## 📚 Simple Lua (SL) - Documentação v1.0.2

**Simple Lua** é uma biblioteca que simplifica o desenvolvimento de sistemas em Lua, oferecendo funções úteis para manipulação de strings, tabelas, arquivos, validações, logs e muito mais.

---

## 📦 Instalação

```bash
# Baixe o arquivo sl.lua e coloque na pasta do seu projeto
require("sl")  -- ou coloque em uma subpasta: require("libs.sl")
```

---

## 🚀 Uso básico

```lua
local sl = require("sl")

sl.info("Sistema iniciado!")
```

---

## 📖 Índice de funções

### 1. Entrada e Saída
| Função | Descrição |
|--------|-----------|
| `sl.input(msg)` | Mostra mensagem e retorna o que o usuário digitar |
| `sl.printl(...)` | Print simples |

### 2. Conversões
| Função | Descrição |
|--------|-----------|
| `sl.num(valor)` | Converte para número (ou 0 se falhar) |
| `sl.str(valor)` | Converte para string |
| `sl.bool(valor)` | Converte para boolean (`true`/`false`) |

### 3. Validações
| Função | Descrição |
|--------|-----------|
| `sl.isEmpty(valor)` | Verifica se é vazio (nil, "", tabela vazia) |
| `sl.isNumber(valor)` | Verifica se é número válido |
| `sl.isString(valor)` | Verifica se é string |
| `sl.isTable(valor)` | Verifica se é tabela |

### 4. Strings
| Função | Descrição |
|--------|-----------|
| `sl.trim(str)` | Remove espaços no início e fim |
| `sl.split(str, sep)` | Divide string em tabela |
| `sl.join(lista, sep)` | Junta tabela em string |
| `sl.startsWith(str, inicio)` | Verifica se começa com... |
| `sl.endsWith(str, final)` | Verifica se termina com... |
| `sl.replace(str, busca, novo)` | Substitui texto |
| `sl.upper(str)` | Converte para MAIÚSCULO |
| `sl.lower(str)` | Converte para minúsculo |

### 5. Tabelas (Listas)
| Função | Descrição |
|--------|-----------|
| `sl.push(lista, valor)` | Adiciona no final |
| `sl.remove(lista, index)` | Remove por índice |
| `sl.contains(lista, valor)` | Verifica se existe |
| `sl.each(lista, func)` | Itera sobre cada item |
| `sl.filter(lista, func)` | Filtra itens |
| `sl.map(lista, func)` | Transforma itens |
| `sl.reduce(lista, func, inicial)` | Acumula valores |
| `sl.clone(tabela)` | Copia tabela |
| `sl.merge(destino, origem)` | Mescla tabelas |

### 6. Arquivos
| Função | Descrição |
|--------|-----------|
| `sl.file.exists(caminho)` | Verifica se arquivo existe |
| `sl.file.read(caminho)` | Lê arquivo completo |
| `sl.file.write(caminho, texto)` | Escreve arquivo |
| `sl.file.append(caminho, texto)` | Adiciona ao final |
| `sl.file.lines(caminho)` | Retorna tabela com linhas |

### 7. Validações Comuns
| Função | Descrição |
|--------|-----------|
| `sl.isEmail(email)` | Verifica formato de email |
| `sl.isCPF(cpf)` | Valida CPF (com dígitos) |
| `sl.isTelefone(fone)` | Verifica telefone (10-11 dígitos) |

### 8. Matemática
| Função | Descrição |
|--------|-----------|
| `sl.isPar(n)` | Verifica se é par |
| `sl.isImpar(n)` | Verifica se é ímpar |
| `sl.getNumber(texto)` | Extrai número do texto |
| `sl.clamp(valor, min, max)` | Limita valor entre min/max |
| `sl.randomInt(min, max)` | Número aleatório |
| `sl.round(num, decimais)` | Arredonda |

### 9. Datas e Tempo
| Função | Descrição |
|--------|-----------|
| `sl.now()` | Timestamp atual |
| `sl.date(formato, timestamp)` | Data formatada |
| `sl.wait(segundos)` | Pausa a execução |

### 10. Logs
| Função | Descrição |
|--------|-----------|
| `sl.debug(...)` | Log de depuração |
| `sl.info(...)` | Log informativo |
| `sl.warn(...)` | Log de aviso |
| `sl.error(...)` | Log de erro |
| `sl.setNivelLog(nivel)` | Define nível (1-5) |

Níveis: `DEBUG=1`, `INFO=2`, `WARN=3`, `ERROR=4`, `NONE=5`

### 11. Estado
| Função | Descrição |
|--------|-----------|
| `sl.state.is(a, b)` | `a == b` |
| `sl.state.isNot(a, b)` | `a ~= b` |
| `sl.state.isTrue(v)` | `v` é verdadeiro |
| `sl.state.isFalse(v)` | `v` é falso/nil |

### 12. Eventos
| Função | Descrição |
|--------|-----------|
| `sl.event.on(nome, func)` | Registra evento |
| `sl.event.emit(nome, ...)` | Dispara evento |
| `sl.event.off(nome, func)` | Remove evento |
| `sl.event.clear()` | Remove todos eventos |

### 13. Configuração
| Função | Descrição |
|--------|-----------|
| `sl.config.set(chave, valor)` | Salva configuração |
| `sl.config.get(chave, padrao)` | Lê configuração |
| `sl.config.getAll()` | Retorna todas |
| `sl.config.load(caminho)` | Carrega de arquivo |
| `sl.config.save(caminho)` | Salva em arquivo |

### 14. Loop
| Função | Descrição |
|--------|-----------|
| `sl.repeatN(vezes, func)` | Repete função N vezes |

---

## 💡 Exemplos práticos

### Exemplo 1: Validação de formulário

```lua
local sl = require("sl")

local nome = sl.input("Nome: ")
local email = sl.input("Email: ")
local idade = sl.input("Idade: ")

if sl.isEmpty(nome) then
    sl.error("Nome obrigatorio")
elseif not sl.isEmail(email) then
    sl.error("Email invalido")
elseif sl.num(idade) < 18 then
    sl.warn("Menor de idade")
else
    sl.info("Cadastro valido!")
end
```

### Exemplo 2: Processamento de lista

```lua
local sl = require("sl")

local numeros = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}

-- Filtrar pares
local pares = sl.filter(numeros, function(n) return n % 2 == 0 end)
print("Pares:", sl.join(pares, ", "))

-- Dobrar valores
local dobrado = sl.map(numeros, function(n) return n * 2 end)

-- Somar tudo
local soma = sl.reduce(numeros, function(acc, n) return acc + n end, 0)
print("Soma:", soma)
```

### Exemplo 3: Sistema de configuração

```lua
local sl = require("sl")

-- Definir configuracoes
sl.config.set("app.nome", "Meu Sistema")
sl.config.set("app.versao", "1.0.0")
sl.config.set("debug", true)

-- Salvar
sl.config.save("config.lua")

-- Carregar depois
sl.config.load("config.lua")
print("App:", sl.config.get("app.nome"))
```

### Exemplo 4: Eventos

```lua
local sl = require("sl")

sl.event.on("usuario.logou", function(nome, hora)
    print(string.format("%s logou as %s", nome, hora))
end)

sl.event.on("usuario.saiu", function(nome)
    print(nome .. " saiu do sistema")
end)

-- Disparar eventos
sl.event.emit("usuario.logou", "Joao", sl.date("%H:%M"))
sl.event.emit("usuario.saiu", "Joao")
```

### Exemplo 5: Arquivo de log

```lua
local sl = require("sl")

sl.setNivelLog(sl.niveis.DEBUG)

function logAcao(usuario, acao)
    local linha = string.format("%s - %s: %s\n", 
        sl.date("%Y-%m-%d %H:%M:%S"), 
        usuario, 
        acao)
    sl.file.append("auditoria.log", linha)
    sl.info("Acao registrada")
end

logAcao("admin", "Cadastrou produto")
```

### Exemplo 6: CRUD simples

```lua
local sl = require("sl")

local arquivo = "dados.lua"

function salvar(registro)
    sl.config.set("data", registro)
    sl.config.save(arquivo)
end

function carregar()
    if sl.file.exists(arquivo) then
        sl.config.load(arquivo)
        return sl.config.get("data", {})
    end
    return {}
end

-- Usar
local dados = carregar()
sl.push(dados, {id = 1, nome = "Item 1"})
salvar(dados)
print("Total:", #dados)
```

---

## 📊 Níveis de Log

```lua
sl.setNivelLog(sl.niveis.DEBUG)  -- Mostra tudo
sl.setNivelLog(sl.niveis.INFO)   -- Mostra INFO, WARN, ERROR (padrão)
sl.setNivelLog(sl.niveis.WARN)   -- Mostra WARN, ERROR
sl.setNivelLog(sl.niveis.ERROR)  -- Mostra só ERROR
sl.setNivelLog(sl.niveis.NONE)   -- Não mostra nada
```

---

## 🎯 Formato de data

```lua
sl.date()                     -- 2024-01-15 14:30:25
sl.date("%Y-%m-%d")          -- 2024-01-15
sl.date("%H:%M:%S")          -- 14:30:25
sl.date("%d/%m/%Y")          -- 15/01/2024
```

**Códigos comuns:**
- `%Y` - ano (4 dígitos)
- `%y` - ano (2 dígitos)
- `%m` - mês (01-12)
- `%d` - dia (01-31)
- `%H` - hora (00-23)
- `%M` - minuto (00-59)
- `%S` - segundo (00-59)

---

## ⚠️ Observações

1. **`sl.wait()`** - Pausa o programa. Use com moderação.
2. **Arquivos** - As funções de arquivo retornam `true`/`false` para sucesso.
3. **CPF** - Valida dígitos verificadores e rejeita números repetidos.
4. **Eventos** - São globais dentro da biblioteca.

---

## 📝 Versão

**v1.0.2** - Simple Lua

---

## 🧪 Teste rápido

```lua
local sl = require("sl")

sl.info("SL v1.0.2 carregada!")
sl.info("Data atual: " .. sl.date())
sl.info("Numero aleatorio: " .. sl.randomInt(1, 100))

-- Verifica se tudo funciona
assert(sl.num("123") == 123)
assert(sl.trim("  teste  ") == "teste")
assert(sl.contains({1,2,3}, 2) == true)

print("\nTudo funcionando! ✅")
```

---

**Simple Lua - Simplificando seu código em Lua 🚀**
