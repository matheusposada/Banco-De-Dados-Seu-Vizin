-- =====================================================================
-- 03_consultas.sql : trecho do Nicolas (Q1 a Q7)
-- Filtros (Q1 a Q3) e agregacoes (Q4 a Q7).
-- Pressupoe 01_ddl.sql e 02_dml.sql ja executados em um banco vazio.
-- =====================================================================

-- ---------------------------------------------------------------------
-- FILTROS (WHERE, LIKE, IN, BETWEEN) E ORDENACAO
-- ---------------------------------------------------------------------

-- Q1
-- Pergunta de negocio: quais farmacias e mercados o app mostra, em ordem
-- alfabetica?
-- Autor: Nicolas
SELECT nome, categoria
FROM estabelecimento
WHERE categoria IN ('farmacia', 'mercado')
ORDER BY nome;

-- Q2
-- Pergunta de negocio: quais avaliacoes de seguranca tem nota baixa
-- (entre 0,5 e 2,5) e citam assalto no motivo?
-- Autor: Nicolas
SELECT id_avaliacao, id_bairro, nota, motivo
FROM avaliacao
WHERE topico = 'seguranca'
  AND nota BETWEEN 0.5 AND 2.5
  AND motivo LIKE '%assalto%';

-- Q3
-- Pergunta de negocio: quais imoveis para alugar custam de R$ 1.500 a
-- R$ 3.000, do mais barato ao mais caro?
-- Autor: Nicolas
SELECT id_imovel, tipo, area_m2, preco
FROM imovel
WHERE finalidade = 'aluguel'
  AND preco BETWEEN 1500 AND 3000
ORDER BY preco ASC;

-- ---------------------------------------------------------------------
-- AGREGACAO, GROUP BY E HAVING
-- ---------------------------------------------------------------------

-- Q4
-- Pergunta de negocio: qual a nota media de cada bairro avaliado?
-- Observacao: a regra 8 diz que o app so exibe a nota geral com pelo
-- menos 3 avaliacoes; esta consulta lista todas, para analise.
-- Autor: Nicolas
SELECT b.nome AS bairro,
       COUNT(a.id_avaliacao) AS qtd_avaliacoes,
       ROUND(AVG(a.nota), 2) AS nota_media
FROM avaliacao a
JOIN bairro b ON b.id_bairro = a.id_bairro
GROUP BY b.id_bairro, b.nome
ORDER BY nota_media DESC;

-- Q5
-- Pergunta de negocio: quantas avaliacoes existem em cada topico?
-- Autor: Nicolas
SELECT topico, COUNT(*) AS qtd_avaliacoes
FROM avaliacao
GROUP BY topico
ORDER BY qtd_avaliacoes DESC;

-- Q6
-- Pergunta de negocio: quais bairros tem 3 ou mais avaliacoes e nota
-- media de pelo menos 4?
-- Autor: Nicolas
SELECT b.nome AS bairro,
       COUNT(a.id_avaliacao) AS qtd_avaliacoes,
       ROUND(AVG(a.nota), 2) AS nota_media
FROM avaliacao a
JOIN bairro b ON b.id_bairro = a.id_bairro
GROUP BY b.id_bairro, b.nome
HAVING COUNT(a.id_avaliacao) >= 3
   AND AVG(a.nota) >= 4;

-- Q7
-- Pergunta de negocio: qual o preco medio, minimo e maximo dos imoveis
-- em cada bairro, separado por finalidade (aluguel ou venda)?
-- Autor: Nicolas
SELECT b.nome AS bairro,
       i.finalidade,
       COUNT(*) AS qtd_imoveis,
       ROUND(AVG(i.preco), 2) AS preco_medio,
       MIN(i.preco) AS preco_minimo,
       MAX(i.preco) AS preco_maximo
FROM imovel i
JOIN bairro b ON b.id_bairro = i.id_bairro
GROUP BY b.id_bairro, b.nome, i.finalidade
ORDER BY b.nome, i.finalidade;
