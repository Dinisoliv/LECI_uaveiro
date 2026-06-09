% =====================================================
%  MPECI 2025/2026 — NOTAS GUIA 4
%  Cadeias de Markov, Birth-Death, M/M/1, M/M/1/m
% =====================================================


% =====================================================
%  1. CADEIA DE MARKOV — ESTADOS DE QUALIDADE (BER)
% =====================================================
%
%  QUANDO USAR:
%    → Link com múltiplos estados de qualidade (BER)
%    → Transições entre estados com taxas dadas
%    → Perguntas sobre probabilidade de erro em frames
%
%  IDENTIFICAÇÃO:
%    "bit error rate", "state transition rates"
%    "probability of frame received with errors"
%
%  CONSTRUÇÃO DA MATRIZ Q (birth-death linear):
%    Estados i=0..n-1, taxas forward f_i e backward b_i
%    Q(i,i+1) = f_i   (transição para estado pior)
%    Q(i+1,i) = b_i   (transição para estado melhor)
%    Q(i,i)   = -(soma saídas)
%
%  DISTRIBUIÇÃO ESTACIONÁRIA:
%    π·Q = 0,  Σπ = 1
%    A=Q'; A(end,:)=1; b=zeros; b(end)=1; pi=A\b
%
%  TEMPO MÉDIO DE PERMANÊNCIA no estado i [horas]:
%    h_i = 1 / |Q(i,i)|     → ×60 para minutos
%
%  PROBABILIDADE DE ERRO NUM FRAME de L bytes:
%    P(erro | BER=b) = 1 - (1-b)^(L*8)
%    P(erro) = Σ_i π_i · P(erro | BER_i)        % lei total
%
%  PROBABILIDADE DE SEM ERRO (frame L bytes):
%    P(ok) = Σ_i π_i · (1-BER_i)^(L*8)
%
%  BAYES — dado frame com erro, qual o estado?
%    P(BER_i | erro) = P(erro|BER_i) · π_i / P(erro)
%    → estados com BER alta ficam mais prováveis
%    → estados com BER baixa ficam menos prováveis
%
%  CÓDIGO:

function pi = markov_stationary(Q)
    n = size(Q,1);
    A = Q'; A(end,:) = 1;
    b = zeros(n,1); b(end) = 1;
    pi = A \ b;
end

function p_err = frame_error_prob(pi, bers, L_bytes)
    bits = L_bytes * 8;
    p_err = sum(pi .* (1 - (1-bers).^bits));
end

function p_post = bayes_state_given_error(pi, bers, L_bytes)
    bits   = L_bytes * 8;
    p_err_given_state = 1 - (1-bers).^bits;
    p_err  = sum(pi .* p_err_given_state);
    p_post = (p_err_given_state .* pi) / p_err;
end

%  EXEMPLO (exercício 1):
%    BER states: [1e-2, 1e-3, 1e-4, 1e-5, 1e-6]
%    fwd=[10,2,5,8], bwd=[1,20,100,600] (transiçoes/hora)
%    pi = [8.30% 82.98% 8.30% 0.41% 0.006%]
%    Holding times: [6, 20, 2.4, 0.56, 0.10] minutos
%    P(erro 100B) = 54.65%
%    P(ok 1500B)  = 2.87%
%    P(BER=1e-6 | erro 1500B) << P(BER=1e-2 | erro 1500B)
%    → frames com erro são muito mais prováveis no estado 1e-2
%
%  CONCLUSÃO TÍPICA (Bayes):
%    Quando um frame chega com erro, a probabilidade
%    de estar no estado com BER mais alta aumenta muito
%    em relação à probabilidade a priori.


% =====================================================
%  2. MARKOV — DISPONIBILIDADE COM FALHAS DEPENDENTES
% =====================================================
%
%  QUANDO USAR:
%    → Servidor com falhas de HW e SW encadeadas
%    → HW failure → primeiro repara HW, depois SW
%    → SW failure → só repara SW
%
%  IDENTIFICAÇÃO:
%    "hardware failure requires hardware repair then software repair"
%    "software failure requires only software repair"
%    MTBF e MTTR dados separadamente para cada causa
%
%  ESTADOS:
%    1 = servidor ok
%    2 = a reparar hardware (depois vai para 3)
%    3 = a reparar software (depois volta a 1)
%
%  TAXAS (converter para dias^-1):
%    λ_hw  = 1/MTBF_hw        (1→2)
%    λ_sw  = 1/MTBF_sw        (1→3, falha SW directa)
%    μ_hw  = 1/MTTR_hw        (2→3, HW reparado, falta SW)
%    μ_sw  = 1/MTTR_sw        (3→1, SW reparado)
%
%  ⚠ Diferença do modelo simples:
%    Após falha HW, o sistema passa por 2→3→1
%    Não vai directamente de 2 para 1!
%    O estado 3 é partilhado: tanto falhas SW como pós-HW
%
%  DISPONIBILIDADE = π(1)
%
%  DOWNTIME num período T (dias):
%    downtime_horas = (1 - π(1)) * T * 24
%
%  CÓDIGO:

