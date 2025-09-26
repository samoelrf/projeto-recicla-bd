
-- -- ====================================================================
-- -- ARQUIVO DE ESTRUTURA DO BANCO DE DADOS 'recicla'
-- -- Contém a definição de todas as tabelas e gatilhos.
-- -- Execute este script em um banco de dados limpo para criar toda a estrutura.


-- USE recicla;
-- GO

-- -- -----------------------------------------------------
-- -- Tabela: usuario
-- -- -----------------------------------------------------
-- CREATE TABLE usuario (
--     id_usuario INT IDENTITY(1,1) PRIMARY KEY,
--     nome VARCHAR(100) NOT NULL,
--     telefone VARCHAR(20) NOT NULL UNIQUE,
--     saldo_credito DECIMAL(10,2) NOT NULL DEFAULT 0.00
-- );
-- GO

-- -- -----------------------------------------------------
-- -- Tabela: reciclavel
-- -- -----------------------------------------------------
-- CREATE TABLE reciclavel (
--     id_reciclavel INT IDENTITY(1,1) PRIMARY KEY,
--     material VARCHAR(50) NOT NULL UNIQUE,
--     classe VARCHAR(1) NOT NULL,
--     valor_kg DECIMAL (10,2) NOT NULL
-- );
-- GO

-- -- -----------------------------------------------------
-- -- Tabela: descarte
-- -- -----------------------------------------------------
-- CREATE TABLE descarte (
--     id_descarte INT IDENTITY(1,1) PRIMARY KEY,
--     id_usuario INT NOT NULL,
--     id_reciclavel INT NOT NULL,
--     peso_kg DECIMAL(10,2) NOT NULL,
--     data_do_descarte DATE NOT NULL DEFAULT GETDATE(),
--     CONSTRAINT FK_descarte_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
--     CONSTRAINT FK_descarte_reciclavel FOREIGN KEY (id_reciclavel) REFERENCES reciclavel(id_reciclavel)
-- );
-- GO

-- -- -----------------------------------------------------
-- -- Tabela: compras
-- -- -----------------------------------------------------
-- CREATE TABLE compras (
--     id_compra INT IDENTITY(1,1) PRIMARY KEY,
--     id_usuario INT NOT NULL,
--     creditos_usados DECIMAL(10,2) NOT NULL,
--     data_da_compra DATE NOT NULL DEFAULT GETDATE(),
--     CONSTRAINT FK_compras_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
-- );
-- GO

-- -- ====================================================================
-- -- GATILHOS (TRIGGERS)
-- -- ====================================================================

-- -- -----------------------------------------------------
-- -- Gatilho para adicionar crédito no descarte
-- -- -----------------------------------------------------
-- CREATE TRIGGER trigger_credito_descarte
-- ON descarte
-- AFTER INSERT
-- AS
-- BEGIN
--     SET NOCOUNT ON;
--     UPDATE u
--     SET u.saldo_credito = u.saldo_credito + (i.peso_kg * r.valor_kg * 0.40)
--     FROM usuario AS u
--     INNER JOIN inserted AS i ON u.id_usuario = i.id_usuario
--     INNER JOIN reciclavel AS r ON i.id_reciclavel = r.id_reciclavel;
-- END;
-- GO

-- -- -----------------------------------------------------
-- -- Gatilho para subtrair crédito na compra
-- -- -----------------------------------------------------
-- CREATE TRIGGER trigger_debito_compra
-- ON compras
-- AFTER INSERT
-- AS
-- BEGIN
--     SET NOCOUNT ON;
--     UPDATE u
--     SET u.saldo_credito = u.saldo_credito - i.creditos_usados
--     FROM usuario AS u
--     INNER JOIN inserted AS i ON u.id_usuario = i.id_usuario;
-- END;
-- GO

