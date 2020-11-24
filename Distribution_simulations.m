clear
%% Expotencial distribution generation
lambda = 5;
N = 10000;
X = Exponential_distribution(lambda, N);
% Mean and Variance     % for N = 10000
char_info('Expotencial',1 / lambda, mean(X),1 / lambda^2, var(X))
% Drawing
x = linspace(min(X), max(X), N);
[F_emp, xe] = ecdf(X);
F_th = 1 - exp(-lambda * xe);
f_th = lambda * exp(-lambda * x);
draw_distribution(X, F_th, f_th, F_emp, xe, x, 'Expotencial')

%% Erlang distribution generation
n = 10;
lambda = 5;
N = 10000;
X = Erlang_distribution(n, lambda, N);
% Mean and Variance   
char_info('Erlang', n / lambda, mean(X), n / lambda^2, var(X))
% Drawing
[F_emp, xe] = ecdf(X);
F_th = gamcdf(xe, n, 1/lambda) ;
x = linspace(min(X), max(X), N);
f_th = gampdf(x ,n, 1/lambda);
draw_distribution(X, F_th, f_th, F_emp, xe, x, 'Erlang')

%% Beta distribution generation
N = 10000;
X = Beta_distribution(N);
% Mean and Variance   
char_info('Beta', 1/3, mean(X), 8 / (6^2 * 7), var(X))
% Drawing
[F_emp, xe] = ecdf(X);
F_th = xe.^2 .* (-4*xe.^3 + 15* xe.^2 - 20*xe + 10) ;
x = linspace(min(X), max(X), N);
f_th = 20 .* x .* (1-x).^3;
draw_distribution(X, F_th, f_th, F_emp, xe, x, 'Beta')

%% Power distribution generation
p = 4;
N = 10000;
X = Power_distribution2(p, N);
% Mean and Variance   
char_info('Power', p / (p+1), mean(X), p/(p+2) - (p/(p+1))^2, var(X))
% Drawing
[F_emp, xe] = ecdf(X);
F_th = xe.^p ;
x = linspace(min(X), max(X), N);
f_th =  p * x.^(p-1);
draw_distribution(X, F_th, f_th, F_emp, xe, x, 'Power')

%% Functions
function y = Exponential_distribution(lambda, N)
    % reverse distribution method
    if lambda > 0 && N > 0
        U = rand(N, 1);
        y = - log(U) / lambda;
    else
        error('arguments have to be greater than zero')
    end
end

function y = Erlang_distribution(n, lambda, N)
    % reverse distribution method
    y = zeros(1, N);
    for i = 1:N
        U = rand(n, 1);
        y(i) = -1/lambda * log( prod(U) );
    end
end

function y = Beta_distribution(N)
    % rejection acceptance method
    y = zeros(1, N);
    x = 0:0.001:1;
    f = 20 * x .* (1-x).^3;
    g = 1;      %rozkład jednostajny na odcinku [0,1]
    c = max( f / g );
    for i = 1:N
        Y = rand;
        U = rand;
        while U > (20*Y*(1-Y)^3) / (c*g)  
          Y = rand;  
          U = rand;
        end
        y(i) = Y;
    end
end

function y = Power_distribution2(p, N)
   % rejection acceptance method
   y = zeros(1, N);
   for i = 1:N
      U1 = rand;
      U2 = p * rand;
      while p * U1.^(p-1) < U2
          U1 = rand;
          U2 = p * rand;
      end
      y(i)=U1;
   end
end

function draw_distribution(X, F_th, f_th, F_emp, xe, x, my_title)
    figure
    % Distributor
    subplot(1, 2, 1);
    hold on;
    plot(xe, F_th, 'm');
    plot(xe, F_emp, 'k');
    title(['Comparison of ' my_title ' distribution'])
    legend('theoretical','empirical')
    xlabel('x')
    ylabel('F(x)')
    % Histogram compared with theoretical density
    subplot(1, 2, 2);
    hold on;
    plot(x, f_th, 'm', 'LineWidth', 1.5);
    histogram(X, 20, 'Normalization', 'pdf', 'Facecolor', 'k');
    title('Histogram compared to the theoretical density')
    legend('density')
    xlabel('x')
    ylabel('f(x)')
end

function char_info(name ,EX_th, EX_emp, Var_th, Var_emp)
    fprintf('%s || Mean: theoretical=%0.2f, empirical=%0.2f; Variance: theoretical=%0.2f, empirical=%0.2f; \n',...
    name, EX_th, EX_emp, Var_th, Var_emp)
end


