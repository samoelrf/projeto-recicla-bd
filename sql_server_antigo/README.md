# Projeto Recicla+

Este projeto é um sistema de banco de dados para gerenciar um ecoponto, permitindo que usuários ganhem e gastem créditos de reciclagem.

## Estrutura dos Arquivos

A pasta contém os seguintes arquivos SQL, cada um com uma função específica:

*   **`Estrutura.sql`**
    *   **Função:** Contém a estrutura completa do banco de dados (tabelas e gatilhos).
    *   **Quando usar:** Não execute este arquivo diretamente. Ele serve como documentação e referência da arquitetura.

*   **`Instalador.sql`**
    *   **Função:** Script de "reset de fábrica". Apaga todas as tabelas e dados e recria a estrutura do zero.
    *   **Quando usar:** Execute este arquivo **apenas** se precisar recriar o banco de dados em uma máquina nova ou se o seu banco atual estiver corrompido. **Atenção: todos os dados serão perdidos.**

*   **`Dados.sql`**
    *   **Função:** Contém os comandos `INSERT` para popular o banco com dados iniciais (usuários, tipos de recicláveis, etc.).
    *   **Quando usar:** Execute após o `Instalador.sql` para ter um ambiente de desenvolvimento pronto para uso.

*   **`Testes.sql`**
    *   **Função:** Um "playground" com exemplos de operações do dia a dia (registrar um descarte, fazer uma compra, consultar saldos).
    *   **Quando usar:** Use este arquivo para testar as funcionalidades e entender o fluxo do sistema.

## Como Instalar o Banco de Dados do Zero

1.  Crie um banco de dados vazio chamado `recicla` no seu SQL Server.
2.  Execute o conteúdo do arquivo `Instalador.sql`.
3.  (Opcional) Execute o conteúdo do arquivo `Dados.sql` para popular o banco com dados de exemplo.

---
*Desenvolvido por, Samoel R.Frauzino, Setembro, 2025.*
