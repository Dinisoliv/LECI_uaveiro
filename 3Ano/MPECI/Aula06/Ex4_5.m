% =========================================================
%  Exercício 4 — Disponibilidade de servidor VM
%  Exercício 5 — Estratégia de backup num Data Center
%  Métodos Probabilísticos para Engenharia de
%  Computadores e Informática 2025/2026
% =========================================================

clear; clc;

% =========================================================
%  EXERCÍCIO 4
% =========================================================
%
%  Modelo: Cadeia de Markov em Tempo Contínuo com 4 estados
%
%  Estado 1 — Disponível (tudo a funcionar)
%  Estado 2 — Reparação de falha de hardware
%  Estado 3 — Reparação de falha de hypervisor
%  Estado 4 — Reparação de falha de VM
%
%  Todos os valores em dias^-1 (1 ano = 365 dias)
% ---------------------------------------------------------

%  Taxas de falha (estado 1 -> estado i)
lf_hw  = 1 / (2 * 365);   % MTBF hardware  = 2 anos = 730 dias
lf_hyp = 1 / 180;          % MTBF hypervisor = 180 dias
lf_vm  = 1 / 90;           % MTBF VM         = 90 dias

%  Taxas de reparação (estado i -> estado 1)
mr_hw  = 1 / 2;            % MTTR hardware   = 2 dias
mr_hyp = 1 / (6/24);       % MTTR hypervisor = 6 h = 6/24 dias  -> 4 dias^-1
mr_vm  = 1 / (1/24);       % MTTR VM         = 1 h = 1/24 dias  -> 24 dias^-1

% ---------------------------------------------------------
%  PARTE (a) — Matriz de taxas de transição Q (dias^-1)
%
%  Convenção: Q(i,j) = taxa de transição do estado i para j
%  Diagonal:  Q(i,i) = -(soma das taxas de saída do estado i)
%
%  Do guia, a matriz é apresentada como:
%       0       0    4.0000  24.0000
%  0.0014       0       0       0
%  0.0056  0.5000       0       0
%  0.0111       0       0       0
%  Esta é a TRANSPOSTA da nossa Q — convenção pi*Q = 0.
% ---------------------------------------------------------

Q = zeros(4, 4);

%  Transições a partir do estado 1 (disponível)
Q(1, 2) = lf_hw;    % 1 -> 2: falha hardware
Q(1, 3) = lf_hyp;   % 1 -> 3: falha hypervisor
Q(1, 4) = lf_vm;    % 1 -> 4: falha VM

%  Transições de retorno ao estado 1 (reparações)
Q(2, 1) = mr_hw;    % 2 -> 1: reparação hardware
Q(3, 1) = mr_hyp;   % 3 -> 1: reparação hypervisor (inclui recuperação VM)
Q(4, 1) = mr_vm;    % 4 -> 1: reparação VM

%  Diagonal: taxa de saída negativa
for i = 1:4
    Q(i, i) = -sum(Q(i, :)) + Q(i, i);
end

fprintf('=== Exercício 4(a) — Matriz de taxas de transição (dias^-1) ===\n');
disp(Q);

% ---------------------------------------------------------
%  PARTE (b) — Distribuição estacionária e disponibilidade
%
%  Resolver pi * Q = 0  com  sum(pi) = 1
%  Equivalente a: Q^T * pi^T = 0  com substituição da última linha
% ---------------------------------------------------------

A_sys = Q';              % transposta para resolver sistema linear
A_sys(end, :) = 1;       % substituir última linha pela condição de normalização
b = zeros(4, 1);
b(end) = 1;

pi = A_sys \ b;          % resolver sistema linear

availability = pi(1);    % estado 1 = disponível

fprintf('=== Exercício 4(b) — Disponibilidade ===\n');
fprintf('  Probabilidades estacionárias:\n');
for i = 1:4
    fprintf('    pi(%d) = %.6f\n', i, pi(i));
end
fprintf('  Disponibilidade do servidor = %.3f%%\n\n', availability * 100);

