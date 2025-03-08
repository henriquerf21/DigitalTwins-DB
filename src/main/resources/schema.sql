-- Tabela de Autocarros (Viaturas)
CREATE TABLE IF NOT EXISTS autocarros (
    id IDENTITY PRIMARY KEY,
    matricula VARCHAR(50) NOT NULL,
    ano_fabricacao INT NOT NULL,
    tipo_servico VARCHAR(50) NOT NULL, -- Noturno, Regular, etc.
    latitude DECIMAL(9,6),  -- Coordenadas geográficas
    longitude DECIMAL(9,6),
    velocidade DECIMAL(5,2), -- Velocidade instantânea
    ocupacao INT,            -- Passageiros a bordo
    nivel_energia DECIMAL(5,2), -- Percentagem de bateria/combustível
    status_operacional VARCHAR(20) -- Exemplo: "Em serviço", "Manutenção"
);

-- Tabela das Vias
CREATE TABLE IF NOT EXISTS vias (
    id IDENTITY PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    sentido VARCHAR(20),
    limite_velocidade INT,
    fluxo_trafego VARCHAR(20), -- Exemplo: "Congestionado", "Livre"
    evento_trafego VARCHAR(50), -- Exemplo: "Acidente", "Obras"
    condicao_meteorologica VARCHAR(30) -- Exemplo: "Chuva", "Sol"
);

-- Tabela das Estações
CREATE TABLE IF NOT EXISTS estacoes (
    id IDENTITY PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    localizacao VARCHAR(255),
    capacidade INT,
    tempo_medio_espera INT, -- Em minutos
    ocupacao INT, -- Número de pessoas na estação
    sensor_temperatura DECIMAL(5,2) -- Temperatura ambiente
);