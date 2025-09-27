# Projeto Recicla+ (Versão MySQL)

Este projeto é um sistema de banco de dados para gerenciar um ecoponto, permitindo que usuários ganhem e gastem créditos de reciclagem. O sistema foi desenvolvido utilizando **MySQL**.

## Estrutura dos Arquivos

A pasta contém os seguintes arquivos SQL, cada um com uma função específica:

*   **`Estrutura_MySQL.sql`**
    *   **Função:** Contém a estrutura completa do banco de dados (tabelas e gatilhos). Serve como documentação e referência da arquitetura.

*   **`myinstalador.sql`** 
    *   **Função:** Script de "reset de fábrica". Apaga todas as tabelas e dados e recria a estrutura do zero.
    *   **Quando usar:** Execute este arquivo para criar o banco de dados em uma máquina nova ou se o seu banco atual estiver corrompido. **Atenção: todos os dados serão perdidos.**

*   **`Dados_MySQL.sql`**
    *   **Função:** Contém os comandos `INSERT` para popular o banco com dados iniciais (usuários, tipos de recicláveis, etc.).
    *   **Quando usar:** Execute após o `myinstalador.sql` para ter um ambiente de desenvolvimento pronto para uso.

*   **`Testes_MySQL.sql`**
    *   **Função:** Um "Ambiente de testes" com exemplos de operações do dia a dia (registrar um descarte, fazer uma compra, consultar saldos).
    *   **Quando usar:** Use este arquivo para testar as funcionalidades e entender o fluxo do sistema.

## Como Instalar o Banco de Dados do Zero

1.  Instale o **MySQL Server** e o **MySQL Workbench**.
2.  No MySQL Workbench, conecte-se ao seu servidor de banco de dados.
3.  Execute o comando `CREATE DATABASE recicla;` para criar um banco de dados vazio.
4.  Abra e execute o conteúdo do arquivo `myinstalador.sql` (ou o nome que você escolheu).
5.  (Recomendado) Abra e execute o conteúdo do arquivo `Dados_MySQL.sql` para popular o banco com dados de exemplo.
6.  (Opcional) Execute o `Testes_MySQL.sql` para verificar se tudo está funcionando.

---
*Desenvolvido por, Samoel R.Frauzino, Setembro, 2025.*