% ---------------------------------------------------------
%  PARTE (c) — MTBF e MTTR
%
%  Taxa total de falha a partir do estado 1:
%    lambda_total = lf_hw + lf_hyp + lf_vm
%    MTBF = 1 / lambda_total
%
%  MTTR derivado da disponibilidade:
%    A = MTBF / (MTBF + MTTR)
%    => MTTR = MTBF * (1 - A) / A
% ---------------------------------------------------------

lambda_total = lf_hw + lf_hyp + lf_vm;
MTBF_days    = 1 / lambda_total;
MTTR_days    = MTBF_days * (1 - availability) / availability;
MTTR_hours   = MTTR_days * 24;

fprintf('=== Exercício 4(c) — MTBF e MTTR ===\n');
fprintf('  MTBF = %.2f dias\n',  MTBF_days);
fprintf('  MTTR = %.2f horas\n', MTTR_hours);
fprintf('  Verificação: A = MTBF/(MTBF+MTTR) = %.3f%%\n\n', ...
        MTBF_days / (MTBF_days + MTTR_days) * 100);

% =========================================================
%  EXERCÍCIO 5
% =========================================================
%
%  Modelo: 1 servidor backup dedicado a n servidores primários.
%  Cada servidor VM tem disponibilidade individual A_vm = 99.9%.
%
%  Disponibilidade de uma VM com backup partilhado:
%    A_group(n) = A_vm + (1-A_vm) * A_vm^n
%
%  Interpretação:
%    - A_vm: primário está up (disponível directamente)
%    - (1-A_vm) * A_vm^n: primário está down, MAS o backup
%      está up (prob A_vm) E não está ocupado com outro
%      dos n-1 primários (prob A_vm^(n-1))
%    => (1-A_vm) * A_vm * A_vm^(n-1) = (1-A_vm) * A_vm^n
% ---------------------------------------------------------

A_vm = 0.999;       % disponibilidade individual de cada VM
target = 0.9999;    % requisito: >= 99.99%

% ---------------------------------------------------------
%  PARTE (a) — Máximo n tal que A_group >= 99.99%
% ---------------------------------------------------------

n_max = 1;
while true
    A_group = A_vm + (1 - A_vm) * A_vm^(n_max + 1);
    if A_group < target
        break;
    end
    n_max = n_max + 1;
end

A_result = A_vm + (1 - A_vm) * A_vm^n_max;

fprintf('=== Exercício 5(a) ===\n');
fprintf('  Máximo valor de n = %d\n', n_max);
fprintf('  Disponibilidade resultante = %.4f%%\n\n', A_result * 100);

% ---------------------------------------------------------
%  PARTE (b) — Gráfico de A_group para n = 1 a 1000
% ---------------------------------------------------------

n_range = 1:1000;
A_range = A_vm + (1 - A_vm) * A_vm .^ n_range;

figure;
plot(n_range, A_range * 100, 'b-', 'LineWidth', 1.5);
xlabel('n (número de servidores primários)');
ylabel('Disponibilidade da VM (%)');
title('Disponibilidade da VM em função do número de primários');
grid on;
yline(99.99, 'r--', '99.99%', 'LabelHorizontalAlignment', 'left');

% ---------------------------------------------------------
%  CONCLUSÕES
%
%  Exercício 4:
%    - A disponibilidade de 99.5% é dominada pelas falhas
%      de hardware (MTBF 730 dias mas MTTR 2 dias = longo).
%    - O MTTR de ~6.5h reflecte que a maioria das falhas
%      são de hypervisor/VM (MTTR de horas), não de hardware.
%
%  Exercício 5:
%    - Com backup, a disponibilidade melhora significativamente
%      para n pequeno (backup quase sempre livre).
%    - Para n grande, o backup está frequentemente ocupado,
%      degradando a disponibilidade efectiva.
%    - Há um trade-off claro entre custo (1 backup para muitos)
%      e disponibilidade efectiva.
% ---------------------------------------------------------