function y = Norm_Polar_Coordinates(mu, sigma, N)
    % metoda biegunowa 
    X = zeros(1,N);
    for i = 1:N/2 
        V1 = 2*rand-1;
        V2 = 2*rand-1;
        R2 = V1^2 + V2^2;
        while R2 > 1
            V1 = 2*rand-1;
            V2 = 2*rand-1;
            R2 = V1^2 + V2^2;
        end
        X(2*i-1)= sqrt( (-2 * log(R2)) /R2 )*V1;
        X(2*i)=sqrt( (-2 * log(R2)) /R2 )*V2;
    end
    y = sigma * X + mu;
end