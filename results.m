function [energy, congestion, stability] = results(Top, origin, n ,out, energyo)

    
    %% energy
    energy = sum((Top.Edges.Weight.^2)) / height(Top.Edges) + energyo;

 
    %% congestion
    congestion = zeros(40, 2);
    congestion(:, 1) = 1:40; 
    deg = degree(Top);
    for i = 1:40
      su = (congestion(i, 1) == deg);
      su = sum(int8(su));
      congestion(i, 2) = su;
    end

    %% stability
    
    out = out(1:sum(int8(out ~= 0)));
    k = zeros(0, 0);
    l = zeros(0, 0);
    nodes = 1:n;
    nodes(out) = [];
    n = length(nodes);
    or = distances(origin, nodes, nodes, 'method', 'unweighted');
    to = distances(Top, nodes, nodes, 'method', 'unweighted');
    for i = 1 : n
       for j = i + 1 :n
           if or(i, j) < n && or(i, j) ~= 0 && to(i, j) < n && to(i, j) ~= 0
               k(length(k) + 1) = or(i, j);
               l(length(l) + 1) = to(i, j);
           end
       end
    end
    
    stability = sum(l ./ k) / length(l);
    
end