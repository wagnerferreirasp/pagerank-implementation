function y = tarefa0_multiplicaApor(x) 
    V = [1, 1/2, 1/3, 1/3, 1/2, 1/2, 1/3, 1/2];
    C = [3, 4, 1, 1, 2, 4, 1, 2];
    L = [1,1,2,3,3,3,4,4];
    [m,n] = size(V);
    y = zeros(4,1);
    for i=1:n
        y(L(i)) = y(L(i)) + V(i)*x(C(i));
    end
    y;
end

function x = tarefa0() 
    tic();
    x0 = ones(4,1)*1/4;
    xAnterior = x0;
    m = 0.15;
    x = (0.85)*tarefa0_multiplicaApor(x0) + 0.15*x0;
    while (norm(xAnterior-x, 1) > 1.0000e-009)
        xAnterior = x;
        x = 0.85*tarefa0_multiplicaApor(x) + 0.15*x0;
    end
    toc();
end

