% =====================================================
%  MPECI 2025/2026 — TESTE GUIA 4  (cheatsheet)
% =====================================================


% ─────────────────────────────────────────────────
%  QUAL MODELO?
% ─────────────────────────────────────────────────
%  BER states, frame error prob      → Markov BER
%  HW+SW encadeado, downtime         → Markov dependente
%  N servers + t technicians         → Birth-death
%  M/M/1, fila infinita              → fórmulas fechadas
%  M/M/1/m, clientes descartados     → mm1k com K=m


% ─────────────────────────────────────────────────
%  MARKOV GERAL — resolver π
% ─────────────────────────────────────────────────
%  A=Q'; A(end,:)=1; b=zeros(n,1); b(end)=1; pi=A\b
%  Q(i,i) = -(soma das saídas da linha i)
%  Verificação: sum(Q,2) = zeros


% ─────────────────────────────────────────────────
%  MARKOV BER  (ex1)
% ─────────────────────────────────────────────────
%  Holding time estado i [h]:   h_i = 1/|Q(i,i)|  → ×60 min
%  P(frame L bytes com erro):   Σ_i π_i·(1-(1-BER_i)^(L*8))
%  P(frame L bytes sem erro):   Σ_i π_i·(1-BER_i)^(L*8)
%  Bayes P(BER_i|erro):         P(erro|BER_i)·π_i / P(erro)
%  ⚠ L bytes → L*8 bits


% ─────────────────────────────────────────────────
%  MARKOV DEPENDENTE HW+SW  (ex2)
% ─────────────────────────────────────────────────
%  Estados: 1=ok  2=rep.HW  3=rep.SW
%  1→2: λ_hw=1/MTBF_hw    1→3: λ_sw=1/MTBF_sw
%  2→3: μ_hw=1/MTTR_hw    3→1: μ_sw=1/MTTR_sw
%  ⚠ 2→3 (não 2→1!)  HW repair ainda precisa de SW repair
%  Disponibilidade = π(1)
%  Downtime [h] = (1-π(1)) · T_dias · 24

function [pi,av] = markov_hw_sw(lf_hw,lf_sw,mr_hw,mr_sw)
    Q=zeros(3); Q(1,2)=lf_hw; Q(1,3)=lf_sw;
    Q(2,3)=mr_hw; Q(3,1)=mr_sw;
    for i=1:3; Q(i,i)=-sum(Q(i,:)); end
    A=Q'; A(end,:)=1; b=zeros(3,1); b(end)=1;
    pi=A\b; av=pi(1);
end
%  Ex2: lf_hw=1/500, lf_sw=1/90, mr_hw=1, mr_sw=6
%  → av=99.58%, downtime 30d = 3.0h


% ─────────────────────────────────────────────────
%  BIRTH-DEATH N SERVIDORES  (ex3)
% ─────────────────────────────────────────────────
%  Estado n = nº avariados  (0..N)
%  λ_n = (N-n)·λ_f    μ_n = min(n,t)·μ_r
%  p_n = p_{n-1} · λ_{n-1}/μ_n    p normalizado
%  N̄_down  = Σ n·p_n
%  N̄_techs = Σ min(n,t)·p_n
%  P(≥k up) = Σ_{n=0}^{N-k} p_n

function p = bd_servers(N,t,lf,mr)
    p=ones(N+1,1);
    for n=1:N; p(n+1)=p(n)*(N-n+1)*lf/(min(n,t)*mr); end
    p=p/sum(p);
end
%  Ex3: N=100, lf=1/200, mr=24/36
%  t=1: N̄↓=2.51, P(≥90up)=98.1%
%  t=2: N̄↓=0.86, P(≥90up)=99.998%
%  t=3: N̄↓=0.76, P(≥90up)≈100%  (3º técnico quase ocioso)


% ─────────────────────────────────────────────────
%  M/M/1  fórmulas fechadas  (ex4)
% ─────────────────────────────────────────────────
%  ρ=λ/μ < 1
%  W̄  = 1/(μ-λ)          tempo no sistema
%  W̄_q = ρ/(μ-λ)         tempo na fila
%  N̄  = ρ/(1-ρ)
%  N̄_q = ρ²/(1-ρ)
%  P(N>k) = ρ^(k+1)       ← expoente é k+1, não k
%  Ex4: λ=8,μ=10 → W̄=0.5min, ρ=80%, N̄_q=3.2
%  P(Nq>6)=0.8^7=21%  P(Nq>20)=0.8^21=0.92%


% ─────────────────────────────────────────────────
%  M/M/1/m  (ex5) — igual M/M/1/K com K=m
% ─────────────────────────────────────────────────
%  p_0=(1-ρ)/(1-ρ^(m+1))   p_n=p_0·ρ^n
%  P_discard = p_m
%  N̄_q = Σ_{n=1}^{m} (n-1)·p_n
%  W̄ = N̄/(λ·(1-P_discard))  → ×1000 para ms

function [Pd,Wms,Nq]=mm1m_f(lam,mu,m)
    rho=lam/mu; p0=(1-rho)/(1-rho^(m+1));
    p=p0*rho.^(0:m); Pd=p(end);
    Nq=sum(max((0:m)-1,0).*p);
    Wms=sum((0:m).*p)/(lam*(1-Pd))*1000;
end
%  Ex5: λ=80,μ=100,m=10 → Pd=2.35%, W=37.97ms, Nq=2.19


% ─────────────────────────────────────────────────
%  ERROS COMUNS
% ─────────────────────────────────────────────────
%  ✗ BER: esquecer ×8 (bytes→bits)
%  ✗ Ex2: Q(2,1) em vez de Q(2,3)  (HW vai para SW, não para ok)
%  ✗ Ex3: n·mr em vez de min(n,t)·mr
%  ✗ M/M/1: P(N>k) = ρ^(k+1) não ρ^k
%  ✗ M/M/1 infinito: verificar ρ<1 antes de calcular