-- Inserindo Autocarros
INSERT INTO autocarros (matricula, ano_fabricacao, tipo_servico, latitude, longitude, velocidade, ocupacao, nivel_energia, status_operacional) VALUES
('34-AB-56', 2020, 'Regular', 41.55032, -8.42005, 50.0, 20, 80.5, 'Em serviço'),
('12-CD-34', 2019, 'Noturno', 41.54567, -8.42678, 30.5, 15, 60.0, 'Manutenção');

-- Inserindo Vias
INSERT INTO vias (nome, sentido, limite_velocidade, fluxo_trafego, evento_trafego, condicao_meteorologica) VALUES
('Avenida Central', 'Norte-Sul', 50, 'Congestionado', 'Acidente', 'Chuva'),
('Rua da Universidade', 'Leste-Oeste', 30, 'Livre', NULL, 'Sol');

-- Inserindo Estações
INSERT INTO estacoes (nome, localizacao, capacidade, tempo_medio_espera, ocupacao, sensor_temperatura) VALUES
('Estação Central', 'Braga Centro', 100, 10, 60, 25.5),
('Terminal Norte', 'Universidade do Minho', 200, 5, 120, 23.0);