%% MPECI_teste.m — CHEATSHEET ULTRA-COMPACTO (comentários apenas)
% ============================================================
% SÍMBOLOS E UNIDADES
% ============================================================
% λ  — taxa chegadas       [pedidos/min | pps]
% μ  — taxa serviço        [1/min | pps]
% ρ  — intensidade tráfego = λ/μ            [adimensional]
% M  — capacidade servidor (filmes/servidores)
% F  — capacidade fila (pacotes)             m=F+1 (total)
% B  — débito/tamanho      [Mbps | Bytes]
% C  — capacidade ligação  [Mbps]
% N  — critério paragem    [eventos]
% AM — atraso médio        [s → *1000 → ms]
% PB — prob. bloqueio      [%] = 100*BLOCKED/N_ARRIVALS
% PD — prob. descarte      [%] = 100*DROPPED/N_ARRIVALS
% DB — débito médio        [Mbps] = LOAD/Clock
%
% CONVERSÃO TEMPO TRANSMISSÃO:
%   tTime = 8 * pkt_bytes / (C * 1e6)       [segundos]
%
% TAXA DE SERVIÇO LIGAÇÃO:
%   mu = C*1e6 / (8*B_avg)                  [pps]
%
% ============================================================
% TABELA DE DECISÃO — KEYWORDS → MODELO
% ============================================================
% "filmes","servidor","transmissão simultânea","sem fila","bloqueio"
%   → M/M/m/m (Erlang-B)    Simulator: VideoStreamingSimulator
%   → EventList: [tipo, tempo]   3 colunas NÃO necessárias
%
% "pacotes","router","fila F","FIFO","atraso","descarte"
%   → M/M/1/F (fila finita)  Simulator: LinkSimulator / LinkSimulatorDP
%   → EventList: [tipo, tempo, chegada]   3 colunas OBRIGATÓRIAS
%
% "tamanho exponencial"   → exprnd(B) dentro do simulator
% "tamanho discreto"      → x_sizes(sum(rand()>f_cum)) dentro do simulator
% "duração discreta"      → x(sum(rand()>f_cum))       idem
%
% ============================================================
% FÓRMULAS — GERAÇÃO ALEATÓRIA
% ============================================================
% Exponencial (média=1/λ): X = -1/λ * ln(U),  U~U(0,1)
%   MATLAB: exprnd(1/lambda)   ← argumento é MÉDIA não taxa
%
% Discreta:  f_cum=[0,cumsum(f)];  x(sum(rand()>f_cum))
%   Média:   sum(x.*f)
%
% Uniforme(a,b): X = (b-a)*rand() + a
%
% Rejeição:  X~U(a,b); Y~U(0,c); aceitar X se Y<=f(X)
%
% ============================================================
% FÓRMULAS — M/M/m/m (ERLANG-B) — video-streaming
% ============================================================
% ρ = λ/μ  (Erlangs)
% P(n) = (ρ^n/n!) / sum_{k=0}^{M}(ρ^k/k!)
% PB   = P(M)
% DB   = B * ρ * (1 - PB)               [Mbps]
%
% MATLAB TEÓRICO:
%   rho=lambda/mu; n_=0:M;
%   log_u=n_*log(rho)-cumsum([0,log(1:M)]);
%   log_u=log_u-max(log_u);
%   P=exp(log_u)/sum(exp(log_u));
%   PB_th=P(end); DB_th=B*sum(n_.*P);
%
% ============================================================
% FÓRMULAS — M/M/1/m (FILA FINITA) — ligação dados
% ============================================================
% μ=C*1e6/(8*B_avg);  ρ=λ/μ;  m=F+1
% P(n) = (1-ρ)*ρ^n / (1-ρ^{m+1}),  n=0..m   [ρ≠1]
% P(n) = 1/(m+1)                             [ρ=1]
% PD   = P(m)
% E[N] = sum(n.*P)  OU  ρ/(1-ρ) - (m+1)*ρ^{m+1}/(1-ρ^{m+1})
% λ_eff= λ*(1-PD)
% AM   = E[N]/λ_eff                          [segundos]
%
% MATLAB TEÓRICO:
%   mu=C*1e6/(8*B_avg); rho=lambda/mu; m=F+1; n_=0:m;
%   if abs(rho-1)>1e-10; P=(1-rho)*rho.^n_/(1-rho^(m+1));
%   else; P=ones(1,m+1)/(m+1); end
%   PD_th=P(end); EN=sum(n_.*P);
%   AM_th=EN/(lambda*(1-PD_th));            % segundos → *1000 para ms
%
% LEI DE LITTLE: E[N] = λ_eff * AM
%
% ============================================================
% FÓRMULAS — INTERVALOS DE CONFIANÇA
% ============================================================
% IC 100*(1-α)% usando t-Student (σ desconhecido):
%   [~,~,ci]=ttest(X, mean(X), 'alpha', alfa)
%   alfa=0.10 → IC 90%    alfa=0.05 → IC 95%
%
% Largura IC ∝ std(X)/sqrt(Nsim)
%   4x mais runs → IC metade da largura
%   √10 ≈ 3.16 → razão larguras entre 10 e 100 runs
%
% ============================================================
% CONTADORES ESTATÍSTICOS — RESUMO RÁPIDO
% ============================================================
% VideoStreaming:
%   LOAD += B*STATE*(Clock-PrevClock)   ← ANTES do switch!
%   PB   = 100*BLOCKED/N_ARRIVALS
%   DB   = LOAD/Clock
%
% LinkSimulator:
%   DELAYS += Clock - ArrInstant        ← no DEPARTURE
%   AM     = DELAYS/TRANSMITTED         ← segundos
%   PD     = 100*DROPPED/N_ARRIVALS
%
% EventList LinkSim: [tipo, tempo_evento, tempo_chegada]
%   ARRIVAL  inserido como: [ARRIVAL,  tmp, tmp]
%   DEPARTURE inserido como: [DEPARTURE, Clock+tTime, ArrInstant]
%
% ============================================================
% FUNÇÕES MATLAB — REFERÊNCIA RÁPIDA
% ============================================================
% exprnd(media)             gerar exponencial (média=argumento)
% rand()                    U(0,1)
% sortrows(M,col)           ordenar matriz por coluna
% cumsum(f)                 CDF sem o 0 inicial
% [0,cumsum(f)]             CDF com 0 inicial (usar este!)
% sum(x.*f)                 média de variável discreta
% unique(v)                 valores únicos de vector
% mean(X)                   média amostral
% std(X)                    desvio padrão amostral
% [~,~,ci]=ttest(X,m,'alpha',a)   IC bilateral
% bar(x,y)                  gráfico de barras
% errorbar(x,y,neg,pos,'k','LineStyle','none')  barras de erro
% set(gca,'XTick',p,'XTickLabel',labels)        labels no eixo x
%
% ============================================================
% SCRIPT IC GENÉRICO (copiar/colar)
% ============================================================
% Nsim=100; alfa=0.1; res=zeros(1,Nsim);
% for it=1:Nsim; res(it)=MinhaFuncao(params); end
% m=mean(res); [~,~,ci]=ttest(res,m,'alpha',alfa);
% fprintf('X = %.4f [%.4f - %.4f]\n', m, ci(1), ci(2));
%
% ============================================================
% SCRIPT DISTRIBUIÇÃO DISCRETA (copiar/colar)
% ============================================================
% x=64:1500; n_o=length(x)-3;
% p_o=(1-0.29606-0.16417-0.19601)/n_o;
% f=ones(1,length(x))*p_o;
% f(x==64)=0.29606; f(x==110)=0.16417; f(x==1500)=0.19601;
% avg=sum(x.*f);                    % media
% fc=[0,cumsum(f)];                 % CDF (pré-calcular FORA do loop)
% pkt=x(sum(rand()>fc));            % 1 amostra (DENTRO do loop)
%
% ============================================================
% SCRIPT BAR CHART COM ERROR BARS (copiar/colar)
% ============================================================
% err_low = means - ci_low;   err_high = ci_high - means;
% figure; b=bar(x_pos,means); b.FaceColor=[0.2,0.4,0.8];
% hold on;
% errorbar(x_pos,means,err_low,err_high,'k','LineStyle','none',...
%          'LineWidth',1.5,'CapSize',8);
% set(gca,'XTick',x_pos,'XTickLabel',labels);
% xlabel('...'); ylabel('...'); grid on; hold off;
%
% ============================================================
% MÍNIMOS / MÁXIMOS RELEVANTES
% ============================================================
% AM mínimo → F pequeno (fila curta limita espera; mas PD sobe)
% AM máximo → F grande + ρ→1 (fila longa + saturação)
% PD mínimo → F grande (buffer absorve bursts)
% PD máximo → F pequeno + ρ alto
% IC mais estreito → Nsim↑ ou N↑ ou sistema estável (ρ baixo, F pequeno)
% IC mais largo    → Nsim↓ ou N↓ ou sistema instável (ρ→1, F intermédio)
%
% ============================================================
% ERROS COMUNS (top 5)
% ============================================================
% 1. exprnd(lambda)   em vez de   exprnd(1/lambda)
% 2. tTime=B/(C*1e6)  em vez de  tTime=8*B/(C*1e6)  [esquecer *8]
% 3. AM em segundos sem *1000 para ms no fprintf
% 4. LOAD após switch em vez de ANTES (usa STATE já actualizado)
% 5. f_cum=cumsum(f)  em vez de  f_cum=[0,cumsum(f)]  (falta o 0)
%
% ============================================================
% VALORES DE REFERÊNCIA DOS EXERCÍCIOS
% ============================================================
% Ex2:  λ=2,inv=90,B=2,M=200,N=1e4
%       10runs:  PB=1.147[0.935-1.360]%  DB=348.94[346.68-351.20]Mbps
%       100runs: PB=0.948[0.885-1.011]%  DB=350.53[349.89-351.17]Mbps
% Ex3:  D=100.39 min (média discreta filmes)
% Ex4:  λ=2,B=2,M=200,N=1e5,20runs,discreta
%       PB=5.668[5.573-5.764]%  DB=378.51[378.31-378.71]Mbps
% Ex5:  PB_th=5.669%  DB_th=378.81Mbps
% Ex6:  λ=1000,B=600,C=10,F=1000,N=1e4,100runs
%       AM=0.9231[0.9191-0.9271]ms
% Ex7:  AvgPkt=600.003B  AM=0.9190[0.9152-0.9228]ms
% Ex8:  λ=2000→AM≈12ms(IC largo!)
% Ex10: λ=1800,F=100→AM=3.56ms PD≈0%
% Ex11: F=5→AM=1.52ms PD=8.97%  (trade-off!)
% Ex13: F=5→AM_th=1.478ms PD_th=8.832%  (≈simulação ✓)
%
% FIM MPECI_teste.m