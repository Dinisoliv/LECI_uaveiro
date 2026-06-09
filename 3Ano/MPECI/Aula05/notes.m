%% =========================================================================
%  MPECI_notas.m
%  Métodos Probabilísticos para Engenharia de Computadores e Informática
%  Simulação de Eventos Discretos — Notas Detalhadas
%  Ano 2025/2026
% =========================================================================
%
% ÍNDICE:
%   1. ARQUITECTURA DE UM SIMULADOR DE EVENTOS DISCRETOS
%   2. GERAÇÃO DE VALORES ALEATÓRIOS
%      2a. Variáveis Discretas
%      2b. Variáveis Contínuas — Método da CDF Inversa
%      2c. Variáveis Contínuas — Método da Rejeição
%   3. MODELO 1 — SERVIDOR DE VIDEO-STREAMING (M/M/m/m)
%   4. MODELO 2 — LIGAÇÃO DE DADOS ISP (M/M/1/F)
%   5. ANÁLISE DE RESULTADOS — INTERVALOS DE CONFIANÇA
%   6. FUNÇÕES MATLAB PRONTAS A USAR
%      6a. VideoStreamingSimulator
%      6b. LinkSimulator (exponencial)
%      6c. LinkSimulatorDiscrete (distribuição discreta)
%      6d. LinkSimulatorDP (com PD)
%   7. MODELOS TEÓRICOS DE FILAS DE ESPERA
%      7a. M/M/m/m — Erlang-B
%      7b. M/M/1/m — Fila finita
%   8. ERROS COMUNS E COMO EVITÁ-LOS
%
% =========================================================================



% =========================================================================
% 1. ARQUITECTURA DE UM SIMULADOR DE EVENTOS DISCRETOS
% =========================================================================
%
% QUANDO USAR:
%   - Sistema cujo estado só muda em instantes discretos (eventos)
%   - Queremos estimar parâmetros de desempenho (bloqueio, atraso, etc.)
%   - Distribuições não-analíticas ou sistema demasiado complexo para
%     solução fechada
%
% COMPONENTES OBRIGATÓRIOS:
%
%   Clock        — relógio de simulação (tempo actual)
%   EventList    — lista de eventos futuros, ordenada por tempo
%                  formato mínimo: [tipo_evento, instante_evento]
%                  pode ter colunas extra (ex: instante_chegada do pacote)
%   STATE        — variável(is) de estado do sistema
%   Contadores   — acumulam informação estatística ao longo da simulação
%
% FLUXO PRINCIPAL (sempre igual):
%
%   (1) Inicializar Clock, STATE, contadores, EventList com 1º evento
%   (2) Ordenar EventList por tempo (sortrows)
%   (3) Retirar 1º evento; avançar Clock
%   (4) Executar acções do evento:
%        - actualizar STATE
%        - actualizar contadores
%        - gerar novos eventos futuros e adicionar a EventList
%   (5) Verificar critério de paragem; se não terminou → voltar a (2)
%   (6) Calcular parâmetros de desempenho a partir dos contadores
%
% CRITÉRIOS DE PARAGEM TÍPICOS:
%   - Fim da transmissão do N-ésimo filme/pacote (TRANSMITTED >= N)
%   - Tempo de simulação >= T_max
%
% NOTA SOBRE WARM-UP:
%   - Sistemas estocásticos têm transiente inicial antes do regime estacionário
%   - Se tempo simulado >> tempo de warm-up: inicializar contadores no início
%   - Caso contrário: só inicializar contadores após o warm-up
%   - Ver gráficos de evolução (Ex. 1) para estimar visualmente o warm-up



% =========================================================================
% 2. GERAÇÃO DE VALORES ALEATÓRIOS
% =========================================================================

