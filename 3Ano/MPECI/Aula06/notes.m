% =========================================================
%  NOTAS — MÉTODOS PROBABILÍSTICOS PARA ENGENHARIA DE
%          COMPUTADORES E INFORMÁTICA  2025/2026
%
%  Modelos de Filas de Espera e Disponibilidade
%  Referência rápida: fórmulas, quando usar, código pronto
% =========================================================
%
%  ÍNDICE
%  ──────────────────────────────────────────────────────
%  1. NOTAÇÃO GERAL (símbolos comuns a todos os modelos)
%  2. NOTAÇÃO DE KENDALL
%  3. LEI DE LITTLE
%  4. M/M/1/K  ←  ligações IP com buffer finito
%  5. M/M/1/B  ←  servidores com limite de aceitação
%  6. M/M/m    ←  call centers, clusters de servidores
%  7. CADEIAS DE MARKOV — DISPONIBILIDADE
%  8. DISPONIBILIDADE COM BACKUP
%  9. FUNÇÕES AUXILIARES REUTILIZÁVEIS
% ──────────────────────────────────────────────────────


% =========================================================
%  1. NOTAÇÃO GERAL
% =========================================================
%
%  λ  (lambda)    Taxa de chegadas [clientes/s ou /hora]
%                 = throughput / tamanho_médio_pacote
%                 Ex: 80 Mbps / 6400 bits = 12500 pkt/s
%
%  μ  (mu)        Taxa de serviço de UM servidor [clientes/s]
%                 = 1 / tempo_médio_de_serviço
%                 Ex: 1/200µs = 5000 req/s
%
%  ρ  (rho)       Intensidade de tráfego = λ/μ
%                 Para 1 servidor: fracção de tempo ocupado
%                 ρ < 1 obrigatório em filas infinitas
%
%  a              Carga oferecida = λ/μ  [Erlangs]
%                 Mesmo valor que ρ, nome diferente no
%                 contexto de Erlang-B e Erlang-C
%
%  K              Capacidade total do sistema
%                 = nº de lugares (servidor + fila)
%
%  Q              Capacidade da fila de espera
%                 K = 1 + Q  (para 1 servidor)
%
%  m              Número de servidores em paralelo
%
%  p_n            Probabilidade de n clientes no sistema
%
%  p_0            Probabilidade do sistema vazio
%                 (constante de normalização)
%
%  N̄  (N_avg)    Número médio de clientes no sistema
%                 N̄ = Σ n·p_n
%
%  N̄_q           Número médio na fila (só a esperar)
%
%  W̄  (W_avg)    Tempo médio no sistema [s]
%                 (espera + serviço) via Lei de Little
%
%  W̄_q           Tempo médio de espera na fila [s]
%                 W̄_q = W̄ - 1/μ
%
%  λ_eff          Taxa de chegadas efectiva (após perdas)
%                 λ_eff = λ·(1 - P_loss)


% =========================================================
%  2. NOTAÇÃO DE KENDALL:  A / B / c / K
% =========================================================
%
%  A = distribuição das chegadas
%  B = distribuição do tempo de serviço
%  c = número de servidores
%  K = capacidade total do sistema (omitido → infinita)
%
%  M = Memoryless = exponencial (processo de Poisson)
%  D = Determinístico
%  G = Geral
%
%  Exemplos:
%    M/M/1     →  1 servidor, fila infinita
%    M/M/1/K   →  1 servidor, capacidade K (perdas se cheio)
%    M/M/m     →  m servidores, fila infinita (Erlang-C)
%    M/M/B/B   →  B servidores, sem fila (Erlang-B, bloqueio)


% =========================================================
%  3. LEI DE LITTLE
% =========================================================
%
%  Válida para QUALQUER sistema estável, sem hipóteses
%  sobre distribuições. Relaciona as 3 métricas principais:
%
%    N̄ = λ_eff · W̄          (sistema completo)
%    N̄_q = λ_eff · W̄_q      (só a fila)
%
%  Como usar:
%    → Conheces N̄ e λ_eff ?  →  W̄ = N̄ / λ_eff
%    → Conheces W̄ e λ_eff ?  →  N̄ = λ_eff · W̄
%
%  ⚠ Usa SEMPRE λ_eff (não λ) quando há perdas/bloqueio,
%    porque o throughput real é λ·(1 - P_loss).