function [pi, avail, downtime_h] = server_availability(lf_hw, lf_sw, mr_hw, mr_sw, T_days)
    Q = zeros(3);
    Q(1,2) = lf_hw; Q(1,3) = lf_sw;
    Q(2,3) = mr_hw;
    Q(3,1) = mr_sw;
    for i=1:3; Q(i,i) = -sum(Q(i,:)); end
    n = 3; A = Q'; A(end,:)=1; b=zeros(3,1); b(end)=1;
    pi        = A \ b;
    avail     = pi(1);
    downtime_h = (1-avail) * T_days * 24;
end

%  EXEMPLO (exercício 2):
%    MTBF_hw=500d, MTBF_sw=90d, MTTR_hw=1d, MTTR_sw=4h=4/24d
%    lf_hw=1/500, lf_sw=1/90, mr_hw=1, mr_sw=6
%    π = [99.58%, 0.20%, 0.22%]
%    Disponibilidade = 99.58%
%    Downtime em 30 dias = 3.0 horas
%
%  CONVERSÃO DE UNIDADES:
%    4 horas = 4/24 dias  → μ_sw = 1/(4/24) = 6/dia
%    Verificação: sum(Q,2) deve ser zero em cada linha


% =====================================================
%  3. BIRTH-DEATH — N SERVIDORES, t TÉCNICOS
% =====================================================
%
%  QUANDO USAR:
%    → N servidores idênticos, t técnicos de manutenção
%    → Estado n = número de servidores avariados
%    → Taxas de falha e reparação dependem do estado
%
%  IDENTIFICAÇÃO:
%    "N servers", "t technicians/repairmen"
%    "average number of servers down"
%    "probability of at least X servers in operation"
%
%  TAXAS DE TRANSIÇÃO (estado n = n servidores avariados):
%    λ_n = (N-n) · λ_f    taxa de falha  (n→n+1)
%           N-n servidores UP, cada falha a taxa λ_f=1/MTBF
%
%    μ_n = min(n,t) · μ_r  taxa de reparação (n→n-1)
%           min(n,t) técnicos ocupados, cada repara a μ_r=1/MTTR
%
%  PROBABILIDADES (birth-death):
%    p_n = p_0 · Π_{i=0}^{n-1} (λ_i / μ_{i+1})
%    p_0 = 1 / Σ_{n=0}^{N} p_n (não normalizado)
%
%  MÉTRICAS:
%    N̄_down  = Σ n · p_n          (média de servidores avariados)
%    N̄_techs = Σ min(n,t) · p_n   (média de técnicos ocupados)
%    P(≥k servidores UP) = Σ_{n=0}^{N-k} p_n
%
%  CÓDIGO:

function p = birth_death_servers(N, t, lf, mr)
    lam = @(n) (N-n)*lf;
    mu  = @(n) min(n,t)*mr;
    p   = ones(N+1, 1);
    for n = 1:N
        p(n+1) = p(n) * lam(n-1) / mu(n);
    end
    p = p / sum(p);
end

%  EXEMPLO (exercício 3):
%    N=100 servidores, λ_f=1/200 dia^-1, μ_r=24/36=2/3 dia^-1
%    t=1: N̄_down=2.51, N̄_techs=0.73, P(≥90 up)=98.14%
%    t=2: N̄_down=0.86, N̄_techs=0.74, P(≥90 up)=99.998%
%    t=3: N̄_down=0.76, N̄_techs=0.74, P(≥90 up)≈100%
%
%  CONCLUSÃO TÍPICA:
%    t=2 já dá grande melhoria vs t=1.
%    t=3 tem ganho marginal — o 3º técnico fica quase
%    sempre inactivo (N̄_techs≈N̄_techs para t=2).


% =====================================================
%  4. M/M/1  (fila infinita, 1 servidor)
% =====================================================
%
%  QUANDO USAR:
%    → 1 servidor, chegadas Poisson, serviço exponencial
%    → Fila INFINITA — ninguém é rejeitado
%    → Pergunta sobre tempo no sistema, ocupação, P(Nq>k)
%
%  IDENTIFICAÇÃO:
%    "M/M/1", sem menção de capacidade limite
%    "average time in system", "server occupation"
%    "probability queue > k"
%
%  CONDIÇÃO DE ESTABILIDADE: ρ = λ/μ < 1
%
%  FÓRMULAS FECHADAS (não precisam de somatórios):
%
%    ρ = λ/μ                     utilização
%    W̄ = 1/(μ-λ)                tempo médio no sistema
%    W̄_q = ρ/(μ-λ) = W̄ - 1/μ  tempo médio na fila
%    N̄ = ρ/(1-ρ)                média no sistema
%    N̄_q = ρ²/(1-ρ)             média na fila
%
%    P(N > k) = ρ^(k+1)          prob de mais de k no sistema
%    P(N_q > k) = ρ^(k+1)        prob de mais de k na fila
%    [para M/M/1 estas duas coincidem com deslocamento de 1]
%
%  CÓDIGO:

