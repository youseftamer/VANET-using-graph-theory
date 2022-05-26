function H = gabrielG(G, x, y)
    len = height(G.Nodes);
    edgeLen = height(G.Edges);
    H = graph();
    H = addnode(H, len);
    for i = 1:edgeLen
        acceptable = true;
        
        edge = G.Edges.EndNodes(i,:);
        radius = G.Edges.Weight(i) / 2.0;
        s = edge(1);
        t = edge(2);
        Xm = (x(s) + x(t)) / 2.0;
        Ym = (y(s) + y(t)) / 2.0;
        
        N = [neighbors(G, s)' neighbors(G, t)'];
        N = N(N ~= s);
        N = N(N ~= t);
        
        for j = 1:length(N)
            node = N(j);
            
            dist = sqrt((Xm - x(node))^2 + (Ym - y(node))^2);
            if (dist <= radius && ~(x(node) == x(s) && y(node) == y(s)) && ~(x(node) == x(t) && y(node) == y(t)))
                acceptable = false;
                
                break;
            end
        end
        
        if (~acceptable)
            continue;
        end
            
        H = addedge(H, s, t, G.Edges.Weight(i));
    end
end