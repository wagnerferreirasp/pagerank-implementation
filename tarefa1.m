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
