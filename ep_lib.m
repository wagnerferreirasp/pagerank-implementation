function [V,C,L] = encontraVCL(A) 
    [n,n] = size(A);
    V = [];
    C = [];
    L = [];
    for i=1:n
        for j=1:n
            if (A(i,j) > 0)
                V = [V, A(i,j)];
                L = [L, i];
                C = [C, j];
            end
        end
    end
end

function y = multiplica(V, C, L, x) 
    [m,l] = size(V);
    [z,w] = size(x);
    y = zeros(z, 1);
    for i=1:l
        y(L(i)) = y(L(i)) + V(i)*x(C(i));
    end
end

function mostraPaginasOrdenadas(x) 
    [z,w] = size(x);
    A = [transpose([1:z]), x];
    B = sortrows(A, -2);
    printf('Paginas mais importantes: \n');
    for i=1:z
        printf('Pagina %d - Importancia: %f\n', B(i, 1), B(i, 2));
    end
end

function x = rotinaPrincipal(A, m) 
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
