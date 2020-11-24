clear
%% DIFFERENT LENGTH OF THE SAMPLE:
%       For a large sample (N = 10000) the Box-Muller method is the fastest 
% because it is written without a loop, and the slowest method 
% is Acceptance-rejection. The Polar Coordinates method is faster than 
% the Acceptance-rejection, because it requires half as much iterations
% and has two 'if'.
%       For a small sample (N = 100) the Polar Coordinates method 
% is the fastest. A little slower is the Box-Muller method because it requires 
% to count sin and cos. The Acceptance-rejection method is the slowest one.
mu = 2;
sigma = 4;
M = 500;

N = 10000;
test(mu, sigma, N, M)
N = 100;
test(mu, sigma, N, M)

%% RÓŻNE PARAMETRY:
N = 1000;
% The parameter values ​​have little effect on the running time of the methods.
mu = 0;
sigma = 1;
test(mu, sigma, N, M)

mu = 50;
sigma = 100;
test(mu, sigma, N, M)

%% Functions
function test(mu, sigma, N, M)
    time_X1 = [];
    time_X2 = [];
    time_X3 = [];
    for i = 1:M     % I average the results
        tic
        X1 = Norm_Box_Muller(mu, sigma, N); 
        time_X1 = [time_X1, toc];
        tic
        X2 = Norm_Polar_Coordinates(mu, sigma, N); 
        time_X2 = [time_X2 , toc];
        tic
        X3 = Norm_Rejection_Acceptance(mu, sigma, N); 
        time_X3 = [time_X3 ,toc];
    end
    disp('Time Test')
    disp_info('Box-Muller', mu, sigma, N, mean(time_X1))
    disp_info('Biegunowa', mu, sigma, N, mean(time_X2))
    disp_info('Akceptacji odrzucenia', mu, sigma, N, mean(time_X3))
end

function disp_info(method, mu, sigma, N, time)
    fprintf('%s || Norm(%i, %i); N = %i; time: %i; \n',...
    method, mu, sigma, N, time)
end
