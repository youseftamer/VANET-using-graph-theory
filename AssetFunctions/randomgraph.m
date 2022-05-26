function [G, xdim, ydim] = randomgraph(z, a, b, k)
    
    EndNodes = zeros(0, 2);
    Weight = zeros(0, 1);
    xdim = zeros(z, 1);
    ydim = zeros(z, 1);
    num = 1;
    num2 = 1;

    while (num <= z)

        xdim(num) = randi(a);
        ydim(num) = randi(b);
        num = num + 1;

    end

    for j  = 1:(z - 1)
        for i = j + 1 :z
            r = sqrt((xdim(j) - xdim(i))^2  ...
                + (ydim(j) - ydim(i))^2 );
            if r < k
                EndNodes(num2, :) = [i j]; 
                Weight(num2, 1) = r;
                num2 = num2 + 1; 

            end
        end
    end
    
    nodes = table( xdim, ydim, 'Variablenames', {'x', 'y'});
    edges = table(EndNodes, Weight);
    G = graph(edges, nodes);
end