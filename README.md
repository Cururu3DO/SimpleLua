EssentialLua

EssentialLua é uma biblioteca para Lua que tem como objetivo simplificar tarefas comuns da linguagem. Ela reúne funções úteis para reduzir a quantidade de código necessária em operações frequentes, tornando o desenvolvimento mais simples, principalmente para iniciantes.

Instalação

1. Baixe o arquivo ".zip" da biblioteca.
2. Extraia o conteúdo.
3. Copie o arquivo "elua.lua" para a pasta do seu projeto.

Exemplo:

MeuProjeto/
├── main.lua
└── elua.lua

No arquivo "main.lua", importe a biblioteca:

local elua = require("elua")

Agora ela já está pronta para ser utilizada.

Funções

elua.input()

Exibe uma mensagem e aguarda a entrada do usuário.

Sintaxe:

local nome = elua.input("Digite seu nome: ")

Retorno:

Retorna o texto digitado pelo usuário.

---

elua.has()

Verifica se um valor existe dentro de uma tabela.

Sintaxe:

local frutas = {
    "Maçã",
    "Banana",
    "Uva"
}

if elua.has(frutas, "Banana") then
    print("Valor encontrado!")
end

Retorno:

- "true" caso o valor exista.
- "false" caso não exista.

---

elua.file.create()

Cria um novo arquivo.

Sintaxe:

elua.file.create("save.txt")

Retorno:

- "true" se o arquivo foi criado.
- "false" caso ocorra algum erro.

---

elua.file.exists()

Verifica se um arquivo existe.

Sintaxe:

if elua.file.exists("save.txt") then
    print("Arquivo encontrado.")
end

Retorno:

- "true" se o arquivo existir.
- "false" caso contrário.

---

elua.file.write()

Escreve um conteúdo em um arquivo.

Se o arquivo já possuir conteúdo, ele será substituído.

Sintaxe:

elua.file.write("save.txt", "Vida=100")

Retorno:

- "true" se a escrita foi realizada com sucesso.
- "false" caso ocorra algum erro.

Licença

Você pode utilizar a EssentialLua livremente em seus projetos, respeitando a licença disponível no repositório da biblioteca.
