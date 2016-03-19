function [V,C,L] = encontraVCL(A) 
    [n,n] = size(A);
    V = [];
    C = [];
    L = [];
    for i=1:n
        for j=1:n
            if (A(i,j) != 0)
                V = [V, A(i,j)];
                L = [L, i];
                C = [C, j];
            end
        end
    end
end

function y = multiplica(V,C,L,x) 
    [m,l] = size(V);
    [z,w] = size(x);
    y = zeros(z,1);
    for i=1:l
        y(L(i)) = y(L(i)) + V(i)*x(C(i));
    end
end

function x = rotinaPrincipal(A, m) 
    [n, n] = size(A);
    [V,C,L] = encontraVCL(A);
    x0 = ones(n,1)/n;
    xAnterior = x0;
    x = (1-m)*multiplica(V,C,L,x0) + m*x0;
    while (norm(xAnterior-x, 1) > 1.0000e-005)
        xAnterior = x;
        x = (1-m)*multiplica(V,C,L, x) + m*x0;
    end
end