% --- 2a. VARIÁVEIS DISCRETAS ---
%
% Dados:
%   x = [x1, x2, ..., xn]   — valores possíveis
%   f = [f1, f2, ..., fn]   — probabilidades (sum(f) == 1)
%
% Método:
%   f_cum = [0, cumsum(f)]   — CDF acumulada com 0 inicial
%   valor = x(sum(rand() > f_cum))
%
% Porquê funciona:
%   rand() cai no intervalo [f_cum(i), f_cum(i+1)] com prob. f(i)
%   sum(rand() > f_cum) conta quantos limiares foram ultrapassados
%   esse count é exactamente o índice do intervalo onde rand() caiu
%
% Exemplo (Bernoulli p=3/4):
%   x = [0, 1];  f = [0.25, 0.75];
%   f_cum = [0, 0.25, 1.0];
%   Se rand()=0.6 → sum(0.6 > [0, 0.25, 1.0]) = sum([1,1,0]) = 2 → x(2)=1
%
% Exemplo MATLAB (Ex. 3 / Ex. 7):
%   x_sizes = 64:1500;
%   f_sizes(x_sizes==64)   = 0.29606;
%   f_sizes(x_sizes==110)  = 0.16417;
%   f_sizes(x_sizes==1500) = 0.19601;
%   % resto com probabilidade igual
%   f_cum = [0, cumsum(f_sizes)];
%   pkt = x_sizes(sum(rand() > f_cum));   % gera 1 valor
%
% Média de variável discreta:
%   media = sum(x .* f);


% --- 2b. VARIÁVEIS CONTÍNUAS — Método da CDF Inversa ---
%
% Princípio: se U ~ Uniform(0,1), então X = F^{-1}(U) tem CDF F(x)
%
% Distribuição Exponencial com taxa λ (média = 1/λ):
%   F(x)     = 1 - exp(-λx),  x >= 0
%   F^{-1}(U) = -1/λ * ln(U)
%   MATLAB: exprnd(1/lambda)   [argumento é a MÉDIA, não a taxa!]
%
%   ATENÇÃO: exprnd recebe a média (1/λ), NÃO a taxa (λ)
%   ERRADO:  exprnd(lambda)
%   CERTO:   exprnd(1/lambda)
%
% Distribuição Uniforme entre a e b:
%   X = (b-a)*rand() + a
%   MATLAB: a + (b-a)*rand()
%
% Distribuição Normal (Box-Muller — para referência):
%   MATLAB: randn() para N(0,1); média + std*randn() para N(média,std²)


% --- 2c. VARIÁVEIS CONTÍNUAS — Método da Rejeição ---
%
% Quando F^{-1} não tem forma fechada.
% Dados: f(x) definida em [a,b], com máximo c = max(f(x))
%
% Algoritmo:
%   (1) Gerar X ~ Uniform(a, b)
%   (2) Gerar Y ~ Uniform(0, c)
%   (3) Se Y <= f(X): aceitar X; senão: voltar a (1)
%
% Eficiência = área sob f(x) / área do rectângulo = 1 / (c*(b-a))
% Quanto maior o rectângulo relativo à curva, mais rejeições haverá.



