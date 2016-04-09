% Encontra os vetores V, C e L de uma matriz A, 
% principalmente util se a matriz for esparsa.
%   parametro A: uma matriz mxn
%   retorno V kx1: Os k valores nao nulos da matriz
%   retorno C kx1: Vetor tal que C(i) eh a coluna de V(i)
%   retorno L kx1: Vetor tal que L(i) eh a linha de V(i)
function [V,C,L] = encontraVCL(A) 
    [m,n] = size(A);
    V = [];
    C = [];
    L = [];
    for i=1:m
        for j=1:n
            if (!(A(i,j) == 0))
                V = [V; A(i,j)];
                L = [L; i];
                C = [C; j];
            end
        end
    end
end

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
    B = sortrows(A, -2); % ordena A do maior para o menor na coluna 2 
    printf('Paginas mais importantes: \n');
    for i=1:n
        printf('Pagina %d - Importancia: %f\n', B(i, 1), B(i, 2));
    end
end

% Calcula e mostra as importancias das paginas de uma matriz de ligacao A
%   parametro A: uma matriz de ligacao nxn
%   parametro m: 0 < m < 1 um valor determinado para que a matriz A seja
%       transformada em uma matriz que satisfaca o teorema de Perron-Frobenius
function rotinaPrincipal(A, m) 
    [n,n] = size(A);
    [V,C,L] = encontraVCL(A);
    x0 = ones(n, 1)/n;
    xAnterior = x0;
    x = (1-m)*multiplica(V, C, L, x0) + m*x0;
    while (norm(xAnterior-x, 1) > 1e-5)
        xAnterior = x;
        x = (1-m)*multiplica(V, C, L, x) + m*x0;
    end
    mostraPaginasOrdenadas(x);
end

% Tarefa 1 do Exercicio-Programa: 
% Mostrar as importancias das paginas dada sua rede
function x = tarefa1() 
    % A eh a matriz de ligacao da rede
    A = [0 0 0 0 0 0 0 1/2;
         1/2 0 0 0 0 0 0 0;
         1/2 1/2 0 0 0 0 0 1/2;
         0 1/2 0 0 0 0 0 0;
         0 0 0 1/2 0 0 0 0;
         0 0 1/2 1/2 1 0 0 0;
         0 0 1/2 0 0 1 0 0;
         0 0 0 0 0 0 1 0];
    rotinaPrincipal(A, 0.15);
end
