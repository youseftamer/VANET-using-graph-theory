function [SP, xdata, ydata] = getpath(g, s, t, x, y)
    
    n = length(x);
    xdata = zeros(0, n);
    ydata = zeros(0, n);
    SP=cell(n);
    for i = 1:n
        SP{i} = shortestpath(g,s(i),t(i));
        if (~isempty(shortestpath(g,s(i),t(i))))
            xdata(i) = x(SP{i}(1));
            ydata(i) = y(SP{i}(1));
        else 
            xdata(i) = -99999;
            ydata(i) = -99999;
        end
    end

end