% =========================================================================
% 3. MODELO 1 — SERVIDOR DE VIDEO-STREAMING (M/M/m/m)
% =========================================================================
%
% QUANDO USAR (keywords):
%   "servidor", "filmes", "transmissão simultânea", "capacidade máxima M",
%   "pedidos Poisson", "duração exponencial", "bloqueio", "débito"
%
% SISTEMA:
%   Chegadas: processo de Poisson com taxa λ (pedidos/minuto)
%   Serviço:  duração exponencial com média 1/μ (minutos)
%   Capacidade: M filmes em simultâneo (sem fila de espera!)
%   → Um pedido que chega quando STATE==M é BLOQUEADO (perdido)
%
% VARIÁVEIS DE ESTADO:
%   STATE       — número de filmes em transmissão (0 a M)
%
% EVENTOS:
%   ARRIVAL   (0) — pedido de filme
%   DEPARTURE (1) — fim de transmissão de filme
%
% CONTADORES ESTATÍSTICOS:
%   N_ARRIVALS  — total de pedidos chegados
%   BLOCKED     — pedidos bloqueados (STATE==M na chegada)
%   LOAD        — integral do débito: soma de B*STATE*Δt
%                 actualizado ANTES de processar cada evento:
%                 LOAD = LOAD + B*STATE*(Clock - PreviousClock)
%
% PARÂMETROS DE DESEMPENHO:
%   PB (%) = 100 * BLOCKED / N_ARRIVALS
%   DB (Mbps) = LOAD / Clock   [Clock = tempo total simulado]
%
% CRITÉRIO DE PARAGEM:
%   TRANSMITTED >= N   (N = número de filmes transmitidos)
%   variável auxiliar TRANSMITTED incrementada em cada DEPARTURE
%
% ACÇÕES POR EVENTO:
%
%   ARRIVAL:
%     → agendar próximo ARRIVAL: t = Clock + exprnd(1/lambda)
%     → N_ARRIVALS++
%     → se STATE < M:  STATE++, agendar DEPARTURE em Clock+exprnd(invmiu)
%     → senão:         BLOCKED++
%
%   DEPARTURE:
%     → STATE--
%     → TRANSMITTED++
%
% EXEMPLO (Ex. 2): λ=2, invmiu=90min, B=2Mbps, M=200, N=1e4
%   PB ≈ 0.95-1.15%,  DB ≈ 349-351 Mbps
%
% CONCLUSÕES TÍPICAS:
%   - Com duração exponencial de média correcta ≈ distribuição discreta real
%   - IC mais estreito com mais simulações ou N maior
%   - Warm-up visível nos primeiros eventos (STATE cresce de 0 até regime)
%   - Com λ=3 o warm-up é mais rápido (mais chegadas → STATE sobe mais depressa)



% =========================================================================
% 4. MODELO 2 — LIGAÇÃO DE DADOS ISP (M/M/1/F)
% =========================================================================
%
% QUANDO USAR (keywords):
%   "router", "pacotes", "fila de espera", "capacidade F pacotes",
%   "Poisson", "tamanho exponencial", "atraso médio", "FIFO",
%   "débito C Mbps", "packet drop"
%
% SISTEMA:
%   Chegadas: processo de Poisson com taxa λ (pacotes/segundo)
%   Serviço:  tamanho exponencial de média B bytes; tempo = 8*B/(C*1e6) s
%   Fila:     capacidade F pacotes (FIFO); pacote descartado se fila cheia
%   Servidor: 1 ligação (STATE=0 livre, STATE=1 ocupado)
%
% VARIÁVEIS DE ESTADO:
%   STATE   — 0 (livre) ou 1 (ocupado)
%   QUEUE_N — número de pacotes na fila
%   QUEUE   — vector com instantes de chegada dos pacotes na fila
%             (necessário para calcular o atraso individual de cada pacote)
%
% EVENTOS:
%   ARRIVAL   (0) — chegada de pacote
%   DEPARTURE (1) — fim de transmissão de pacote
%
% EventList tem 3 colunas: [tipo, instante_evento, instante_chegada]
%   → a 3ª coluna propaga o instante de chegada original até ao DEPARTURE
%   → permite calcular atraso = Clock_departure - instante_chegada
%
% CONTADORES ESTATÍSTICOS:
%   DELAYS      — soma dos atrasos de todos os pacotes transmitidos
%   TRANSMITTED — número de pacotes transmitidos (= critério de paragem)
%   N_ARRIVALS  — total de chegadas (para PD)
%   DROPPED     — pacotes descartados por fila cheia (para PD)
%
% PARÂMETROS DE DESEMPENHO:
%   AM (s)  = DELAYS / TRANSMITTED        → converter para ms: *1000
%   PD (%)  = 100 * DROPPED / N_ARRIVALS
%
% ACÇÕES POR EVENTO:
%
%   ARRIVAL:
%     → N_ARRIVALS++
%     → agendar próximo ARRIVAL: tmp=Clock+exprnd(1/lambda)
%       EventList = [EventList; ARRIVAL, tmp, tmp]   % chegada=instante
%     → se STATE==0: STATE=1, gerar tTime, agendar DEPARTURE com ArrInstant
%     → senão se QUEUE_N < F: QUEUE_N++, QUEUE=[QUEUE; ArrInstant]
%     → senão: DROPPED++  (fila cheia)
%
%   DEPARTURE:
%     → DELAYS = DELAYS + (Clock - ArrInstant)
%     → TRANSMITTED++
%     → se QUEUE_N > 0:
%          QInstant = QUEUE(1); gerar tTime;
%          agendar DEPARTURE com QInstant
%          QUEUE_N--; QUEUE(1)=[]
%     → senão: STATE=0
%
% CÁLCULO DO TEMPO DE TRANSMISSÃO:
%   tTime = 8 * tamanho_bytes / (C * 1e6)   [em segundos]
%   Para exponencial:  tTime = 8 * exprnd(B) / (C*1e6)
%   Para discreta:     pkt = x_sizes(sum(rand()>f_cum))
%                      tTime = 8 * pkt / (C*1e6)
%
% EXEMPLO (Ex. 6): λ=1000pps, B=600B, C=10Mbps, F=1000, N=1e4
%   ρ = 1000*(600*8)/(10e6) = 0.48   → sistema estável
%   AM ≈ 0.923 ms   (IC estreito: sistema estável)
%
% EXEMPLO (Ex. 8): λ=2000pps → ρ≈0.96
%   AM ≈ 12 ms   (IC largo: próximo da saturação)
%
% CONCLUSÕES TÍPICAS:
%   - ρ → 1: atraso diverge, IC alarga dramaticamente
%   - F pequeno: PD aumenta, AM diminui (trade-off atraso/perda)
%   - Distribuição discreta ≈ exponencial se média igual (Ex. 6 vs 7)
%   - IC mais estreito com F pequeno (AM limitado superiormente)
%   - IC mais largo para PD a F intermédios (mais variabilidade entre runs)