function [W, Wq, N, Nq, rho] = mm1(lambda, mu)
    rho = lambda / mu;
    if rho >= 1; error('Sistema instavel: rho=%.3f', rho); end
    W   = 1 / (mu - lambda);
    Wq  = rho / (mu - lambda);
    N   = rho / (1 - rho);
    Nq  = rho^2 / (1 - rho);
end

%  P(N>k) para M/M/1:
%    p_exceed = rho^(k+1)
%
%  EXEMPLO (exercício 4):
%    λ=8/min, μ=10/min, ρ=0.8
%    W̄  = 1/(10-8) = 0.5 min
%    ρ   = 80%
%    N̄_q = 0.64/0.2 = 3.2 clientes
%    P(Nq>6)  = 0.8^7  = 20.97%
%    P(Nq>20) = 0.8^21 = 0.92%
%    P(Nq>40) = 0.8^41 = 0.011%
%
%  GRÁFICO W vs λ:
%    lam_vec = 1:0.1:mu-0.01;
%    plot(lam_vec, 1./(mu-lam_vec))
%    → W explode quando λ→μ (saturação)


% =====================================================
%  5. M/M/1/m  (fila finita, capacidade m)
% =====================================================
%
%  QUANDO USAR:
%    → 1 servidor, capacidade total m (servidor+fila)
%    → Clientes descartados quando sistema cheio
%    → Mesmo modelo que M/M/1/K do guia 8
%
%  IDENTIFICAÇÃO:
%    "system capacity m", "clients discarded"
%    "discard probability", nota: aqui chama-se m ao que
%    no guia 8 se chama K
%
%  FÓRMULAS: idênticas ao M/M/1/K com K=m
%
%    p_0 = (1-ρ)/(1-ρ^(m+1))
%    p_n = p_0·ρ^n      n=0..m
%    P_discard = p_m
%    N̄_q = Σ_{n=1}^{m} (n-1)·p_n   (só quem está a esperar)
%    W̄ = N̄ / λ_eff    λ_eff = λ·(1-P_discard)
%
%  CÓDIGO: reutiliza mm1k do guia 8 com K=m

function [Pd, W_ms, Nq] = mm1m(lambda, mu, m)
    rho = lambda/mu;
    p0  = (1-rho)/(1-rho^(m+1));
    p   = p0 * rho.^(0:m);
    Pd  = p(end);
    N   = sum((0:m).*p);
    Nq  = sum(max((0:m)-1,0).*p);
    W_ms = N/(lambda*(1-Pd)) * 1000;   % ms
end

%  EXEMPLO (exercício 5):
%    λ=80/s, μ=100/s, ρ=0.8, m=10
%    P_discard = 2.35%
%    W̄ = 37.97 ms
%    N̄_q = 2.19 clientes
%
%  GRÁFICO P_discard vs m:
%    bar([5:5:40], arrayfun(@(m) mm1m(80,100,m), 5:5:40))
%    → P_discard decresce rapidamente com m
%    → A partir de m~25 a melhoria é marginal


% =====================================================
%  TABELA DE DECISÃO RÁPIDA — GUIA 4
% =====================================================
%
%  "BER states", "frame error prob"   → Markov BER (ex1)
%  "HW+SW failure", falhas encadeadas → Markov dependente (ex2)
%  "N servers + t technicians"        → Birth-death (ex3)
%  "M/M/1", fila infinita             → mm1() formulas fechadas
%  "M/M/1/m", "clients discarded"     → mm1k() com K=m


% =====================================================
%  ERROS COMUNS
% =====================================================
%
%  ✗ Ex1: esquecer ×8 (bytes→bits) no cálculo de P(erro)
%  ✗ Ex2: ligar 2→1 directamente (ignorar que HW repair
%         vai para 3=SW repair, não para 1 directamente)
%  ✗ Ex3: usar n*mr em vez de min(n,t)*mr para μ_n
%  ✗ Ex4: P(N>k) = ρ^(k+1), não ρ^k
%  ✗ Ex5: N̄_q só conta quem ESPERA (n-1 para n≥1), não N̄
%  ✗ Geral: ρ<1 obrigatório para M/M/1 infinito