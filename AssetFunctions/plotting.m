function [] = plotting(x, y, z, l, map, Top, save)
    
    map = int2str(map);
    t = Top;
    Top = int2str(Top);

    figure(2)
    plot (x);
    xlabel('Frames (n)')
    ylabel('Average R^2 (m^2)')
    title('Average R^2 vs Frames');
    if save == 1
        saveas(gcf,['results\R^2 map' map ' top' Top '.png'])
    end

    figure(3)
    plot (l);
    xlabel('Frames (n)')
    ylabel('Average multiples of the shortest paths (n)')
    title('Average multiples of the shortest paths vs Frames');
    if save == 1
        saveas(gcf,['results\stab map' map ' top' Top '.png'])
    end
    
    figure(4)
    avg = zeros(size(z, 1), 2);
    for i = 1:size(z, 1)
        avg(i, 1) = z(i, 1, 1);
        avg(i, 2) = sum(z(i, 2, :)) / size(z, 3);
    end
    n = 0; 
    for i = 1:size(avg, 1)
        if avg(i, 2) ~= 0
            n = i;
        end
    end
    avg = avg(1:n, :);
    bar (avg(:, 1)', avg(:, 2)');
    xlabel('Average number of nodes (n)')
    ylabel('Average number of nodes (n)')
    title('Average number of nodes vs Average number of nodes');
    if save == 1
      saveas(gcf,['results\cong map' map ' top' Top '.png'])
    end
    
    if t == 0
        figure(5)
        plot (y);
        xlabel('Frames (n)')
        ylabel('Connectivity probability')
        title('connectivity probability vs Frames');
        if save == 1
            saveas(gcf,['results\conn map' map ' top' Top '.png'])
        end
    end
end