% =====================================================
%  MPECI 2025/2026 — NOTAS DE TESTE
% =====================================================


% ─────────────────────────────────────────────────
%  SÍMBOLOS
% ─────────────────────────────────────────────────
%  λ  chegadas/s       μ  serviço/s (= 1/T_serv)
%  ρ  = λ/μ            K  capacidade total
%  m  nº servidores    a  = λ/μ  [Erlangs]
%  p_n  P(n no sistema)   p_0  P(sistema vazio)
%  N̄  nº médio          W̄  tempo médio


% ─────────────────────────────────────────────────
%  LEI DE LITTLE  (sempre válida)
% ─────────────────────────────────────────────────
%  N̄ = λ_eff · W̄        λ_eff = λ·(1 - P_loss)
%  W̄ = N̄ / λ_eff        W̄_q  = W̄ - 1/μ


% ─────────────────────────────────────────────────
%  COMO CONVERTER UNIDADES
% ─────────────────────────────────────────────────
%  Mbps + Bytes  →  λ = throughput_bps / (Bytes·8)
%                   μ = capacidade_bps  / (Bytes·8)
%  "N req em T µs" →  μ_total = N / T   (ex: 250/200e-6)
%  min⁻¹ → /hora  →  × 60


% ─────────────────────────────────────────────────
%  QUAL MODELO USAR?
% ─────────────────────────────────────────────────
%  "queue Q", packet loss, Mbps+Bytes  →  M/M/1/K
%  "limit B simultaneous", blocking    →  M/M/1/B  (= M/M/1/K com K=B)
%  "m operators", queuing time         →  M/M/m
%  MTBF/MTTR, múltiplas falhas         →  Markov
%  "n primários + 1 backup"            →  Backup


% =====================================================
%  M/M/1/K  e  M/M/1/B
% =====================================================
%  p_0 = (1-ρ) / (1-ρ^(K+1))
%  p_n = p_0 · ρ^n          n = 0..K
%  P_loss = p_K
%  N̄  = Σ n·p_n
%  W̄  = N̄ / (λ·(1-P_loss))    [s]  →  ×1e3 para ms

function [Ploss, Wavg] = mm1k(lam, mu, K)
    rho   = lam/mu;
    p0    = (1-rho)/(1-rho^(K+1));
    p     = p0 * rho.^(0:K);
    Ploss = p(end);
    Wavg  = sum((0:K).*p) / (lam*(1-Ploss));
end

%  M/M/1/B  →  mm1k(lam, mu, B)
%
%  Encontrar K mínimo (P_loss ≤ alvo):
%    K=1; while mm1k(lam,mu,K) > alvo; K=K+1; end
%
%  ⚠  M/M/1/K: K = 1+Q    M/M/1/B: K = B


% =====================================================
%  M/M/m  (Erlang-C)
% =====================================================
%  ρ = λ/(m·μ)   < 1 obrigatório
%  a = λ/μ
%
%  p_0 = 1 / [ Σ_{n=0}^{m-1} a^n/n!  +  a^m/(m!·(1-ρ)) ]
%
%  C = p_0 · a^m / (m!·(1-ρ))   ← Erlang-C = P(esperar)
%
%  W̄_q = C / (m·μ - λ)          [mesmas unidades de λ,μ]

function [C, Wq] = mmm(lam, mu, m)
    rho = lam/(m*mu);
    a   = lam/mu;
    sf  = a^m / (factorial(m)*(1-rho));
    p0  = 1 / (sum(a.^(0:m-1)./factorial(0:m-1)) + sf);
    C   = p0*sf;
    Wq  = C/(m*mu - lam);
end

%  Encontrar m mínimo (Wq ≤ alvo em segundos):
%    m=1; while mmm(lam,mu,m)*3600 > alvo_s; m=m+1; end
%  (multiplica por 3600 se λ,μ em /hora)


% =====================================================
%  MARKOV — DISPONIBILIDADE
% =====================================================
%  Estados: 1=ok, 2=rep.hw, 3=rep.hyp, 4=rep.vm
%  Q(i,j) = taxa i→j     Q(i,i) = -(soma saídas de i)
%  Falha 1→i: λ_i = 1/MTBF_i   Reparação i→1: μ_i = 1/MTTR_i
%
%  Resolver π·Q=0, Σπ=1:
%    A=Q'; A(end,:)=1; b=zeros(n,1); b(end)=1;
%    pi = A\b;
%
%  Disponibilidade = pi(1)
%  MTBF = 1/sum(Q(1,2:end))          [dias]
%  MTTR = MTBF*(1-pi(1))/pi(1)*24    [horas]
%
%  ⚠ Unidades todas em dias⁻¹:
%     2 anos → 1/730    6h → 1/(6/24)=4    1h → 24


% =====================================================
%  BACKUP — DATA CENTER
% =====================================================
%  n primários + 1 backup, cada VM com disponib. A_vm
%
%  A_group(n) = A_vm + (1-A_vm)·A_vm^n
%
%  Encontrar n máximo (A_group ≥ alvo):
%    n=1; while A_vm+(1-A_vm)*A_vm^(n+1) >= alvo; n=n+1; end
%
%  Gráfico n=1:1000:
%    n=1:1000; plot(n, A_vm+(1-A_vm)*A_vm.^n)


% =====================================================
%  ERROS COMUNS
% =====================================================
%  ✗  Usar λ em vez de λ_eff na Lei de Little
%  ✗  K = Q  em vez de  K = 1+Q  no M/M/1/K
%  ✗  ρ = λ/μ  em vez de  ρ = λ/(m·μ)  no M/M/m
%  ✗  Misturar unidades (λ em /s, μ em /hora)
%  ✗  Esquecer ×3600 ao converter Wq de horas para segundos