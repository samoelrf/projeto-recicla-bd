-- -- SCRIPT DE CONSTRUÇÃO COMPLETA E LIMPA PARA MYSQL
-- -- Apaga as estruturas antigas e recria tudo do zero.

-- Desativa a verificação de chaves estrangeiras para permitir apagar as tabelas em qualquer ordem
SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS `compras`;
DROP TABLE IF EXISTS `descarte`;
DROP TABLE IF EXISTS `reciclavel`;
DROP TABLE IF EXISTS `usuario`;

-- Reativa a verificação de chaves estrangeiras
SET FOREIGN_KEY_CHECKS=1;

-- -----------------------------------------------------
-- Tabela: usuario
-- -----------------------------------------------------
CREATE TABLE `usuario` (
    `id_usuario` INT AUTO_INCREMENT PRIMARY KEY,
    `nome` VARCHAR(100) NOT NULL,
    `telefone` VARCHAR(20) NOT NULL UNIQUE,
    `saldo_credito` DECIMAL(10,2) NOT NULL DEFAULT 0.00
);

-- -----------------------------------------------------
-- Tabela: reciclavel
-- -----------------------------------------------------
CREATE TABLE `reciclavel` (
    `id_reciclavel` INT AUTO_INCREMENT PRIMARY KEY,
    `material` VARCHAR(50) NOT NULL UNIQUE,
    `classe` VARCHAR(1) NOT NULL,
    `valor_kg` DECIMAL (10,2) NOT NULL
);

-- -----------------------------------------------------
-- Tabela: descarte
-- -----------------------------------------------------
CREATE TABLE `descarte` (
    `id_descarte` INT AUTO_INCREMENT PRIMARY KEY,
    `id_usuario` INT NOT NULL,
    `id_reciclavel` INT NOT NULL,
    `peso_kg` DECIMAL(10,2) NOT NULL,
    `data_do_descarte` DATE NOT NULL DEFAULT (CURDATE()),
    CONSTRAINT `FK_descarte_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario`(`id_usuario`),
    CONSTRAINT `FK_descarte_reciclavel` FOREIGN KEY (`id_reciclavel`) REFERENCES `reciclavel`(`id_reciclavel`)
);

-- -----------------------------------------------------
-- Tabela: compras
-- -----------------------------------------------------
CREATE TABLE `compras` (
    `id_compra` INT AUTO_INCREMENT PRIMARY KEY,
    `id_usuario` INT NOT NULL,
    `creditos_usados` DECIMAL(10,2) NOT NULL,
    `data_da_compra` DATE NOT NULL DEFAULT (CURDATE()),
    CONSTRAINT `FK_compras_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario`(`id_usuario`)
);

-- -----------------------------------------------------
-- Gatilho para adicionar crédito no descarte
-- -----------------------------------------------------
DELIMITER $$
CREATE TRIGGER `trigger_credito_descarte`
AFTER INSERT ON `descarte`
FOR EACH ROW
BEGIN
    DECLARE valor_reciclavel DECIMAL(10, 2);
    SELECT valor_kg INTO valor_reciclavel FROM reciclavel WHERE id_reciclavel = NEW.id_reciclavel;
    UPDATE usuario
    SET saldo_credito = saldo_credito + (NEW.peso_kg * valor_reciclavel * 0.40)
    WHERE id_usuario = NEW.id_usuario;
END$$
DELIMITER ;

-- -----------------------------------------------------
-- Gatilho para subtrair crédito na compra
-- -----------------------------------------------------
DELIMITER $$
CREATE TRIGGER `trigger_debito_compra`
AFTER INSERT ON `compras`
FOR EACH ROW
BEGIN
    UPDATE usuario
    SET saldo_credito = saldo_credito - NEW.creditos_usados
    WHERE id_usuario = NEW.id_usuario;
END$$
DELIMITER ;
