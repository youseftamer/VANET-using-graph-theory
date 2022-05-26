function [comps, connVector] = connectedComp(G)
    exit = false;
    comps = {};
    connVector = conncomp(G);
    i = 1;
    while (~exit)
        v = [];
        l = 1;
        for j = 1:length(connVector)
            if (connVector(j) == i)
                v(l) = j;
                l = l + 1;
            end
        end
        exit = isempty(v);
        if (~exit)
            comps{i} = v;
        end
        i = i + 1;
    end
end