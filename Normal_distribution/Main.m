clear
%% Normal distribution generation
mu = 2;
sigma = 4;
N = 10000;

X = Norm_Box_Muller(mu, sigma, N);
generation(X, mu, sigma, N, 'Normal Box-Muller')

Y = Norm_Polar_Coordinates(mu, sigma, N);
generation(Y, mu, sigma, N, 'Normal Polar Coordinates')

Z = Norm_Rejection_Acceptance(mu, sigma, N);
generation(Z, mu, sigma, N, 'Normal Rejection-Acceptance')


%% Functions
function generation(X, mu, sigma, N, my_name)
    % Mean and Variance     % for N = 10000
    char_info(my_name ,mu , mean(X), sigma^2, var(X))
    % Drawing
    x = linspace(min(X), max(X), N);
    [F_emp, xe] = ecdf(X);
    F_th = normcdf(xe, mu, sigma);
    f_th = normpdf(x, mu, sigma);
    draw_distribution(X, F_th, f_th, F_emp, xe, x, my_name)

    if_norm = kstest((X - mu)/sigma);
    if if_norm == 0
        disp('KS_test: It is a normal distribution with given parameters')
    else
        disp('KS_test: It is not a normal distribution with the given parameters')
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

