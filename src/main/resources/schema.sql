-- Criar Tabela das Vias (Ruas e Estradas) 
CREATE TABLE IF NOT EXISTS vias (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE, -- Nome da via
    sentido VARCHAR(20) CHECK (sentido IN ('Norte-Sul', 'Leste-Oeste', 'Duplo Sentido')), -- Direção do tráfego
    limite_velocidade INT CHECK (limite_velocidade BETWEEN 30 AND 100), -- Limite de velocidade permitido
    fluxo_trafego VARCHAR(20), -- Estado do tráfego: "Congestionado", "Livre", etc.
    evento_trafego VARCHAR(50), -- Registo de eventos: "Acidente", "Obras", etc.
    condicao_meteorologica VARCHAR(30), -- Clima atual da via
    infraestrutura_associada VARCHAR(255), -- Semáforos, passadeiras, cruzamentos
    tempo_medio_viagem DECIMAL(6,2) -- Tempo médio de viagem na via em minutos
);

-- Criar Tabela das Estações (Paragens e Terminais)
CREATE TABLE IF NOT EXISTS estacoes (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE, -- Nome da estação ou terminal
    localizacao VARCHAR(255), -- Localização descritiva
    capacidade INT CHECK (capacidade BETWEEN 50 AND 500), -- Capacidade da estação
    tempo_medio_espera INT CHECK (tempo_medio_espera BETWEEN 5 AND 60), -- Tempo médio de espera em minutos
    ocupacao INT CHECK (ocupacao BETWEEN 0 AND 500), -- Passageiros na estação
    sensor_temperatura DECIMAL(5,2), -- Temperatura ambiente da estação
    horario_funcionamento VARCHAR(50), -- Horário de funcionamento
    eventos_especiais VARCHAR(255), -- Eventos como obras ou interrupções
    atrasos VARCHAR(255), -- Informações sobre atrasos das viaturas
    chegadas_partidas TEXT -- Lista de chegadas e partidas de autocarros
);

-- Criar Tabela de Autocarros (Viaturas) 
CREATE TABLE IF NOT EXISTS autocarros (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    matricula VARCHAR(50) NOT NULL UNIQUE, -- Matrícula única do autocarro
    ano_fabricacao INT NOT NULL CHECK (ano_fabricacao BETWEEN 1990 AND 2026), -- Ano de fabrico permitido
    tipo_servico VARCHAR(50) NOT NULL, -- Tipos: Noturno, Regular, Expresso, Turístico, etc.
    latitude DECIMAL(9,6), -- Coordenada latitude
    longitude DECIMAL(9,6), -- Coordenada longitude
    velocidade DECIMAL(5,2) CHECK (velocidade BETWEEN 0 AND 100), -- Velocidade do autocarro
    ocupacao INT CHECK (ocupacao BETWEEN 0 AND 120), -- Passageiros a bordo
    nivel_energia DECIMAL(5,2) CHECK (nivel_energia BETWEEN 0 AND 100 OR nivel_energia IS NULL), -- Bateria ou combustível
    status_operacional VARCHAR(20) CHECK (status_operacional IN ('Em serviço', 'Fora de serviço', 'Em Manutenção', 'Avariado')), -- Estado do autocarro
    distancia_proxima_paragem DECIMAL(6,2), -- Distância até à próxima paragem em km
    consumo_medio_energia DECIMAL(5,2), -- Consumo médio do autocarro (litros/km ou kWh/km)
    temperatura_interna DECIMAL(4,2), -- Temperatura dentro do autocarro
    temperatura_externa DECIMAL(4,2), -- Temperatura ambiente do lado de fora
    erros_tecnicos TEXT, -- Lista de erros mecânicos do autocarro
    via_id BIGINT, -- Chave estrangeira para a via onde o autocarro está
    estacao_id BIGINT, -- Chave estrangeira para a estação atual
    FOREIGN KEY (via_id) REFERENCES vias(id),
    FOREIGN KEY (estacao_id) REFERENCES estacoes(id)
);

-- Criar Tabela de Histórico de Tráfego
CREATE TABLE IF NOT EXISTS historico_trafego (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    autocarro_id BIGINT NOT NULL, -- Autocarro que gerou o registo
    via_id BIGINT NOT NULL, -- Via onde o tráfego foi registado
    ocupacao INT CHECK (ocupacao BETWEEN 0 AND 120), -- Passageiros no autocarro
    velocidade DECIMAL(5,2) CHECK (velocidade BETWEEN 0 AND 100), -- Velocidade do autocarro no momento
    fluxo_trafego VARCHAR(20), -- Estado do tráfego
    condicao_meteorologica VARCHAR(30), -- Condição meteorológica
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Hora da medição
    FOREIGN KEY (autocarro_id) REFERENCES autocarros(id),
    FOREIGN KEY (via_id) REFERENCES vias(id)
);

-- Criar Tabela de Histórico de Consumo Energético
CREATE TABLE IF NOT EXISTS historico_energia (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    autocarro_id BIGINT NOT NULL, -- Autocarro monitorizado
    nivel_energia DECIMAL(5,2) CHECK (nivel_energia BETWEEN 0 AND 100), -- Percentagem da bateria/combustível
    consumo DECIMAL(5,2), -- Consumo registado no momento (litros ou kWh)
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Hora do registo
    FOREIGN KEY (autocarro_id) REFERENCES autocarros(id)
);