% =========================================================================
% 5. ANÁLISE DE RESULTADOS — INTERVALOS DE CONFIANÇA
% =========================================================================
%
% QUANDO USAR IC:
%   Sempre que reportar resultados de simulação.
%   Dá confiança 100*(1-α)% de que a verdadeira média μ está no intervalo.
%
% PRÉ-REQUISITOS (Teorema do Limite Central):
%   X1,...,Xn i.i.d. (independentes e identicamente distribuídas)
%   → garantir independência usando sementes diferentes por simulação
%   → MATLAB usa sementes diferentes automaticamente por omissão
%
% FÓRMULA DO IC (desvio padrão σ desconhecido → distribuição t):
%   IC = [ X̄ - t_{α/2, n-1} * S/√n ,  X̄ + t_{α/2, n-1} * S/√n ]
%   onde:
%     X̄ = mean(X)          — média amostral
%     S = std(X)            — desvio padrão amostral
%     n = Nsim              — número de simulações
%     t_{α/2, n-1}          — quantil da distribuição t-Student
%
% LARGURA DO IC ∝ S / √n
%   → Para IC metade da largura: precisamos 4x mais simulações
%   → Para IC 1/3 da largura:   precisamos 9x mais simulações
%   → Alternativa: aumentar N (simulações maiores → S menor)
%
% MATLAB:
%   media = mean(X);
%   [~, ~, ci] = ttest(X, media, 'alpha', alfa);
%   % alfa = 0.1 para IC 90%
%   % alfa = 0.05 para IC 95%
%   fprintf('param = %.4f [%.4f - %.4f]\n', media, ci(1), ci(2));
%
% EXEMPLO (Ex. 2):
%   10 runs:  PB = 1.147 [0.935 - 1.360] %   (largura ≈ 0.425)
%   100 runs: PB = 0.948 [0.885 - 1.011] %   (largura ≈ 0.126)
%   razão: 0.425/0.126 ≈ 3.37 ≈ √(100/10) = √10 ≈ 3.16  ✓
%
% INTERPRETAÇÃO DA LARGURA DO IC:
%   Estreito → estimativa confiável (sistema estável, baixa variância)
%   Largo    → estimativa incerta  (sistema perto da saturação, F intermédio)



% =========================================================================
% 6. FUNÇÕES MATLAB PRONTAS A USAR
% =========================================================================

