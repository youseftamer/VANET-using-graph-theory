function connect = connectivity(g, n ,ext ,connecto)
    
    [~, r] =  conncomp(g);
    m = (r(1) == n - ext);
    connect = double(m) + connecto;

end