/*
=================================================================
|                   EXPLICAÇÃO DOS VALORES                      |
=================================================================


 TABELA: autocarros (Viaturas)
---------------------------------
- **id BIGINT AUTO_INCREMENT PRIMARY KEY** → Identificador único de cada autocarro.
- **matricula VARCHAR(50) UNIQUE** → Garante que não existam duas viaturas com a mesma matrícula.
- **ano_fabricacao INT CHECK (1990-2026)** → Apenas permite autocarros fabricados entre 1990 e 2026.
- **tipo_servico VARCHAR(50)** → Indica o tipo de serviço do autocarro (Noturno, Regular, Expresso, Turístico, etc.).
- **latitude DECIMAL(9,6) / longitude DECIMAL(9,6)** → Coordenadas da localização do autocarro.
- **velocidade DECIMAL(5,2) CHECK (0-100)** → Máximo de 100 km/h, respeitando os limites legais para autocarros em Portugal.
- **ocupacao INT CHECK (0-120)** → Limite de 120 passageiros, compatível com autocarros articulados.
- **nivel_energia DECIMAL(5,2) CHECK (0-100) NULL** → Percentagem da bateria (0-100%) ou NULL para autocarros a diesel/gás.
- **status_operacional CHECK ('Em serviço', 'Fora de serviço', 'Em Manutenção', 'Avariado')** → Define o estado do autocarro.
- **distancia_proxima_paragem DECIMAL(6,2)** → Distância até à próxima paragem (em km).
- **consumo_medio_energia DECIMAL(5,2)** → Consumo médio do autocarro (litros/km ou kWh/km).
- **temperatura_interna DECIMAL(4,2)** → Temperatura dentro do autocarro.
- **temperatura_externa DECIMAL(4,2)** → Temperatura ambiente do lado de fora.
- **erros_tecnicos TEXT** → Lista de erros mecânicos ou elétricos do autocarro.
- **via_id BIGINT** → Chave estrangeira para a via onde o autocarro está.
- **estacao_id BIGINT** → Chave estrangeira para a estação onde o autocarro se encontra.

 TABELA: vias (Ruas e Estradas)
----------------------------------
- **id BIGINT AUTO_INCREMENT PRIMARY KEY** → Identificador único da via.
- **nome VARCHAR(100) UNIQUE** → Evita nomes duplicados de vias.
- **sentido CHECK ('Norte-Sul', 'Leste-Oeste', 'Duplo Sentido')** → Direções válidas para a organização do trânsito.
- **limite_velocidade INT CHECK (30-100)** → De acordo com os limites legais para vias urbanas e estradas rápidas.
- **fluxo_trafego VARCHAR(20)** → Identifica o estado do tráfego ("Congestionado", "Livre", etc.).
- **evento_trafego VARCHAR(50)** → Guarda incidentes nas vias ("Acidente", "Obras", etc.).
- **condicao_meteorologica VARCHAR(30)** → Regista as condições meteorológicas ("Chuva", "Sol", etc.).
- **infraestrutura_associada VARCHAR(255)** → Regista infraestruturas relevantes (semáforos, passadeiras, cruzamentos, etc.).
- **tempo_medio_viagem DECIMAL(6,2)** → Tempo médio de viagem pela via (em minutos).

 TABELA: estacoes (Paragens e Terminais)
-------------------------------------------
- **id BIGINT AUTO_INCREMENT PRIMARY KEY** → Identificador único da estação.
- **nome VARCHAR(100) UNIQUE** → Evita nomes repetidos de estações.
- **localizacao VARCHAR(255)** → Localização descritiva da estação.
- **capacidade INT CHECK (50-500)** → Garante que as estações acomodam entre 50 e 500 passageiros.
- **tempo_medio_espera INT CHECK (5-60)** → Tempo médio de espera realista, entre 5 e 60 minutos.
- **ocupacao INT CHECK (0-500)** → Número de passageiros na estação (até 500).
- **sensor_temperatura DECIMAL(5,2)** → Guarda a temperatura ambiente da estação.
- **horario_funcionamento VARCHAR(50)** → Horário de funcionamento da estação.
- **eventos_especiais VARCHAR(255)** → Informação sobre eventos como obras ou interrupções.
- **atrasos VARCHAR(255)** → Informações sobre atrasos das viaturas.
- **chegadas_partidas TEXT** → Registo das chegadas e partidas de autocarros.

 TABELA: historico_trafego (Registos de Tráfego)
------------------------------------------------
- **id BIGINT AUTO_INCREMENT PRIMARY KEY** → Identificador único do registo.
- **autocarro_id BIGINT** → Chave estrangeira para o autocarro que gerou o registo.
- **via_id BIGINT** → Chave estrangeira para a via onde o tráfego foi registado.
- **ocupacao INT CHECK (0-120)** → Número de passageiros no autocarro no momento do registo.
- **velocidade DECIMAL(5,2) CHECK (0-100)** → Velocidade do autocarro no momento do registo.
- **fluxo_trafego VARCHAR(20)** → Estado do tráfego no momento do registo.
- **condicao_meteorologica VARCHAR(30)** → Condição meteorológica no momento do registo.
- **timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP** → Data e hora do registo de tráfego.

 TABELA: historico_energia (Registos de Consumo Energético)
-----------------------------------------------------------
- **id BIGINT AUTO_INCREMENT PRIMARY KEY** → Identificador único do registo.
- **autocarro_id BIGINT** → Chave estrangeira para o autocarro monitorizado.
- **nivel_energia DECIMAL(5,2) CHECK (0-100)** → Percentagem da bateria/combustível no momento do registo.
- **consumo DECIMAL(5,2)** → Consumo registado no momento (litros ou kWh).
- **timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP** → Data e hora do registo de consumo.

=================================================================
|   Estes limites foram definidos com base nas normas dos TUB   |
|   (Transportes Urbanos de Braga) e nas regras do trânsito PT. |
=================================================================
*/
