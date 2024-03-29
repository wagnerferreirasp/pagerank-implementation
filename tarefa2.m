% Dizendo ao octave que esse é um arquivo de script e não de função única:
1;

% Multiplica uma matriz A mxn, em sua forma [V,C,L], por x
% Tem o mesmo efeito de calcular Ax mas, caso A seja esparsa, 
% essa funcao evita multiplicar os zeros da matriz
%   parametro V kx1: Os k valores nao nulos da matriz
%   parametro C kx1: Vetor tal que C(i) eh a coluna de V(i)
%   parametro L kx1: Vetor tal que L(i) eh a linha de V(i)
%   parametro x nx1: Vetor a ser multiplicado
%   retorno y: o resultado da multiplicacao Ax, ou seja: y = Ax
function y = multiplica(V, C, L, x) 
    [k,l] = size(V);
    [z,w] = size(x);
    y = zeros(z, 1);
    for i=1:k
        y(L(i)) = y(L(i)) + V(i)*x(C(i));
    end
end

% Dado um vetor de importancias x, imprime as paginas e suas respectivas importancias, 
% ordenadas por importancia
%   parametro x: o vetor de importancias nx1
function mostraPaginasOrdenadas(x) 
    [n,w] = size(x);
    A = [transpose([1:n]), x]; % A = [identificacao das paginas (1:n), vetor de importancias]
    Acompacto = [];
    for i=1:20
        cacique = i*(i+1)/2;
        % índio representante é o primeiro índio da tribo, já que os índios de uma tribo tem as mesmas
        % importâncias. Logo, basta mostrar apenas um na saída.
        indioRepresentante = cacique+1; 
        Acompacto = [Acompacto; cacique x(cacique)];
        Acompacto = [Acompacto; indioRepresentante x(indioRepresentante)];
    end
    B = sortrows(Acompacto, -2); % ordena A do maior para o menor na coluna 2 
    printf('Pagina\tImportancia \n');   
    [m,z] = size(B);
    for i=1:m
        printf('%d\t%f\n', B(i, 1), B(i, 2));
    end
end

% Calcula e mostra as importancias das paginas de uma matriz de ligacao A
%   parametro A: uma matriz de ligacao nxn
%   parametro m: 0 < m < 1 um valor determinado para que a matriz A seja
%       transformada em uma matriz que satisfaca o teorema de Perron-Frobenius
function rotinaPrincipal(V, C, L, m, n) 
    x0 = ones(n, 1)/n;
    xAnterior = x0;
    x = (1-m)*multiplica(V, C, L, x0) + m*x0;
    while (norm(xAnterior-x, 1) > 1e-5)
        xAnterior = x;
        x = (1-m)*multiplica(V, C, L, x) + m*x0;
    end
    mostraPaginasOrdenadas(x);
end

% Tarefa 2 do Exercicio-Programa: 
% Mostrar as importancias das paginas da tribo
function main() 
    V = [];
    C = [];
    L = [];
    for i = 1 : 20
        cacique = i*(i+1)/2;
        V = [V; ones(i,1)/i];               % Meus índios me apontam e 1/i apontam pra cada um deles
        L = [L; ones(i,1)*cacique];         % Na minha linha
        for j = cacique+1 : cacique+i   
            C = [C; j];                     % Na coluna de cada índio
        end 
        for k = 1 : 20                      % Os outros caciques me apontam
            if (i != k)                     % Eu não me aponto
                L = [L; cacique];           % Na minha linha
                C = [C; k*(k+1)/2];         % Na coluna do cacique k
                V = [V; 1/(20 - 1 + k)];    % Os outros caciques (20-1) apontam para o cacique do grupo k e seus índios também (+k)
            end
        end
        for l = cacique+1 : cacique+i       % Para cada indio desse grupo i
            L = [L; l];                     % Na linha desse índio
            C = [C; cacique];               % O cacique aponta para o índio
            V = [V; 1/(20 - 1 + i)];        % Os outros caciques (20-1) apontam para cacique e seus índios também (+i)
            for c = cacique+1 : cacique+i   % Os outros índios me apontam
                if (l != c)                 % Eu não me aponto
                    C = [C; c];
                    L = [L; l];
                    V = [V; 1/i];               % Cada índio é apontado por i páginas (que é o número total de páginas do grupo, exceto ele mesmo)
                end
            end
        end
    end
    rotinaPrincipal(V, C, L, 0.15, 230);
end

% Executa todo o script
main(); 