% --- 6a. VideoStreamingSimulator ---
% Uso: [PB, DB] = VideoStreamingSimulator(lambda, invmiu, B, M, N)
% lambda  — taxa de chegadas (pedidos/minuto)
% invmiu  — duração média dos filmes (minutos)
% B       — débito por filme (Mbps)
% M       — capacidade máxima (filmes simultâneos)
% N       — critério de paragem (N filmes transmitidos)
% PB      — probabilidade de bloqueio (%)
% DB      — débito médio do servidor (Mbps)

function [PB, DB] = VideoStreamingSimulator(lambda, invmiu, B, M, N)
    ARRIVAL = 0; DEPARTURE = 1;
    Clock = 0; STATE = 0; TRANSMITTED = 0;
    N_ARRIVALS = 0; BLOCKED = 0; LOAD = 0;
    EventList = [ARRIVAL, Clock + exprnd(1/lambda)];
    while TRANSMITTED < N
        EventList = sortrows(EventList, 2);
        event = EventList(1,1);
        PreviousClock = Clock;
        Clock = EventList(1,2);
        EventList(1,:) = [];
        LOAD = LOAD + B * STATE * (Clock - PreviousClock);
        switch event
            case ARRIVAL
                EventList = [EventList; ARRIVAL, Clock + exprnd(1/lambda)];
                N_ARRIVALS = N_ARRIVALS + 1;
                if STATE < M
                    STATE = STATE + 1;
                    EventList = [EventList; DEPARTURE, Clock + exprnd(invmiu)];
                else
                    BLOCKED = BLOCKED + 1;
                end
            case DEPARTURE
                STATE = STATE - 1;
                TRANSMITTED = TRANSMITTED + 1;
        end
    end
    PB = 100 * BLOCKED / N_ARRIVALS;
    DB = LOAD / Clock;
end


% --- 6b. LinkSimulator (tamanho exponencial) ---
% Uso: AM = LinkSimulator(lambda, B, C, F, N)
% lambda — taxa de chegadas (pacotes/segundo)
% B      — tamanho médio do pacote (Bytes)
% C      — capacidade da ligação (Mbps)
% F      — capacidade da fila (pacotes)
% N      — critério de paragem
% AM     — atraso médio por pacote (segundos)

function AM = LinkSimulator(lambda, B, C, F, N)
    ARRIVAL = 0; DEPARTURE = 1;
    Clock = 0; STATE = 0; QUEUE_N = 0;
    DELAYS = 0; TRANSMITTED = 0; QUEUE = [];
    tmp = Clock + exprnd(1/lambda);
    EventList = [ARRIVAL, tmp, tmp];
    while TRANSMITTED < N
        EventList = sortrows(EventList, 2);
        Event = EventList(1,1); Clock = EventList(1,2);
        ArrInstant = EventList(1,3); EventList(1,:) = [];
        switch Event
            case ARRIVAL
                tmp = Clock + exprnd(1/lambda);
                EventList = [EventList; ARRIVAL, tmp, tmp];
                if STATE == 0
                    STATE = 1;
                    tTime = 8 * exprnd(B) / (C * 1e6);
                    EventList = [EventList; DEPARTURE, Clock+tTime, ArrInstant];
                else
                    if QUEUE_N < F
                        QUEUE_N = QUEUE_N + 1;
                        QUEUE = [QUEUE; ArrInstant];
                    end
                end
            case DEPARTURE
                DELAYS = DELAYS + (Clock - ArrInstant);
                TRANSMITTED = TRANSMITTED + 1;
                if QUEUE_N > 0
                    QInstant = QUEUE(1);
                    tTime = 8 * exprnd(B) / (C * 1e6);
                    EventList = [EventList; DEPARTURE, Clock+tTime, QInstant];
                    QUEUE_N = QUEUE_N - 1; QUEUE(1) = [];
                else
                    STATE = 0;
                end
        end
    end
    AM = DELAYS / TRANSMITTED;
end


% --- 6c. LinkSimulatorDiscrete (distribuição discreta do tamanho) ---
% Uso: AM = LinkSimulatorDiscrete(lambda, x_sizes, f_cum, C, F, N)
% x_sizes — vector de tamanhos possíveis (Bytes)
% f_cum   — CDF acumulada: [0, cumsum(f_sizes)]  (length = length(x_sizes)+1)
% (restantes parâmetros iguais ao LinkSimulator)

