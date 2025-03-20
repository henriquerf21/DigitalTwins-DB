-- 🔹 Desativar restrições de chave estrangeira temporariamente
SET FOREIGN_KEY_CHECKS = 0;

-- 🔹 Apagar dados das tabelas na ordem correta (remover dados dependentes primeiro)
TRUNCATE TABLE historico_energia;
TRUNCATE TABLE historico_trafego;
TRUNCATE TABLE autocarros;
TRUNCATE TABLE estacoes;
TRUNCATE TABLE vias;

-- 🔹 Reativar restrições de chave estrangeira
SET FOREIGN_KEY_CHECKS = 1;

-- 🔹 Inserção de Vias
INSERT INTO vias (id, nome, sentido, limite_velocidade, fluxo_trafego, evento_trafego, condicao_meteorologica, infraestrutura_associada, tempo_medio_viagem) VALUES
    (1, 'Avenida Central', 'Norte-Sul', 50, 'Congestionado', 'Acidente', 'Chuva', 'Semáforos, passadeiras', 15.5),
    (2, 'Rua da Universidade', 'Leste-Oeste', 30, 'Livre', NULL, 'Sol', 'Cruzamento, lomba', 5.2),
    (3, 'Circular Externa', 'Duplo Sentido', 80, 'Moderado', NULL, 'Nublado', 'Rotundas', 20.8),
    (4, 'Via Rápida Braga', 'Norte-Sul', 100, 'Livre', NULL, 'Sol', 'Saídas rápidas', 10.3);

-- 🔹 Inserção de Estações
INSERT INTO estacoes (id, nome, localizacao, capacidade, tempo_medio_espera, ocupacao, sensor_temperatura, horario_funcionamento, eventos_especiais, atrasos, chegadas_partidas) VALUES
    (1, 'Estação Central', 'Braga Centro', 300, 10, 150, 25.5, '06:00 - 23:00', 'Obras na linha 2', 'Nenhum', 'Autocarros de 10 em 10 min'),
    (2, 'Terminal Norte', 'Universidade do Minho', 200, 5, 100, 23.0, '24h', NULL, 'Atraso médio de 3 min', 'Alta frequência'),
    (3, 'Paragem Avenida', 'Avenida da Liberdade', 80, 7, 50, 22.0, '06:30 - 22:30', NULL, NULL, 'Intervalo médio de 15 min'),
    (4, 'Estação Sul', 'Rua de São Vicente', 150, 12, 90, 24.5, '05:30 - 00:00', NULL, 'Atraso médio de 5 min', 'Autocarros de 20 em 20 min');

-- 🔹 Inserção de Autocarros
INSERT INTO autocarros (id, matricula, ano_fabricacao, tipo_servico, latitude, longitude, velocidade, ocupacao, nivel_energia, status_operacional, distancia_proxima_paragem, consumo_medio_energia, temperatura_interna, temperatura_externa, erros_tecnicos, via_id, estacao_id) VALUES
    (1, '34-AB-99', 2020, 'Regular', 41.55032, -8.42005, 45.0, 40, 75.5, 'Em serviço', 0.8, 2.3, 22.5, 18.0, NULL, 1, 2),
    (2, '12-CD-34', 2019, 'Noturno', 41.54567, -8.42678, 38.5, 25, 60.0, 'Em Manutenção', 1.5, 3.1, 20.0, 17.5, 'Problema no motor', 2, 3),
    (3, '99-ZZ-01', 2022, 'Expresso', 41.55123, -8.42256, 80.0, 50, 90.0, 'Fora de serviço', NULL, 2.8, 23.0, 19.0, 'Sistema elétrico falhou', 3, NULL),
    (4, '78-XY-45', 2018, 'Turístico', 41.54321, -8.41987, 50.0, 30, NULL, 'Em serviço', 2.0, 3.5, 21.0, 16.5, NULL, 4, 1),
    (5, '55-YY-77', 2023, 'Regular', 41.55234, -8.43056, 60.0, 45, 85.0, 'Avariado', NULL, 2.1, 22.0, 17.8, 'Avaria elétrica', 1, NULL);

-- 🔹 Inserção de Histórico de Tráfego
INSERT INTO historico_trafego (autocarro_id, via_id, ocupacao, velocidade, fluxo_trafego, condicao_meteorologica, timestamp) VALUES
    (1, 1, 40, 45.0, 'Congestionado', 'Chuva', NOW()),
    (2, 2, 25, 38.5, 'Livre', 'Sol', NOW()),
    (3, 3, 50, 80.0, 'Moderado', 'Nublado', NOW()),
    (4, 4, 30, 50.0, 'Livre', 'Sol', NOW()),
    (5, 1, 45, 60.0, 'Congestionado', 'Chuva', NOW());

-- 🔹 Inserção de Histórico de Consumo Energético
INSERT INTO historico_energia (autocarro_id, nivel_energia, consumo, timestamp) VALUES
    (1, 75.5, 2.3, NOW()),
    (2, 60.0, 3.1, NOW()),
    (3, 90.0, 2.8, NOW()),
    (4, NULL, 3.5, NOW()),
    (5, 85.0, 2.1, NOW());
