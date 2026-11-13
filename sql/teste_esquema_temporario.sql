-- =====================================================================
-- ESQUEMA TEMPORARIO, SO PARA TESTAR O 02_dml.sql
-- NAO e o 01_ddl.sql do grupo (esse e do Vitor).
-- Mesma estrutura do modelo relacional dele, em sintaxe SQLite, com os
-- CHECKs combinados no roteiro. Descartar quando o DDL oficial sair.
-- =====================================================================
PRAGMA foreign_keys = ON;

CREATE TABLE cidade (
  id_cidade INTEGER PRIMARY KEY AUTOINCREMENT,
  nome      TEXT NOT NULL,
  estado    TEXT NOT NULL
);

CREATE TABLE bairro (
  id_bairro INTEGER PRIMARY KEY AUTOINCREMENT,
  id_cidade INTEGER NOT NULL REFERENCES cidade (id_cidade),
  nome      TEXT NOT NULL
);

CREATE TABLE imobiliaria (
  id_imobiliaria INTEGER PRIMARY KEY AUTOINCREMENT,
  id_matriz      INTEGER REFERENCES imobiliaria (id_imobiliaria),
  nome           TEXT NOT NULL,
  cnpj           TEXT NOT NULL UNIQUE CHECK (length(cnpj) = 14)
);

CREATE TABLE imovel (
  id_imovel      INTEGER PRIMARY KEY AUTOINCREMENT,
  id_bairro      INTEGER NOT NULL REFERENCES bairro (id_bairro),
  id_imobiliaria INTEGER REFERENCES imobiliaria (id_imobiliaria),
  tipo           TEXT NOT NULL CHECK (tipo IN ('apartamento','casa','kitnet','terreno')),
  finalidade     TEXT NOT NULL CHECK (finalidade IN ('aluguel','venda')),
  area_m2        REAL NOT NULL CHECK (area_m2 > 0),
  preco          REAL NOT NULL CHECK (preco > 0),
  status         TEXT NOT NULL DEFAULT 'pendente'
                 CHECK (status IN ('pendente','ativo','alugado','vendido'))
);

CREATE TABLE estabelecimento (
  id_estabelecimento INTEGER PRIMARY KEY AUTOINCREMENT,
  id_bairro          INTEGER NOT NULL REFERENCES bairro (id_bairro),
  nome               TEXT NOT NULL,
  categoria          TEXT NOT NULL CHECK (categoria IN ('mercado','farmacia','escola','transporte'))
);

CREATE TABLE usuario (
  id_usuario      INTEGER PRIMARY KEY AUTOINCREMENT,
  nome            TEXT NOT NULL,
  email           TEXT NOT NULL UNIQUE,
  data_nascimento TEXT NOT NULL,
  tipo            TEXT NOT NULL CHECK (tipo IN ('morador','interessado','proprietario','corretor'))
);

CREATE TABLE avaliacao (
  id_avaliacao     INTEGER PRIMARY KEY AUTOINCREMENT,
  id_usuario       INTEGER NOT NULL REFERENCES usuario (id_usuario),
  id_bairro        INTEGER NOT NULL REFERENCES bairro (id_bairro),
  data             TEXT NOT NULL,
  nota             REAL NOT NULL CHECK (nota BETWEEN 0.5 AND 5.0),
  topico           TEXT NOT NULL CHECK (topico IN ('seguranca','infraestrutura','custo_de_vida','qualidade_de_vida','comercio')),
  situacao_moradia TEXT NOT NULL CHECK (situacao_moradia IN ('atual','antigo')),
  motivo           TEXT,
  CHECK (nota >= 2.5 OR (motivo IS NOT NULL AND length(trim(motivo)) > 0)),
  UNIQUE (id_usuario, id_bairro, topico)
);
