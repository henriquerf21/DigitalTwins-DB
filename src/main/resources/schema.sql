CREATE TABLE IF NOT EXISTS autocarros (
    id IDENTITY PRIMARY KEY,
    matricula VARCHAR(50) NOT NULL,
    ano_fabricacao INT NOT NULL,
    tipo_servico VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS vias (
    id IDENTITY PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    sentido VARCHAR(20),
    limite_velocidade INT
);

CREATE TABLE IF NOT EXISTS estacoes (
    id IDENTITY PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    localizacao VARCHAR(255),
    capacidade INT
);