% =========================================================
%  4. MODELO M/M/1/K
% =========================================================
%
%  QUANDO USAR:
%    → 1 ligação/servidor com buffer de tamanho Q
%    → Pacotes que chegam quando buffer cheio são PERDIDOS
%    → Ex: ligações IP, routers com fila finita
%
%  IDENTIFICAÇÃO NO ENUNCIADO:
%    "queue of size Q packets"
%    "packet loss rate"
%    "average packet delay"
%    Throughput em Mbps + tamanho médio de pacote em Bytes
%
%  PARÂMETROS:
%    K = 1 + Q              (capacidade total)
%    λ = throughput_bits / bits_por_pacote
%    μ = capacidade_bits   / bits_por_pacote
%    ρ = λ / μ
%
%  FÓRMULAS:
%
%    p_0 = (1 - ρ) / (1 - ρ^(K+1))
%
%    p_n = p_0 · ρ^n ,    n = 0, 1, ..., K
%
%    P_loss = p_K                      (taxa de perda)
%
%    N̄ = Σ_{n=0}^{K} n · p_n         (nº médio no sistema)
%
%    λ_eff = λ · (1 - P_loss)
%
%    W̄ = N̄ / λ_eff                   (atraso médio, Lei de Little)
%
%  CÓDIGO:

function [P_loss, W_avg, N_avg] = mm1k(lambda, mu, K)
    rho    = lambda / mu;
    p0     = (1 - rho) / (1 - rho^(K + 1));
    n_vec  = 0:K;
    p      = p0 * rho .^ n_vec;
    P_loss = p(end);
    N_avg  = sum(n_vec .* p);
    W_avg  = N_avg / (lambda * (1 - P_loss));
end

%  EXEMPLO (exercício 1):
%    lambda = 80e6/6400 = 12500 pkt/s
%    mu     = 100e6/6400 = 15625 pkt/s
%    Q = 8  →  K = 9
%    [P_loss, W_avg] = mm1k(12500, 15625, 9)
%    → P_loss = 3.007%,  W_avg = 0.231 ms
%
%  PARA ENCONTRAR Q MÍNIMO (P_loss ≤ threshold):
%    Q = 1;
%    while mm1k(lambda, mu, 1+Q) > threshold
%        Q = Q + 1;
%    end


% =========================================================
%  5. MODELO M/M/1/B
% =========================================================
%
%  QUANDO USAR:
%    → Servidor com capacidade total fixa (B slots)
%    → Novos pedidos bloqueados se B slots estiverem ocupados
%    → NÃO há fila separada — B é o limite de simultâneos
%    → Ex: servidores de dados, sistemas com limite de sessões
%
%  IDENTIFICAÇÃO NO ENUNCIADO:
%    "acceptance limit of B simultaneous requests"
%    "service blocking probability"
%    "average service time per request"
%    "when attending N requests, serves each in T µsecs"
%       → capacidade total = N/T  →  μ_total = N/T
%
%  PARÂMETROS:
%    μ = n_ref / t_ref     (capacidade total do servidor)
%    ρ = λ / μ
%    K = B                 (capacidade = limite de aceitação)
%
%  FÓRMULAS:
%    Idênticas ao M/M/1/K com K = B:
%
%    p_0 = (1 - ρ) / (1 - ρ^(B+1))
%    p_n = p_0 · ρ^n
%    P_block = p_B
%    W̄ = N̄ / λ_eff
%
%  CÓDIGO: reutiliza mm1k() com K = B
%
%    [P_block, W_avg] = mm1k(lambda, mu, B)
%
%  EXEMPLO (exercício 2):
%    n_ref=250, t_ref=200e-6 s  →  mu = 250/200e-6 = 1.25e6 req/s
%    lambda = 1.23e6,  B = 250
%    → P_block = 0.02888%,  W_avg = 46.389 µs
%
%  CONCLUSÃO TÍPICA (variar B):
%    B ↑  →  P_block ↓  (menos bloqueio)
%    B ↑  →  W̄ ↑       (mais tempo médio por pedido)
%    Trade-off: acessibilidade vs desempenho individual