function AM = LinkSimulatorDiscrete(lambda, x_sizes, f_cum, C, F, N)
    ARRIVAL = 0; DEPARTURE = 1;
    Clock = 0; STATE = 0; QUEUE_N = 0;
    DELAYS = 0; TRANSMITTED = 0; QUEUE = [];
    tmp = Clock + exprnd(1/lambda);
    EventList = [ARRIVAL, tmp, tmp];
    while TRANSMITTED < N
        EventList = sortrows(EventList, 2);
        Event = EventList(1,1); Clock = EventList(1,2);
        ArrInstant = EventList(1,3); EventList(1,:) = [];
        switch Event
            case ARRIVAL
                tmp = Clock + exprnd(1/lambda);
                EventList = [EventList; ARRIVAL, tmp, tmp];
                if STATE == 0
                    STATE = 1;
                    pkt = x_sizes(sum(rand() > f_cum));
                    tTime = 8 * pkt / (C * 1e6);
                    EventList = [EventList; DEPARTURE, Clock+tTime, ArrInstant];
                else
                    if QUEUE_N < F
                        QUEUE_N = QUEUE_N + 1;
                        QUEUE = [QUEUE; ArrInstant];
                    end
                end
            case DEPARTURE
                DELAYS = DELAYS + (Clock - ArrInstant);
                TRANSMITTED = TRANSMITTED + 1;
                if QUEUE_N > 0
                    QInstant = QUEUE(1);
                    pkt = x_sizes(sum(rand() > f_cum));
                    tTime = 8 * pkt / (C * 1e6);
                    EventList = [EventList; DEPARTURE, Clock+tTime, QInstant];
                    QUEUE_N = QUEUE_N - 1; QUEUE(1) = [];
                else
                    STATE = 0;
                end
        end
    end
    AM = DELAYS / TRANSMITTED;
end


% --- 6d. LinkSimulatorDP (com estimação de PD) ---
% Uso: [AM, PD] = LinkSimulatorDP(lambda, x_sizes, f_cum, C, F, N)
% AM — atraso médio (segundos)
% PD — probabilidade de descarte de pacotes (%)

function [AM, PD] = LinkSimulatorDP(lambda, x_sizes, f_cum, C, F, N)
    ARRIVAL = 0; DEPARTURE = 1;
    Clock = 0; STATE = 0; QUEUE_N = 0;
    DELAYS = 0; TRANSMITTED = 0; QUEUE = [];
    N_ARRIVALS = 0; DROPPED = 0;
    tmp = Clock + exprnd(1/lambda);
    EventList = [ARRIVAL, tmp, tmp];
    while TRANSMITTED < N
        EventList = sortrows(EventList, 2);
        Event = EventList(1,1); Clock = EventList(1,2);
        ArrInstant = EventList(1,3); EventList(1,:) = [];
        switch Event
            case ARRIVAL
                tmp = Clock + exprnd(1/lambda);
                EventList = [EventList; ARRIVAL, tmp, tmp];
                N_ARRIVALS = N_ARRIVALS + 1;
                if STATE == 0
                    STATE = 1;
                    pkt = x_sizes(sum(rand() > f_cum));
                    tTime = 8 * pkt / (C * 1e6);
                    EventList = [EventList; DEPARTURE, Clock+tTime, ArrInstant];
                else
                    if QUEUE_N < F
                        QUEUE_N = QUEUE_N + 1;
                        QUEUE = [QUEUE; ArrInstant];
                    else
                        DROPPED = DROPPED + 1;
                    end
                end
            case DEPARTURE
                DELAYS = DELAYS + (Clock - ArrInstant);
                TRANSMITTED = TRANSMITTED + 1;
                if QUEUE_N > 0
                    QInstant = QUEUE(1);
                    pkt = x_sizes(sum(rand() > f_cum));
                    tTime = 8 * pkt / (C * 1e6);
                    EventList = [EventList; DEPARTURE, Clock+tTime, QInstant];
                    QUEUE_N = QUEUE_N - 1; QUEUE(1) = [];
                else
                    STATE = 0;
                end
        end
    end
    AM = DELAYS / TRANSMITTED;
    PD = 100 * DROPPED / N_ARRIVALS;
