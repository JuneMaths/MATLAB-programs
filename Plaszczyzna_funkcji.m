
figure(1)
Plaszczyzna(@(x,y)exp(-x.^2 -y.^2),'kolo',[0,0,2],[0.2,-0.2])
figure(2)
Plaszczyzna(@(x,y)x.^2+y.^2,'prostokat',[-5,-5,10,10],[2,1])
figure(3)
Plaszczyzna(@(x,y)-sqrt(x.^2+(y-1).^2),'kolo',[-5,-5,20],[1,3])

function Plaszczyzna(funkcja, metoda, dane, punkt) 
% Funkcja dla dowolnej funkcji dw�ch zmiennych, podawanej jako funkcja anonimowa, rysuje jej wykres. 
% W zale�no�ci od metody:
% 1.) Je�eli metoda='kolo' i dane=[x0,y0,r], to rysuje wykres na obszarze ko�a o �rodku (x0,y0) i promieniu r, 
% 2.) Je�eli metoda='prostokat' i dane=[x,y,a,b], to rysuje wykres na obszarze prostok�tnym [x,y]X[x+a,y+b]. 
% Nast�pnie dla podanego punktu (x1,y1,z1), dla kt�rego podajemy tylko x1 i y1, funkcja rysuje p�aszczyzn� styczn�. 
% Zak�adam, �e u�ytkownik b�dzie podawa� takie funkcje i taki punkt styczno�ci, �e p�aszczyzna styczna istnieje.
switch metoda
    case "prostokat"
        [k, j] = size(dane);
        if (j == 4 && k == 1) || (k == 4 && j == 1)
            x = dane(1);
            y = dane(2);
            a = dane(3);
            b = dane(4);
            [X, Y] = meshgrid(x:a/100:x+a, y:b/100:y+b);
            x1 = punkt(1);
            y1 = punkt(2);
            z1 = funkcja(x1, y1);
            if (x <= x1 && x1 <= x + a) && (y <= y1 && y1 <= y + b)
                rysuj(funkcja, X, Y, x1, y1, z1)
            else
                error('Punkt poza kraw�dzi�!')
            end
        else
            error('Nieprawid�owo wpisane dane!')
        end
    case "kolo"
        [k, j] = size(dane);
        if (j == 3 && k == 1) || (k == 3 && j == 1)
            x0 = dane(1);
            y0 = dane(2);
            r = dane(3);
            [T, S] = meshgrid(0:pi/100:2*pi, 0:r/100:r);
            X = S.*cos(T) + x0;
            Y = S.*sin(T) + y0;
            x1 = punkt(1);
            y1 = punkt(2);
            z1 = funkcja(x1,y1);
            if (y1 - y0)^2 + (x1 - x0)^2 <= r^2 %Je�eli w polu ko�a
                rysuj(funkcja, X, Y, x1, y1, z1)
            else
                error('Punkt poza kraw�dzi�!')
            end
        else
            error('Nieprawid�owo wpisane dane!')
        end
    otherwise
        error('Nieprawid�owo podana metoda!')
end
end


function rysuj(funkcja, X,Y,x1,y1,z1)
    Z = funkcja(X, Y);
    surf(X, Y, Z)
    colormap Spring
    hold on
    plot3(x1, y1, z1, 'b*', 'LineWidth', 2)
    h = 10.^-9;
    dx = (funkcja(x1 + h, y1) - funkcja(x1 - h, y1)) / (2*h);
    dy = (funkcja(x1, y1 + h)- funkcja(x1, y1 - h)) / (2*h);
    zp = dx*(X - x1) + dy*(Y - y1) + z1;
    mesh(X, Y, zp)
    xlabel('o� X')
    ylabel('o� Y')
    zlabel('o� Z')
    nfun = func2str(funkcja);
    nefun = nfun(7:end);
    newfun = strrep(nefun, '.', '');
    newnfun = strrep(newfun, '*', '');
    legend('Funkcja', 'Punkt Styczno�ci', 'P�aszczyzna Styczna')
    title(['Wykres funkcji z = ' texlabel(newnfun) ' oraz jej p�aszczyzna styczna w punkcie (' num2str(x1) ', ' num2str(y1) ', ' num2str(z1) ')' ])
    hold off  
end
