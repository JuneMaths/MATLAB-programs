function y = Norm_Box_Muller(mu, sigma, N)
    % metoda boxa-mullera
    U1 = rand(1, N/2);
    U2 = rand(1, N/2);
    X = sqrt(-2*log(U1)) .* cos(2*pi*U2);
    Y = sqrt(-2*log(U1)) .* sin(2*pi*U2);
    y = [sigma * X + mu, sigma * Y + mu];
end
