-- schema criado
CREATE SCHEMA DESAFIO;

-- Primeira tabela: Tabela "clientes"
CREATE TABLE DESAFIO.CLIENTES (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    email VARCHAR(50),
    cidade VARCHAR(30),
    telefone VARCHAR(15) NOT NULL
);

-- Segunda Tabela: tabela "carros"
CREATE TABLE DESAFIO.CARROS (
    id_carro INT PRIMARY KEY,
    id_cliente INT,
    modelo VARCHAR(50),
    ano INT,
    preco DECIMAL(10,2), -- 10 digitos no total, 2 depois da virgula (bom para preços)
    FOREIGN KEY (id_cliente) REFERENCES DESAFIO.CLIENTES(id_cliente)
);

-- Colunas + linhas (Clientes)
INSERT INTO DESAFIO.CLIENTES (id_cliente, nome, email, cidade, telefone) VALUES
(1, 'Marcel', 'marcel@email.com', 'João Pessoa', '81999999999'),
(2, 'Ana', 'ana@email.com', 'Campina Grande', '81988888888'),
(3, 'Carlos', 'carlos@email.com', 'João Pessoa', '81977777777'),
(4, 'Fernanda', 'fernanda@email.com', 'Recife', '81966666666'),
(5, 'Lucas', 'lucas@email.com', 'Natal', '81955555555'),
(6, 'Beatriz', 'beatriz@email.com', 'João Pessoa', '81944444444'),
(7, 'Rafael', 'rafael@email.com', 'Campina Grande', '81933333333'),
(8, 'Juliana', 'juliana@email.com', 'Recife', '81922222222'),
(9, 'Gabriel', 'gabriel@email.com', 'Natal', '81911111111'),
(10, 'Camila', 'camila@email.com', 'João Pessoa', '81900000000');

-- -- Colunas + linhas (Carros) 
INSERT INTO DESAFIO.CARROS (id_carro, id_cliente, modelo, ano, preco) VALUES
(1, 1, 'Honda Civic', 2020, 95000.00),
(2, 2, 'Kia Cerato', 2019, 90000.00),
(3, 3, 'Mitsubishi Lancer', 2021, 70000.00),
(4, 1, 'Chevrolet Cruze', 2022, 85000.00),
(5, 4, 'Toyota Corolla', 2018, 90000.00),
(6, 5, 'Mitsubishi ASX', 2020, 120000.00),
(7, 6, 'Suzuki Jimny', 2021, 130000.00),
(8, 7, 'Nissan Versa', 2019, 57000.00),
(9, 8, 'Nissan Sentra', 2022, 95000.00),
(10, 9, 'Honda Civic', 2021, 98000.00);

-- Comando DML (UPDATE)
-- Atualização de preços para carros com anos inferiores a 2021
SET SQL_SAFE_UPDATES = 0; -- foi preciso fazer essa alteração pois estava dando o seguinte erro "Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect."
UPDATE DESAFIO.CARROS
SET preco = preco * 1.05
WHERE ano < 2021;

-- Comando DQL (SELECT)
-- Listar os carros
SELECT * FROM DESAFIO.CARROS;

-- Funções agregadas
-- 1. Total de carros
SELECT COUNT(*) AS total_carros FROM DESAFIO.CARROS;

-- 2. Soma de todos os preços dos carros
SELECT SUM(preco) AS soma_total_preco FROM DESAFIO.CARROS;

-- 3. Maior preço de carro junto com ID dele
SELECT id_carro, preco AS maior_valor_gasto
FROM DESAFIO.CARROS
WHERE preco = (SELECT MAX(preco) FROM DESAFIO.CARROS);

-- Agrupamento (GROUP BY)
-- 1. Quantidade de carros por cliente
SELECT id_cliente, COUNT(*) AS total_carros
FROM DESAFIO.CARROS
GROUP BY id_cliente;

-- 2. Valor total gasto por cliente
SELECT id_cliente, SUM(preco) AS total_gasto
FROM DESAFIO.CARROS
GROUP BY id_cliente;

-- JOIN
-- Listar carros também com o nome dos propietários dos veículos (clientes)
SELECT DESAFIO.CARROS.id_carro,
       DESAFIO.CLIENTES.nome,
       DESAFIO.CARROS.modelo,
       DESAFIO.CARROS.ano,
       DESAFIO.CARROS.preco
FROM DESAFIO.CARROS
JOIN DESAFIO.CLIENTES
ON DESAFIO.CARROS.id_cliente = DESAFIO.CLIENTES.id_cliente;