% =========================================================
%  6. MODELO M/M/m  (Erlang-C)
% =========================================================
%
%  QUANDO USAR:
%    → m servidores idênticos em paralelo
%    → Fila de espera INFINITA (ninguém é rejeitado)
%    → Clientes esperam quando todos os m servidores ocupados
%    → Ex: call centers, pools de threads, clusters
%
%  IDENTIFICAÇÃO NO ENUNCIADO:
%    "m operators / servers"
%    "average queuing time"
%    "probability of all operators being occupied"
%    Sem menção de perda ou bloqueio
%
%  PARÂMETROS:
%    ρ = λ / (m·μ)     utilização por servidor (< 1 obrigatório)
%    a = λ / μ         carga total [Erlangs]
%
%  FÓRMULAS:
%
%    p_0 = 1 / [ Σ_{n=0}^{m-1} a^n/n!  +  a^m/(m!·(1-ρ)) ]
%
%    Erlang-C:  C(m,a) = p_0 · a^m / (m! · (1-ρ))
%               = P(todos os m servidores ocupados)
%               = P(cliente tem de esperar)
%
%    W̄_q = C(m,a) / (m·μ - λ)       tempo médio de espera [s]
%
%    W̄   = W̄_q + 1/μ                tempo médio no sistema [s]
%
%  ⚠ Taxa de serviço total muda com o estado n:
%      n ≤ m  →  taxa saída = n·μ    (n servidores activos)
%      n > m  →  taxa saída = m·μ    (todos m ocupados, fila cresce)
%
%  CÓDIGO:

function [C, Wq] = mmm_erlangC(lambda, mu, m)
    rho = lambda / (m * mu);
    if rho >= 1
        error('Sistema instável: rho = %.4f >= 1', rho);
    end
    a            = lambda / mu;
    soma_finita  = sum(a .^ (0:m-1) ./ factorial(0:m-1));
    soma_fila    = a^m / (factorial(m) * (1 - rho));
    p0           = 1 / (soma_finita + soma_fila);
    C            = p0 * soma_fila;         % Erlang-C
    Wq           = C / (m * mu - lambda);  % tempo espera [mesmas unidades de μ]
end

%  EXEMPLO (exercício 3):
%    lambda=370/hora, mu=20/hora (= 1/3 min^-1 * 60), m=20
%    [C, Wq_h] = mmm_erlangC(370, 20, 20)
%    Wq_s = Wq_h * 3600
%    → C = 64.813%,  Wq = 77.776 s
%
%  PARA ENCONTRAR m MÍNIMO (Wq ≤ threshold em segundos):
%    m_test = 1;
%    while true
%        [~, Wq] = mmm_erlangC(lambda, mu, m_test);
%        if Wq * 3600 <= threshold_sec; break; end
%        m_test = m_test + 1;
%    end
%
%  CONCLUSÃO TÍPICA (variar λ com m fixo):
%    λ → m·μ  (saturação)  →  Wq → ∞  (crescimento explosivo)
%    O sistema é muito sensível à carga perto da saturação.
%    Mesmo pequenos aumentos de λ causam grandes aumentos de Wq.


