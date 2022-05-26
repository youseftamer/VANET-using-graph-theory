function motionFig = simulate(map, topology, transRange, save, lod, plotResults)
    img = imread(['map' int2str(map) '.jpg']);

    motionFig = figure(1);
    motionFig.WindowState = 'maximized';
    hold on; 
     
    [g, y, x] = image2graph(['map' int2str(map) '.jpg']);
    p = plot(g, 'xdata', x, 'ydata', y);
    image(img);


    n = numnodes(g);                                                   %creating a variable contains the nimber of nodes because it will be used a lot                                                     % creating a cell to contain the coordinates of motion of every node
    s = 1:n;                                                           % creating an array which its elements from 1 to number of nodes to use it in line 24 (The starting node of each car) 

    spd = 20;                                                          % the number of points per one edge (the number of cordinates of motion per one edge) Higher values will cause slower motion
    trials = 1;
    axis([min(x) max(x) min(y) max(y)]);                               %Setting the scale of the figure's axis to be constant 

    energy = 0;                                                        % test criteria
    connect = 0;
    clear congestion;
    clear avgenergy;
    clear stability;
    clear avgconnect;

    [motionmatx, motionmaty, xdat, ydat] = Pathdata(g, s, x, y, spd, lod);
    avgenergy = zeros(0, 0);
    avgconnect = zeros(0, 0);

    for ii = 1:trials

        % defines a graph for cars` and adds n nodes to it
        Cg = graph;
        Cg = addnode(Cg,n);
        %%

        ext = 0;                                                       % variable which contains the cars which have ended its path to remove from the graph
                                                                       %this function sets the target nodes to be random and makes sure the target isn't the same source node

        %%

        hold on
        Pc = plot(Cg,'XData', xdat, 'YData', ydat, 'MarkerSize'...
            , 5,'NodeColor', 'r', 'edgecolor', 'r');                                     %plots a graph for the cars

        out = zeros(n,1);                                             % a matrix which will contain the nodes which have ended their path to remove them from the path and delete their edges

         %% the main part of the simulation 
        for k= 1:spd*n                                                         
            for z = 1:n
                if(motionmatx(z,k+1) == 0 &&  motionmaty(z,k+1) == 0 ... % Next loop we will remove points which have reached their final
                        && motionmatx(z,k) == 0 &&  motionmaty(z,k) ...   % coordinates and having the new coordinates for nodes which have not
                        == 0  && ~ismember(z,out))                        % reached their final coordinates 

                    for i = 1:n 
                        if i == z
                            continue
                        end

                        edgids = findedge(Cg,z,i);

                        if edgids
                            Cg = rmedge(Cg,edgids);                     % removing edges from the nodes which have reached the final coordinates 
                        end
                    end

                    Pc.XData(z) = -999999999;                           %these lines we will send the nodes which have reached their
                    Pc.YData(z) = -999999999;                           %final coordinates out of the graph

                    ext = ext + 1;
                    out(ext) = z;
                else
                   if (~ismember(z,out))
                       Pc.XData(z) = motionmatx(z,k);                    % having the new coordinates for nodes which have not
                       Pc.YData(z) = motionmaty(z,k);                    % reached their final coordinates 
                   end
                end
            end

            if ext >= .5*n                                                    % this condition is to make sure the function wont wait till the graph is empty 
                break                                                         %and regenerate the nodes after half (0.5) the cars has ended their motion
            end                                                            


        %%
            for i = 1:n-1
                if ismember(i,out)                                        %if the node i is kicked out of the graph it has no edges so it just breaks the connectivity loop
                    continue
                end

                for j = i+1:n
                    if ismember(j,out)                                    %same as in line 119
                        continue
                    end

                    distance = sqrt((Pc.XData(i)-Pc.XData(j))^2 ...
                        + (Pc.YData(i)-Pc.YData(j))^2);                   %calculates the distance between nodes i,j 

                    edgeindex = findedge(Cg,i,j);                         %gets the index of the edge in the graph, if it doesn't exist it returns 0
                                                                          % Next if conditions will deside if there is an edge between 
                                                                          % node i and j depending on the distance between them 
                    if distance <= transRange           
                        if ~edgeindex                                     % if there's no edge => Make one 
                            Cg = addedge(Cg, i, j, distance); 
                        else                                              % if there's an edge => update its distance(weight) 
                            Cg.Edges.Weight(edgeindex) = distance;
                        end
                    else
                        if edgeindex                                      %if there's an edge and the nodes aren't in range anymore => remove the edge
                            Cg = rmedge(Cg, i, j);
                        end
                    end
                end
            end

            xdat = Pc.XData;                                             %replot the cars graph with the new edges and new coordinates 
            ydat = Pc.YData;
            delete(Pc);
            Cg.Nodes.x = xdat';
            Cg.Nodes.y = ydat';
            Cg1 = Cg;

            if (topology == 1)
                Cg = minspantree(Cg);
            elseif topology == 2
                Cg = mcds(Cg);
            elseif topology == 3
                Cg = gabrielG(Cg, xdat, ydat);
            end
            Pc = plot(Cg,'XData', xdat, 'YData', ydat,...
                'MarkerSize', 10,'NodeColor', 'r' , 'edgecolor', 'r');

            [energy, congestion(:,:, k), stability(k)] = results(Cg, Cg1, n, out, energy);
            avgenergy(k) = energy / k;

            if (topology == 0)
                connect = connectivity(Cg, n ,ext ,connect);
                avgconnect(k) = connect / k; 
            end

            pause(.01);                                                    % to have a simulation with a suitable and remarkable speed not with the speed of the processor 
            if k == 10 && save == 1
               saveas(gcf, ['results\map' int2str(map) ' top' int2str(topology) '.png']) 
            end

        end

        delete(Pc);


    end

    if (plotResults)
        plotting(avgenergy, avgconnect, congestion, stability, map, topology, save);      % map - top - save
    end
end