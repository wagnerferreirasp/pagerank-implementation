%Todo: verificar porque está preenchendo V,C,L com 3670 valores, sendo que no enunciado diz que são 3270.
function tarefa2() 
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
            if !(i == k)                    % Eu não me aponto
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
                C = [C; c];
                L = [L; l];
                V = [V; 1/i];               % Cada índio é apontado por i páginas (que é o número total de páginas do grupo, exceto ele mesmo)
            end
        end
    end
    rotinaPrincipal(V, C, L, 0.15, 230);
end
