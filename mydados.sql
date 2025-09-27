-- -- SCRIPT DE INSERÇÃO DE DADOS INICIAIS PARA MYSQL

-- Define o banco de dados a ser usado
USE recicla;

-- -----------------------------------------------------
-- Inserindo tipos de recicláveis
-- -----------------------------------------------------
INSERT INTO `reciclavel` (`material`, `classe`, `valor_kg`) VALUES
('Papel', 'A', 1.50),
('Plástico', 'B', 2.00),
('Vidro', 'C', 0.50),
('Metal', 'D', 4.00),
('Orgânico', 'E', 0.20);

-- -----------------------------------------------------
-- Inserindo usuários de exemplo
-- -----------------------------------------------------
INSERT INTO `usuario` (`nome`, `telefone`, `saldo_credito`) VALUES
('Ana Silva', '(11) 98765-4321', 0.00),
('Bruno Costa', '(21) 91234-5678', 15.50),
('Carla Dias', '(31) 95555-8888', 0.00);

-- -----------------------------------------------------
-- Verificando se os dados foram inseridos
-- -----------------------------------------------------
SELECT * FROM `reciclavel`;
SELECT * FROM `usuario`;
