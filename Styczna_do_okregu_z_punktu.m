close all; clear all
hold on

x0 = 2; 
y0 = 1; 
R =  3; 
x1 = 4; 
y1 = 6; 
[a1, b1, a2, b2] = Styczna(x0, y0, R, x1, y1);

% Punkty styczności
[xst1, yst1] = punkt_stycznosci(a1, b1, x0, y0);
[xst2, yst2] = punkt_stycznosci(a2, b2, x0, y0);

% Rysowanie stycznych
x_gr = abs(x0) + abs(x1) + R;
y_gr = abs(y0) + abs(y1) + R;
x = -x_gr : 0.01 : x_gr;
if a2 ~= 0 && b2 ~= 0
    plot(x, a1*x + b1, 'b', x, a2*x + b2, 'c')
    napis1 = sprintf('y1 = %.2f x + %.2f',a1,b1);
    napis2 = sprintf('y2 = %.2f x + %.2f',a2,b2);
else
    plot(x, a1*x + b1, 'b')
    napis1 = sprintf('y1 = %i x + %i',a1,b1);
    if x1 == R
        line([x1, x1],[-x_gr, x_gr],'color','c','linestyle','-')
        plot(x0 + R, y0, 'r*')
        napis2 = 'x2 =' + string(x0+R);
    else
        line([-y_gr, y_gr],[y1, y1],'color','c','linestyle','-')
        plot(x0, y0 + R, 'r*')
        napis2 = 'y2 =' + string(y0+R);
    end
end
legend(napis1, napis2)

% Rysowanie
t = 0 : pi/100 : 2*pi;
plot(x0 + R*cos(t), y0 + R*sin(t), 'm','HandleVisibility','off')
plot(x0, y0, 'r*', x1, y1, 'r*','HandleVisibility','off')
plot(xst1, yst1, 'r*', xst2, yst2, 'r*','HandleVisibility','off')
axis('equal');
line([0,0],[-2*x_gr, 2*x_gr],'color','k','linestyle','--','HandleVisibility','off')
line([-2*y_gr, 2*y_gr],[0,0],'color','k','linestyle','--','HandleVisibility','off')
title(sprintf('Styczna z punktu P(%i,%i) do okręgu o środku O(%i,%i) i promieniu R=%i',x1,y1,x0,y0,R))
xlabel('x')
ylabel('y')
xlim([-x_gr, x_gr])
ylim([-y_gr, y_gr])

function [a1, b1, a2, b2] = Styczna(x0, y0, R, x1, y1)
    A = 4 * R.^2 - 4*x0.^2 - 4*x1.^2 + 8*x0*x1;   % DELTA = A*a^2 + B*a + C=0
    B = 8 * x0*y0 - 8*x0*y1 - 8*x1*y0 + 8*x1*y1;
    C = 4 * R.^2 - 4*y1.^2 + 8*y0*y1 - 4*y0.^2;
    if abs(x1 - x0) == R % A=0
        a1 = -C / B;
        b1 = y1 - x1*a1;
        a2 = 0; b2 = 0;
    elseif abs(y1 - y0) == R % C=0
        a1 = -B / A;
        b1 = y1 - x1*a1;
        a2 = 0; b2 = 0;
    elseif (y1 - y0)^2 + (x1 - x0)^2 > R^2 %Jeżeli poza krawędzią
        delta = sqrt(B.^2 - 4*A*C);
        a1 = (-B - delta) / (2*A);
        a2 = (-B + delta) / (2*A);
        b1 = y1 - x1*a1;
        b2 = y1 - x1*a2;
    else
        error('styczna nie istnieje')
    end
end

function [xst, yst] = punkt_stycznosci(a, b, x0, y0)
    ast = -1/a;
    xst = (b - y0 + ast*x0) / (ast - a);
    yst = ast*xst + y0 - ast*x0;
end
