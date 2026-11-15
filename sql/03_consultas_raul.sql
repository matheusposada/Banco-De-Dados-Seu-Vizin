-- ---------------------------------------------------------------------
-- SUBCONSULTAS
-- ---------------------------------------------------------------------

-- Q13
-- Pergunta de negocio: quais imoveis para alugar custam mais do que a
-- media dos alugueis anunciados?
SELECT id_imovel, tipo, area_m2, preco
FROM imovel
WHERE finalidade = 'aluguel'
  AND preco > (SELECT AVG(preco)
               FROM imovel
               WHERE finalidade = 'aluguel')
ORDER BY preco DESC;

-- Q14
-- Pergunta de negocio: quais bairros tem algum estabelecimento de
-- transporte cadastrado?
SELECT nome AS bairro
FROM bairro
WHERE id_bairro IN (SELECT id_bairro
                    FROM estabelecimento
                    WHERE categoria = 'transporte')
ORDER BY nome;

-- Q15
-- Pergunta de negocio: quais avaliacoes ficaram abaixo da nota media do
-- proprio bairro?
-- Observacao: subconsulta correlacionada (usa o id_bairro da linha de
-- fora).
SELECT a.id_avaliacao, b.nome AS bairro, a.topico, a.nota
FROM avaliacao a
JOIN bairro b ON b.id_bairro = a.id_bairro
WHERE a.nota < (SELECT AVG(a2.nota)
                FROM avaliacao a2
                WHERE a2.id_bairro = a.id_bairro)
ORDER BY b.nome, a.nota;

-- ---------------------------------------------------------------------
-- UNION / DISTINCT
-- ---------------------------------------------------------------------

-- Q16
-- Pergunta de negocio: quais bairros tem alguma oferta para quem procura
-- onde morar (imovel anunciado ou estabelecimento cadastrado)?
-- Observacao: UNION (sem ALL) remove duplicados; um bairro que tem imovel
-- e estabelecimento aparece uma unica vez.
SELECT b.nome AS bairro
FROM bairro b
JOIN imovel i ON i.id_bairro = b.id_bairro
UNION
SELECT b.nome
FROM bairro b
JOIN estabelecimento e ON e.id_bairro = b.id_bairro
ORDER BY bairro;

-- ---------------------------------------------------------------------
-- CASE WHEN, FUNCOES DE DATA E DE TEXTO
-- ---------------------------------------------------------------------

-- Q17
-- Pergunta de negocio: como fica a lista de avaliacoes com motivo, com o
-- morador em maiusculas, o mes da avaliacao, a classificacao da nota
-- (positiva, neutra ou negativa) e o inicio do motivo?
-- Observacao: 2,5 e o limite da regra 7 (abaixo disso exige motivo).
-- Funcoes usadas: UPPER, SUBSTR (texto) e strftime (data).
SELECT UPPER(u.nome) AS morador,
       b.nome AS bairro,
       strftime('%m/%Y', a.data) AS mes_ano,
       CASE
         WHEN a.nota >= 4   THEN 'positiva'
         WHEN a.nota >= 2.5 THEN 'neutra'
         ELSE 'negativa'
       END AS classificacao,
       SUBSTR(a.motivo, 1, 30) AS inicio_motivo
FROM avaliacao a
JOIN usuario u ON u.id_usuario = a.id_usuario
JOIN bairro b ON b.id_bairro = a.id_bairro
WHERE a.motivo IS NOT NULL
ORDER BY a.data;

-- ---------------------------------------------------------------------
-- VIEWS
-- ---------------------------------------------------------------------

-- V1
-- Pergunta de negocio: qual a nota media que o app exibe para cada
-- bairro? (a nota media e atributo derivado, nao fica armazenada)
-- Observacao: regra 8, so aparece bairro com pelo menos 3 avaliacoes.
CREATE VIEW vw_nota_bairro AS
SELECT b.id_bairro,
       b.nome AS bairro,
       c.nome AS cidade,
       COUNT(a.id_avaliacao) AS qtd_avaliacoes,
       ROUND(AVG(a.nota), 2) AS nota_media
FROM avaliacao a
JOIN bairro b ON b.id_bairro = a.id_bairro
JOIN cidade c ON c.id_cidade = b.id_cidade
GROUP BY b.id_bairro, b.nome, c.nome
HAVING COUNT(a.id_avaliacao) >= 3;

-- Uso da V1
SELECT bairro, cidade, qtd_avaliacoes, nota_media
FROM vw_nota_bairro
ORDER BY nota_media DESC;

-- V2
-- Pergunta de negocio: qual o preco por m2 de cada imovel anunciado?
-- (o preco por m2 e atributo derivado, nao fica armazenado)
CREATE VIEW vw_imovel_preco_m2 AS
SELECT i.id_imovel,
       b.nome AS bairro,
       i.tipo,
       i.finalidade,
       i.area_m2,
       i.preco,
       ROUND(i.preco / i.area_m2, 2) AS preco_por_m2
FROM imovel i
JOIN bairro b ON b.id_bairro = i.id_bairro;

-- Uso da V2: imoveis a venda, do mais caro ao mais barato por m2
SELECT id_imovel, bairro, tipo, area_m2, preco, preco_por_m2
FROM vw_imovel_preco_m2
WHERE finalidade = 'venda'
ORDER BY preco_por_m2 DESC;

-- ---------------------------------------------------------------------
-- INDICE (aprofundamento)
-- ---------------------------------------------------------------------

-- Justificativa: as consultas por bairro sao as mais comuns do app (nota
-- media, avaliacoes de um bairro). O indice automatico do UNIQUE
-- (id_usuario, id_bairro, topico) comeca por id_usuario e nao ajuda a
-- buscar so por id_bairro; o indice novo evita varrer a tabela inteira.

-- Plano ANTES do indice
-- Resultado: SCAN avaliacao
EXPLAIN QUERY PLAN
SELECT AVG(nota) FROM avaliacao WHERE id_bairro = 1;

CREATE INDEX idx_avaliacao_id_bairro ON avaliacao (id_bairro);

-- Plano DEPOIS do indice
-- Resultado: SEARCH avaliacao USING INDEX idx_avaliacao_id_bairro (id_bairro=?)
EXPLAIN QUERY PLAN
SELECT AVG(nota) FROM avaliacao WHERE id_bairro = 1;