% =========================================================
%  7. CADEIAS DE MARKOV — DISPONIBILIDADE DE SERVIDORES
% =========================================================
%
%  QUANDO USAR:
%    → Sistema com múltiplas causas de falha independentes
%    → Cada causa tem MTBF e MTTR próprios
%    → Queremos disponibilidade, MTBF e MTTR globais
%    → Ex: servidor com hardware + hypervisor + VM
%
%  IDENTIFICAÇÃO NO ENUNCIADO:
%    "average time between failures is X days/years"
%    "failures are solved in Y hours/days"
%    "server availability"
%    "MTBF" / "MTTR"
%
%  CONSTRUÇÃO DA MATRIZ Q:
%
%    Estados: 1 = disponível, 2..k = em reparação da causa i
%
%    Taxa de falha (1 → i):   λ_i = 1 / MTBF_i
%    Taxa de reparação (i→1): μ_i = 1 / MTTR_i
%
%    Q(i,j) = taxa de transição do estado i para j
%    Q(i,i) = - Σ_{j≠i} Q(i,j)
%
%  RESOLVER DISTRIBUIÇÃO ESTACIONÁRIA:
%    π · Q = 0   com   Σ π_i = 1
%
%    Em MATLAB:
%      A = Q';
%      A(end,:) = 1;
%      b = zeros(n,1); b(end) = 1;
%      pi = A \ b;
%
%    Disponibilidade = π(1)   (fracção de tempo no estado 1)
%
%  MTBF e MTTR:
%    λ_total = Σ λ_i              (taxa total de falha)
%    MTBF    = 1 / λ_total
%    MTTR    = MTBF · (1 - A) / A
%
%  CÓDIGO:

function [avail, MTBF, MTTR_h] = markov_availability(Q)
    % Q: matriz geradora n×n (dias^-1)
    n      = size(Q, 1);
    A      = Q';
    A(end,:) = 1;
    b      = zeros(n, 1); b(end) = 1;
    pi     = A \ b;
    avail  = pi(1);
    % Taxa total de falha = soma das saídas do estado 1
    lf_total = sum(Q(1, 2:end));
    MTBF     = 1 / lf_total;            % dias
    MTTR_h   = MTBF * (1 - avail) / avail * 24;  % horas
end

%  EXEMPLO (exercício 4):
%    Q = zeros(4);
%    Q(1,2)=1/730; Q(1,3)=1/180; Q(1,4)=1/90;
%    Q(2,1)=1/2;   Q(3,1)=4;     Q(4,1)=24;
%    for i=1:4; Q(i,i)=-sum(Q(i,:))+Q(i,i); end
%    [avail, MTBF, MTTR_h] = markov_availability(Q)
%    → avail = 99.509%,  MTBF = 55.44 dias,  MTTR = 6.57 h
%
%  CONVERSÃO DE UNIDADES (para dias^-1):
%    MTBF em anos   → × 365
%    MTTR em horas  → / 24
%    MTTR em minutos→ / 1440


% =========================================================
%  8. DISPONIBILIDADE COM BACKUP
% =========================================================
%
%  QUANDO USAR:
%    → Data center: n servidores primários + 1 backup
%    → Cada servidor tem disponibilidade A_vm
%    → Queremos saber: qual o máximo n garantindo A ≥ alvo?
%
%  IDENTIFICAÇÃO NO ENUNCIADO:
%    "one backup server dedicated to each set of n primary servers"
%    "VM availability is at least X%"
%
%  FÓRMULA:
%    A_group(n) = A_vm + (1 - A_vm) · A_vm^n
%
%    Interpretação:
%      A_vm         → primário está up (disponível directamente)
%      (1-A_vm)·A_vm^n → primário down, backup up E livre
%                       (backup up: prob A_vm;
%                        backup livre: todos os outros n-1 primários up: A_vm^(n-1))
%
%  CÓDIGO:

function A_group = backup_availability(A_vm, n)
    A_group = A_vm + (1 - A_vm) .* A_vm .^ n;
end

function n_max = max_primaries(A_vm, target)
    n_max = 1;
    while backup_availability(A_vm, n_max + 1) >= target
        n_max = n_max + 1;
    end
end

%  EXEMPLO (exercício 5):
%    A_vm = 0.999,  target = 0.9999
%    n_max = max_primaries(0.999, 0.9999)
%    → n_max = 105,  A = backup_availability(0.999, 105) = 99.990%
%
%  CONCLUSÃO TÍPICA:
%    n ↑  →  A_group ↓  (backup cada vez mais provavelmente ocupado)
%    Para n grande, o backup está frequentemente a cobrir outra falha
%    quando o teu primário falha → disponibilidade efectiva cai.


