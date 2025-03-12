

-- Inserção de Autocarros (Evita duplicação)
INSERT INTO autocarros (matricula, ano_fabricacao, tipo_servico, latitude, longitude, velocidade, ocupacao, nivel_energia, status_operacional)
SELECT * FROM (SELECT '34-AB-56', 2020, 'Regular', 41.55032, -8.42005, 45.0, 40, 75.5, 'Em serviço') AS tmp
WHERE NOT EXISTS (SELECT 1 FROM autocarros WHERE matricula = '34-AB-56');

INSERT INTO autocarros (matricula, ano_fabricacao, tipo_servico, latitude, longitude, velocidade, ocupacao, nivel_energia, status_operacional)
SELECT * FROM (SELECT '12-CD-34', 2019, 'Noturno', 41.54567, -8.42678, 38.5, 25, 60.0, 'Manutenção') AS tmp
WHERE NOT EXISTS (SELECT 1 FROM autocarros WHERE matricula = '12-CD-34');

INSERT INTO autocarros (matricula, ano_fabricacao, tipo_servico, latitude, longitude, velocidade, ocupacao, nivel_energia, status_operacional)
SELECT * FROM (SELECT '99-ZZ-01', 2022, 'Expresso', 41.55123, -8.42256, 80.0, 50, 90.0, 'Fora de serviço') AS tmp
WHERE NOT EXISTS (SELECT 1 FROM autocarros WHERE matricula = '99-ZZ-01');

INSERT INTO autocarros (matricula, ano_fabricacao, tipo_servico, latitude, longitude, velocidade, ocupacao, nivel_energia, status_operacional)
SELECT * FROM (SELECT '78-XY-45', 2018, 'Turístico', 41.54321, -8.41987, 50.0, 30, NULL, 'Em serviço') AS tmp
WHERE NOT EXISTS (SELECT 1 FROM autocarros WHERE matricula = '78-XY-45');

INSERT INTO autocarros (matricula, ano_fabricacao, tipo_servico, latitude, longitude, velocidade, ocupacao, nivel_energia, status_operacional)
SELECT * FROM (SELECT '55-YY-77', 2023, 'Regular', 41.55234, -8.43056, 60.0, 45, 85.0, 'Avariado') AS tmp
WHERE NOT EXISTS (SELECT 1 FROM autocarros WHERE matricula = '55-YY-77');

-- Inserção de Vias (Evita duplicação)
INSERT INTO vias (nome, sentido, limite_velocidade, fluxo_trafego, evento_trafego, condicao_meteorologica)
SELECT * FROM (SELECT 'Avenida Central', 'Norte-Sul', 50, 'Congestionado', 'Acidente', 'Chuva') AS tmp
WHERE NOT EXISTS (SELECT 1 FROM vias WHERE nome = 'Avenida Central');

INSERT INTO vias (nome, sentido, limite_velocidade, fluxo_trafego, evento_trafego, condicao_meteorologica)
SELECT * FROM (SELECT 'Rua da Universidade', 'Leste-Oeste', 30, 'Livre', NULL, 'Sol') AS tmp
WHERE NOT EXISTS (SELECT 1 FROM vias WHERE nome = 'Rua da Universidade');

INSERT INTO vias (nome, sentido, limite_velocidade, fluxo_trafego, evento_trafego, condicao_meteorologica)
SELECT * FROM (SELECT 'Circular Externa', 'Duplo Sentido', 80, 'Moderado', NULL, 'Nublado') AS tmp
WHERE NOT EXISTS (SELECT 1 FROM vias WHERE nome = 'Circular Externa');

INSERT INTO vias (nome, sentido, limite_velocidade, fluxo_trafego, evento_trafego, condicao_meteorologica)
SELECT * FROM (SELECT 'Via Rápida Braga', 'Norte-Sul', 100, 'Livre', NULL, 'Sol') AS tmp
WHERE NOT EXISTS (SELECT 1 FROM vias WHERE nome = 'Via Rápida Braga');

-- Inserção de Estações (Evita duplicação)
INSERT INTO estacoes (nome, localizacao, capacidade, tempo_medio_espera, ocupacao, sensor_temperatura)
SELECT * FROM (SELECT 'Estação Central', 'Braga Centro', 300, 10, 150, 25.5) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM estacoes WHERE nome = 'Estação Central');

INSERT INTO estacoes (nome, localizacao, capacidade, tempo_medio_espera, ocupacao, sensor_temperatura)
SELECT * FROM (SELECT 'Terminal Norte', 'Universidade do Minho', 200, 5, 100, 23.0) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM estacoes WHERE nome = 'Terminal Norte');

INSERT INTO estacoes (nome, localizacao, capacidade, tempo_medio_espera, ocupacao, sensor_temperatura)
SELECT * FROM (SELECT 'Paragem Avenida', 'Avenida da Liberdade', 80, 7, 50, 22.0) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM estacoes WHERE nome = 'Paragem Avenida');

INSERT INTO estacoes (nome, localizacao, capacidade, tempo_medio_espera, ocupacao, sensor_temperatura)
SELECT * FROM (SELECT 'Estação Sul', 'Rua de São Vicente', 150, 12, 90, 24.5) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM estacoes WHERE nome = 'Estação Sul');
