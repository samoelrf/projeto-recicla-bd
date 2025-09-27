
-- -- SCRIPT DE RECONSTRUÇÃO COMPLETA E LIMPA
-- -- Apaga as estruturas antigas e recria tudo do zero, da forma correta.

-- USE recicla;
-- GO

-- -- -----------------------------------------------------
-- -- PASSO 1: APAGAR ESTRUTURAS ANTIGAS (ORDEM INVERSA)
-- -- -----------------------------------------------------
-- PRINT '--- PASSO 1: Apagando estruturas antigas... ---';
-- IF OBJECT_ID('trigger_debito_compra', 'TR') IS NOT NULL DROP TRIGGER trigger_debito_compra;
-- IF OBJECT_ID('trigger_credito_descarte', 'TR') IS NOT NULL DROP TRIGGER trigger_credito_descarte;
-- IF OBJECT_ID('trigger_saldo_correto', 'TR') IS NOT NULL DROP TRIGGER trigger_saldo_correto; -- Adicionado para garantir
-- IF OBJECT_ID('compras', 'U') IS NOT NULL DROP TABLE compras;
-- IF OBJECT_ID('descarte', 'U') IS NOT NULL DROP TABLE descarte;
-- IF OBJECT_ID('reciclavel', 'U') IS NOT NULL DROP TABLE reciclavel;
-- IF OBJECT_ID('usuario', 'U') IS NOT NULL DROP TABLE usuario;
-- GO

-- -- -----------------------------------------------------
-- -- PASSO 2: RECRIAR TABELAS COM A ESTRUTURA CORRETA
-- -- (Copiado do nosso novo Recicla.sql/schema.sql)
-- -- -----------------------------------------------------
-- PRINT '--- PASSO 2: Recriando tabelas... ---';
-- CREATE TABLE usuario ( id_usuario INT IDENTITY(1,1) PRIMARY KEY, nome VARCHAR(100) NOT NULL, telefone VARCHAR(20) NOT NULL UNIQUE, saldo_credito DECIMAL(10,2) NOT NULL DEFAULT 0.00 );
-- CREATE TABLE reciclavel ( id_reciclavel INT IDENTITY(1,1) PRIMARY KEY, material VARCHAR(50) NOT NULL UNIQUE, classe VARCHAR(1) NOT NULL, valor_kg DECIMAL (10,2) NOT NULL );
-- CREATE TABLE descarte ( id_descarte INT IDENTITY(1,1) PRIMARY KEY, id_usuario INT NOT NULL, id_reciclavel INT NOT NULL, peso_kg DECIMAL(10,2) NOT NULL, data_do_descarte DATE NOT NULL DEFAULT GETDATE(), CONSTRAINT FK_descarte_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario), CONSTRAINT FK_descarte_reciclavel FOREIGN KEY (id_reciclavel) REFERENCES reciclavel(id_reciclavel) );
-- CREATE TABLE compras ( id_compra INT IDENTITY(1,1) PRIMARY KEY, id_usuario INT NOT NULL, creditos_usados DECIMAL(10,2) NOT NULL, data_da_compra DATE NOT NULL DEFAULT GETDATE(), CONSTRAINT FK_compras_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) );
-- GO

-- -- -----------------------------------------------------
-- -- PASSO 3: RECRIAR GATILHOS
-- -- -----------------------------------------------------
-- PRINT '--- PASSO 3: Recriando gatilhos... ---';
-- CREATE TRIGGER trigger_credito_descarte ON descarte AFTER INSERT AS BEGIN SET NOCOUNT ON; UPDATE u SET u.saldo_credito = u.saldo_credito + (i.peso_kg * r.valor_kg * 0.40) FROM usuario AS u INNER JOIN inserted AS i ON u.id_usuario = i.id_usuario INNER JOIN reciclavel AS r ON i.id_reciclavel = r.id_reciclavel; END;
-- GO
-- CREATE TRIGGER trigger_debito_compra ON compras AFTER INSERT AS BEGIN SET NOCOUNT ON; UPDATE u SET u.saldo_credito = u.saldo_credito - i.creditos_usados FROM usuario AS u INNER JOIN inserted AS i ON u.id_usuario = i.id_usuario; END;
-- GO

-- PRINT '*** ESTRUTURA DO BANCO DE DADOS RECONSTRUÍDA COM SUCESSO! ***';
-- GO