% =========================================================
%  9. FUNÇÕES AUXILIARES REUTILIZÁVEIS (resumo)
% =========================================================
%
%  mm1k(lambda, mu, K)
%    → [P_loss, W_avg, N_avg]
%    Modelos: M/M/1/K e M/M/1/B
%
%  mmm_erlangC(lambda, mu, m)
%    → [C, Wq]   (C = Erlang-C, Wq em unidades de 1/mu)
%    Modelo: M/M/m
%
%  markov_availability(Q)
%    → [avail, MTBF_dias, MTTR_horas]
%    Modelo: Cadeia de Markov de disponibilidade
%
%  backup_availability(A_vm, n)
%    → A_group   (disponibilidade com n primários + 1 backup)
%
%  max_primaries(A_vm, target)
%    → n_max   (máximo n para A_group >= target)


% =========================================================
%  TABELA DE DECISÃO RÁPIDA
% =========================================================
%
%  ┌─────────────────────────────────────────────────────┐
%  │ Palavras-chave no enunciado    →   Modelo a usar    │
%  ├─────────────────────────────────────────────────────┤
%  │ "queue size Q", "packet loss", │                    │
%  │ "packet delay", Mbps + Bytes   │  →  M/M/1/K        │
%  ├─────────────────────────────────────────────────────┤
%  │ "acceptance limit B",          │                    │
%  │ "blocking probability",        │  →  M/M/1/B        │
%  │ "N requests at T µsecs"        │  (= M/M/1/K c/K=B) │
%  ├─────────────────────────────────────────────────────┤
%  │ "m operators/servers",         │                    │
%  │ "queuing time", sem bloqueio,  │  →  M/M/m          │
%  │ fila infinita                  │  (Erlang-C)        │
%  ├─────────────────────────────────────────────────────┤
%  │ "MTBF", "MTTR", "availability",│                    │
%  │ múltiplos tipos de falha       │  →  Markov         │
%  ├─────────────────────────────────────────────────────┤
%  │ "n primary + 1 backup",        │                    │
%  │ "VM availability >= X%"        │  →  Backup model   │
%  └─────────────────────────────────────────────────────┘


% =========================================================
%  ERROS COMUNS A EVITAR
% =========================================================
%
%  1. UNIDADES MISTURADAS
%     λ e μ devem estar nas mesmas unidades de tempo.
%     Se μ = 20 pedidos/hora, λ também tem de ser /hora.
%     Se μ = 5000 pedidos/s, λ tem de ser /s.
%
%  2. ρ vs utilização
%     ρ = λ/μ para M/M/1/K e M/M/1/B
%     ρ = λ/(m·μ) para M/M/m  (utilização por servidor)
%     Estabilidade: ρ < 1 para filas infinitas
%
%  3. K vs Q no M/M/1/K
%     K = capacidade TOTAL (servidor + fila)
%     Q = capacidade da FILA apenas
%     K = 1 + Q  (para 1 servidor)
%
%  4. Lei de Little com perdas
%     Usar SEMPRE λ_eff = λ·(1-P_loss), não λ
%     W̄ = N̄ / λ_eff  (não N̄/λ)
%
%  5. Converter W para ms ou µs
%     Se λ em pkt/s → W em segundos → × 1e3 para ms
%     Se λ em req/hora → W em horas → × 3600 para segundos
%
%  6. factorial() em MATLAB para n grande
%     factorial(n) para n > ~170 dá Inf.
%     Usar gammaln() para somas logarítmicas:
%       log_prob = n*log(a) - gammaln(n+1) + log(p0)
%
%  7. Markov: diagonal de Q
%     Q(i,i) = -(soma de todas as taxas de saída do estado i)
%     Verificação: cada linha de Q deve somar zero.
%     sum(Q, 2)  deve dar vector de zeros (ou ~eps).