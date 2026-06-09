% =========================================================
%  Exercício 3 — M/M/m: Call Center com m operadores
%  Métodos Probabilísticos para Engenharia de
%  Computadores e Informática 2025/2026
% =========================================================
%
%  Modelo: M/M/m
%    - m servidores (operadores) em paralelo
%    - Fila de espera INFINITA (ninguém é rejeitado)
%    - Tempo de serviço: exponencial com média 3 minutos
%    - Taxa de chegadas: lambda (pedidos/hora)
%
%  Parâmetros chave:
%    mu  = 1/3 min^-1 = 20 pedidos/hora por operador
%    rho = lambda / (m * mu)  →  utilização por operador (< 1 para estabilidade)
%    a   = lambda / mu        →  carga total oferecida (Erlangs)
% =========================================================

clear; clc;

mu_min = 1/3;            % taxa de serviço por operador [pedidos/min]
mu     = mu_min * 60;    % converter para [pedidos/hora]  = 20

% ---------------------------------------------------------
%  FUNÇÃO AUXILIAR — Erlang-C e métricas do M/M/m
%
%  Inputs:
%    lam  — taxa de chegadas [pedidos/hora]
%    mu   — taxa de serviço por operador [pedidos/hora]
%    m    — número de operadores
%
%  Outputs:
%    C    — P(esperar) = probabilidade de todos ocupados (Erlang-C)
%    Wq   — tempo médio de espera na fila [horas]
%
%  Fórmulas:
%    rho  = lambda / (m * mu)          [utilização por operador]
%    a    = lambda / mu                [carga total em Erlangs]
%
%    p0 = 1 / [ sum_{n=0}^{m-1} a^n/n! + a^m/(m!*(1-rho)) ]
%
%    C(m,a) = p0 * a^m / (m! * (1-rho))   [Erlang-C]
%
%    Wq = C / (m*mu - lambda)              [tempo espera, horas]
% ---------------------------------------------------------
function [C, Wq] = mmm_metrics(lam, mu, m)
    rho = lam / (m * mu);
    if rho >= 1
        C = NaN; Wq = NaN;
        return;
    end
    a = lam / mu;

    % Normalização p0
    soma_finita = sum(a.^(0:m-1) ./ factorial(0:m-1));
    soma_fila   = a^m / (factorial(m) * (1 - rho));
    p0 = 1 / (soma_finita + soma_fila);

    % Erlang-C: P(todos m operadores ocupados)
    C  = p0 * soma_fila;

    % Tempo médio de espera na fila [horas]
    Wq = C / (m * mu - lam);
end

% ---------------------------------------------------------
%  PARTE (a) — lambda = 370, m = 20
% ---------------------------------------------------------
lambda = 370;
m      = 20;

[C_a, Wq_a] = mmm_metrics(lambda, mu, m);
Wq_sec_a    = Wq_a * 3600;    % converter horas → segundos

fprintf('=== Parte (a): lambda = %d, m = %d ===\n', lambda, m);
fprintf('  rho (utilizacao/operador) = %.4f\n',  lambda/(m*mu));
fprintf('  P(todos ocupados)         = %.3f%%\n', C_a * 100);
fprintf('  Tempo medio de espera     = %.3f segundos\n\n', Wq_sec_a);

% ---------------------------------------------------------
%  PARTE (b) — mínimo m tal que Wq <= 10 segundos
% ---------------------------------------------------------
target_Wq_sec = 10;           % 10 segundos = 10/3600 horas
m_min = m + 1;                % começa a procurar acima de 20

while true
    [C_b, Wq_b] = mmm_metrics(lambda, mu, m_min);
    if ~isnan(Wq_b) && Wq_b * 3600 <= target_Wq_sec
        break;
    end
    m_min = m_min + 1;
end

fprintf('=== Parte (b): minimo m para Wq <= 10 segundos ===\n');
fprintf('  Minimo numero de operadores = %d\n',    m_min);
fprintf('  P(todos ocupados)           = %.3f%%\n', C_b * 100);
fprintf('  Tempo medio de espera       = %.3f segundos\n\n', Wq_b * 3600);

% ---------------------------------------------------------
%  PARTE (c) — variar lambda = 320:10:380, m = 20 fixo
%
%  Conclusão esperada: o tempo de espera cresce de forma
%  muito acentuada quando lambda se aproxima de m*mu=400.
%  Perto da saturação (rho→1), Wq → ∞.
% ---------------------------------------------------------
lambda_vec  = 320:10:380;
Wq_min_vec  = zeros(size(lambda_vec));

fprintf('=== Parte (c): Wq para m = 20, variando lambda ===\n');
fprintf('%8s  %12s  %10s\n', 'lambda', 'rho', 'Wq (min)');
for i = 1:length(lambda_vec)
    lam_i = lambda_vec(i);
    [~, Wq_i] = mmm_metrics(lam_i, mu, 20);
    Wq_min_vec(i) = Wq_i * 60;    % horas → minutos
    fprintf('%8d  %12.4f  %10.4f\n', lam_i, lam_i/(20*mu), Wq_min_vec(i));
end

figure;
bar(lambda_vec, Wq_min_vec, 'FaceColor', [0.22 0.47 0.73]);
xlabel('Taxa de chegadas \lambda (pedidos/hora)');
ylabel('Tempo medio de espera (minutos)');
title('M/M/20: tempo de espera vs taxa de chegadas');
grid on;

% ---------------------------------------------------------
%  CONCLUSÕES
%
%  Parte (a): com 20 operadores e lambda=370,
%    rho=0.925 → sistema muito carregado.
%    64.8% dos clientes têm de esperar.
%    Tempo médio de espera = 78 segundos (>1 min).
%
%  Parte (b): precisamos de 23 operadores para baixar
%    o tempo de espera para ≤10 segundos.
%    Com 3 operadores a mais, Wq cai de 78s para 9.4s.
%
%  Parte (c): o tempo de espera cresce EXPONENCIALMENTE
%    à medida que lambda → m*mu = 400 (saturação).
%    Para lambda=380 (rho=0.95), Wq≈2.3 min.
%    Para lambda=320 (rho=0.80), Wq≈0.19 min.
%    Este comportamento não-linear é característico do M/M/m:
%    pequenas variações na carga perto da saturação têm
%    impacto enorme no desempenho.
% ---------------------------------------------------------