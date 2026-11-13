# Seu Vizin: Banco de Dados

Projeto final da disciplina de Banco de Dados: *Do Zero ao Sistema*.

O **Seu Vizin** é um app para quem procura onde morar. Moradores avaliam bairros (segurança, infraestrutura, custo de vida etc.), o app mostra serviços próximos e lista imóveis anunciados por imobiliárias, com preço. Este repositório contém o banco de dados relacional do app, com dados fictícios.

## Equipe

| Nome | Responsabilidade |
| --- | --- |
| Matheus | MER, álgebra relacional, dicionário de dados e relatório |
| Vitor | Modelo relacional, normalização, DDL e consultas de junção |
| Nicolas | Povoamento (DML), consultas de filtro e agregação |
| Raul | Subconsultas, UNION/CASE, views e índice |

## Modelo do banco

7 tabelas: `cidade`, `bairro`, `usuario`, `avaliacao`, `estabelecimento`, `imobiliaria` e `imovel`.

- **N:N:** `usuario` e `bairro`, resolvido pela tabela `avaliacao`.
- **Autorrelacionamento:** `imobiliaria` (filial aponta para a matriz, `id_matriz`).
- **Atributos derivados:** idade do usuário, nota média do bairro e preço por m² do imóvel.

## Estrutura do repositório

```
.
├── README.md
├── relatorio/        # Relatório final em PDF
├── diagramas/        # MER e modelo relacional (imagens)
├── sql/
│   ├── 01_ddl.sql        # CREATE TABLE, restrições e ALTER TABLE
│   ├── 02_dml.sql        # INSERT, UPDATE e DELETE
│   └── 03_consultas.sql  # Consultas, views, álgebra relacional e índice
└── banco/
    └── seu_vizin.db      # Banco SQLite gerado pelos scripts
```

## Como executar

Requisito: [DB Browser for SQLite](https://sqlitebrowser.org/) (ou o comando `sqlite3`).

**Pelo terminal:**

```bash
sqlite3 banco/seu_vizin.db < sql/01_ddl.sql
sqlite3 banco/seu_vizin.db < sql/02_dml.sql
sqlite3 banco/seu_vizin.db < sql/03_consultas.sql
```

**Pelo DB Browser for SQLite:**

1. Crie um novo banco (`Arquivo > Novo Banco de Dados`) e salve em `banco/seu_vizin.db`.
2. Vá em `Executar SQL` e rode os scripts, nesta ordem: `01_ddl.sql`, `02_dml.sql` e `03_consultas.sql`.

> Os scripts devem sempre ser executados em um banco vazio e na ordem acima. O `01_ddl.sql` começa com `PRAGMA foreign_keys = ON;`.

## Convenções

- Nomes em minúsculas, sem acento, em `snake_case`, com tabelas no singular.
- Chave primária no formato `id_nomedatabela`.
- Nota de avaliação de 0,5 a 5,0. Nota abaixo de 2,5 exige motivo.
- Cada consulta tem um comentário com número, pergunta de negócio e autor.
- Cada pessoa trabalha na própria branch (ex.: `vitor/ddl`) e abre um pull request para a `main`.

## Prazos

| Data | Evento |
| --- | --- |
| 16/11 | Checkpoint |
| 30/11 | Entrega final e primeira rodada de apresentações |
| 04/12 | Segunda rodada de apresentações |

## Status

- [x] Regras de negócio e MER
- [ ] Modelo relacional, normalização e dicionário de dados
- [ ] `01_ddl.sql`
- [ ] `02_dml.sql`
- [ ] `03_consultas.sql` (22 itens: consultas, 2 views e 3 expressões de álgebra)
- [ ] Índice (aprofundamento)
- [ ] Relatório em PDF
- [ ] Ensaio da apresentação
