clear
%% %  POISSON PROCESS  %%%
%% Parameters
M = 1000;       % number of iterations
n = 1000;       % number of vector (time splits) but number of process jumpes is different
lambda = 2;     % parametr of Ti = Exp(lambda) [times of waiting] 
T = 10;         % time horizon
t = linspace(0, T, n);

%% Example of one realization
subplot(1, 3, 1)
stairs(t, proces_Poissona(lambda, T, n, 1), 'k')
title('An example of the Poisson process')
xlabel('t')
ylabel('N(t)')

%% N realizations
Nt = proces_Poissona(lambda, T, n, M);
subplot(1, 3, 2)
hold on;
plot(t, mean(Nt), 'r');
plot(t, lambda * t, 'k');
plot(t, var(Nt), 'b');
title('Mean and variance')
legend('mean of the data', 'theoretical mean and variance', 'variance from the data')
xlabel('t')

%% Distribution
Ntn = Nt(:,end);
% Distributor
[F_e, xe] = ecdf(Ntn);
F_th = poisscdf(xe, lambda * T);
subplot(2, 3, 3)
hold on;
plot(xe, F_e, 'k')
plot(xe, F_th, 'r')
title('Distributor')
legend('empirical','theoretical')
xlabel('t')
ylabel('F(t)')

% Normalized histogram compared to the theoretical distribution
f_th = poisspdf(xe, lambda * T);
subplot(2, 3, 6)
hold on;
plot(xe, f_th, 'r', 'LineWidth', 1.5)
histogram(Ntn, 'Normalization', 'pdf', 'Facecolor', 'k')
title('Theoretical density compared to the histogram')
legend('density')
xlabel('t')
ylabel('f(t)')

%% Function
function y = proces_Poissona(lambda, T, n, M)
    % The program generates M trajectory of the poisson counting process N(t)
    ti = 0: T/n : T-T/n;
    y = [];
    for i = 1:M
        N = zeros(1,n);     % trajectory
        I = 0;
        t = - 1/lambda * log(rand); % Exp(lambda) reverse cumulative distribution method
        while t <= T % time horizon
            I = I + 1; % number of jumps
            N( ti > t) = I;
            t = t - 1/lambda * log(rand); 
        end
        y = [y ; N];
    end
end