end


% --- Script genérico de IC (reutilizável) ---
%
% Nsim = 100; alfa = 0.1;   % 90% IC
% resultados = zeros(1, Nsim);
% for it = 1:Nsim
%     resultados(it) = MinhaFuncao(params...);
% end
% media = mean(resultados);
% [~, ~, ci] = ttest(resultados, media, 'alpha', alfa);
% fprintf('param = %.4f [%.4f - %.4f]\n', media, ci(1), ci(2));


% --- Script genérico de distribuição discreta (Ex. 7) ---
%
% x_sizes = 64:1500;
% n_other = length(x_sizes) - 3;
% p_other = (1 - 0.29606 - 0.16417 - 0.19601) / n_other;
% f_sizes = ones(1, length(x_sizes)) * p_other;
% f_sizes(x_sizes == 64)   = 0.29606;
% f_sizes(x_sizes == 110)  = 0.16417;
% f_sizes(x_sizes == 1500) = 0.19601;
% avg_size = sum(x_sizes .* f_sizes);           % média = 600.003 Bytes
% f_cum    = [0, cumsum(f_sizes)];               % pré-calcular 1 vez
% pkt_size = x_sizes(sum(rand() > f_cum));       % gerar 1 amostra



% =========================================================================
% 7. MODELOS TEÓRICOS DE FILAS DE ESPERA
% =========================================================================

% --- 7a. M/M/m/m — Erlang-B (servidor de video-streaming) ---
%
% QUANDO USAR:
%   Sistema com m servidores, sem fila de espera.
%   Chegadas Poisson (λ), serviço exponencial (μ), capacidade = m.
%   Pedido bloqueado se todos os m servidores estão ocupados.
%
% PARÂMETROS:
%   λ     — taxa de chegadas
%   μ     — taxa de serviço (1/invmiu)
%   m = M — número de servidores (capacidade)
%   ρ = λ/μ — tráfego oferecido (em Erlangs)
%
% PROBABILIDADES DE ESTADO:
%   P(n) = (ρ^n / n!) / sum_{k=0}^{m} (ρ^k / k!),   n = 0,...,m
%
% PARÂMETROS DE DESEMPENHO:
%   PB = P(m)                         (probabilidade de bloqueio)
%   DB = B * sum_{n=0}^{m} n * P(n)   (débito médio em Mbps)
%      = B * ρ * (1 - P(m))           (simplificação)
%
% MATLAB (Ex. 5):
%   lambda = 2; mu = 1/100.39; B_mbps = 2; M = 200;
%   rho = lambda / mu;
%   n_vals = 0:M;
%   % Usar log para evitar overflow com factoriais grandes
%   log_unnorm = n_vals * log(rho) - cumsum([0, log(1:M)]);
%   log_unnorm = log_unnorm - max(log_unnorm);   % estabilidade numérica
%   unnorm = exp(log_unnorm);
%   P = unnorm / sum(unnorm);
%   PB_theory = P(end);
%   DB_theory = B_mbps * sum(n_vals .* P);


