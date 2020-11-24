function y = Norm_Rejection_Acceptance(mu, sigma, N)
    % metoda akceptacji odrzucenia
    X = zeros(1,N);
    c = sqrt(exp(1)/(2*pi));
    for i=1:N
        Y = exprnd(1);
        g = exppdf(Y);
        if rand < 0.5 %generujemy znak plus z prawdopodobieństwem 1/2
            Y = -Y;
        end
        while rand > normpdf(Y) / (c*g)
            Y = exprnd(1);
            g = exppdf(Y);
            if rand < 0.5
                Y = -Y; 
            end
        end
        X(i) = Y;
    end
    y = sigma*X + mu;
end