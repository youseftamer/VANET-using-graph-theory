function t = getEnodes(s)
    n = length(s);
    t = zeros(0, n);
    for i = 1:n
        while 1
            t(i) = randi(n);
            if t(i) ~= s(i)
                break;
            end
        end
    end

end