% --- 7b. M/M/1/m — Fila finita (ligação de dados) ---
%
% QUANDO USAR:
%   1 servidor, fila de capacidade F, capacidade total m = F+1.
%   Chegadas Poisson (λ), serviço exponencial (μ).
%   Pacote descartado se sistema cheio (STATE=1 e QUEUE_N=F).
%
% PARÂMETROS:
%   λ     — taxa de chegadas (pps)
%   μ     — taxa de serviço = C / (8 * B_avg)  (pps)
%   ρ = λ/μ — intensidade de tráfego
%   m = F+1 — capacidade total do sistema
%
% PROBABILIDADES DE ESTADO (ρ ≠ 1):
%   P(n) = (1-ρ) * ρ^n / (1 - ρ^{m+1}),   n = 0,...,m
%
% CASO ESPECIAL (ρ = 1):
%   P(n) = 1/(m+1)
%
% PARÂMETROS DE DESEMPENHO:
%   PD = P(m)                        (probabilidade de descarte)
%   E[N] = sum_{n=0}^{m} n * P(n)   (número médio no sistema)
%        = ρ/(1-ρ) - (m+1)*ρ^{m+1}/(1-ρ^{m+1})
%   λ_eff = λ * (1 - PD)             (taxa efectiva de chegadas)
%   AM = E[N] / λ_eff                (Lei de Little; em segundos)
%
% MATLAB (Ex. 13):
%   lambda=1800; C=10e6; B_avg=600.003; F=20;
%   mu = C / (8*B_avg); rho = lambda/mu; m = F+1;
%   n_vals = 0:m;
%   if abs(rho-1) > 1e-10
%       P = (1-rho)*rho.^n_vals / (1-rho^(m+1));
%   else
%       P = ones(1,m+1)/(m+1);
%   end
%   PD_th  = P(end);
%   EN     = sum(n_vals .* P);
%   AM_th  = EN / (lambda*(1-PD_th));   % segundos
%
% LEI DE LITTLE (geral):
%   E[N] = λ_eff * E[T]
%   → E[T] = E[N] / λ_eff    (tempo médio no sistema = AM)
%   Aplica-se a qualquer sistema estável em regime estacionário.



% =========================================================================
% 8. ERROS COMUNS E COMO EVITÁ-LOS
% =========================================================================
%
% ERRO 1: exprnd com taxa em vez de média
%   ERRADO:  exprnd(lambda)        % dá média=lambda, não média=1/lambda
%   CERTO:   exprnd(1/lambda)
%   ERRADO:  exprnd(mu)
%   CERTO:   exprnd(1/mu) = exprnd(invmiu)
%
% ERRO 2: Esquecer de converter unidades no tempo de transmissão
%   C está em Mbps = 10^6 bits/s
%   tamanho em Bytes → converter para bits: *8
%   CERTO: tTime = 8 * pkt_bytes / (C * 1e6)   [resultado em segundos]
%
% ERRO 3: Esquecer de converter AM para milissegundos no output
%   AM vem em segundos; para reportar em ms: AM_ms = AM * 1000
%
% ERRO 4: PB e PD em fracção vs percentagem
%   Verificar se fórmula usa 100* ou não; ser consistente no ttest e fprintf
%   Nestes exercícios: PB(%) = 100*BLOCKED/N_ARRIVALS
%                      PD(%) = 100*DROPPED/N_ARRIVALS
%
% ERRO 5: LOAD calculado depois do evento em vez de antes
%   CERTO: calcular LOAD ANTES do switch event (usa STATE anterior ao evento)
%   LOAD = LOAD + B * STATE * (Clock - PreviousClock);
%   switch event ...   % STATE muda aqui
%
% ERRO 6: f_cum mal construído
%   f_cum deve ter length(f)+1 elementos, começar em 0 e terminar em 1
%   CERTO: f_cum = [0, cumsum(f)];   % não apenas cumsum(f)
%
% ERRO 7: ttest com média errada
%   [~,~,ci] = ttest(X, mean(X), 'alpha', alfa)   % CERTO
%   Não confundir com ttest2 (duas amostras) nem com o valor hipótese
%
% ERRO 8: Capacidade total m no M/M/1/m
%   m = F + 1   (F lugares na fila + 1 no servidor)
%   n varia de 0 a m, não de 0 a F
%
% ERRO 9: Warm-up não considerado
%   Se N pequeno, o transiente inicial afecta as estimativas
%   Solução: usar N grande ou inicializar contadores após warm-up
%
% ERRO 10: Não ordenar EventList antes de extrair próximo evento
%   CERTO: EventList = sortrows(EventList, 2);  % ordenar por tempo (col 2)
%          event = EventList(1,1);
%          Clock = EventList(1,2);
%          EventList(1,:) = [];

% =========================================================================
% FIM DO FICHEIRO MPECI_notas.m
% =========================================================================