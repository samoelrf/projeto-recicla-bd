-- -- SCRIPT DE TESTES DE OPERAÇÕES PARA MYSQL
-- -- Simula o dia a dia do ecoponto.

USE recicla;

-- -- ====================================================================
-- -- CENÁRIO 1: Ana Silva (ID 1) descarta 10kg de Plástico
-- -- ====================================================================

-- 1.1. Consultar o saldo da Ana ANTES do descarte
SELECT nome, saldo_credito FROM usuario WHERE id_usuario = 1;

-- 1.2. Registrar o descarte de 10kg de Plástico (ID 2)
-- O gatilho (trigger) deve calcular o crédito: 10kg * R$2.00/kg * 0.40 = R$8.00
INSERT INTO descarte (id_usuario, id_reciclavel, peso_kg) VALUES (1, 2, 10.0);

-- 1.3. Consultar o saldo da Ana DEPOIS do descarte para ver se o crédito foi adicionado
SELECT nome, saldo_credito FROM usuario WHERE id_usuario = 1;
-- O saldo dela deve ser 8.00


-- -- ====================================================================
-- -- CENÁRIO 2: Bruno Costa (ID 2) faz uma compra de 5.00 créditos
-- -- ====================================================================

-- 2.1. Consultar o saldo do Bruno ANTES da compra (ele começa com 15.50)
SELECT nome, saldo_credito FROM usuario WHERE id_usuario = 2;

-- 2.2. Registrar a compra
-- O gatilho deve debitar 5.00 do saldo dele
INSERT INTO compras (id_usuario, creditos_usados) VALUES (2, 5.00);

-- 2.3. Consultar o saldo do Bruno DEPOIS da compra
SELECT nome, saldo_credito FROM usuario WHERE id_usuario = 2;
-- O saldo dele deve ser 10.50


-- -- ====================================================================
-- -- Consultas gerais para ver o estado final do banco
-- -- ====================================================================
SELECT 'Estado final dos usuários' AS 'Relatório';
SELECT * FROM usuario;

SELECT 'Histórico de descartes' AS 'Relatório';
SELECT * FROM descarte;

SELECT 'Histórico de compras' AS 'Relatório';
SELECT * FROM compras;
