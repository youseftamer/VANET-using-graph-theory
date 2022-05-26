function H = mcds(G)
    len = height(G.Nodes);
    [comps, connVector] = connectedComp(G);
    
    % Create the subgraph H from G to be filled by the mcds algorithm
    H = graph();
    H = addnode(H, len);
    
    % A digraph is created to differentiate covered and uncovered nodes
    % Covered Nodes are those with no in-edges
    % pDegree of the node is the number of neighbouring uncovered nodes
    % The pDegree is thus determined by the 
    
    dG = digraph(adjacency(G));

    for k = 1:length(comps)
        nodes = outdegree(dG);
        exit = false;
        while (~exit)
            [pDegree, node] = max(nodes);
            
            if (connVector(node) == k)
                exit = true;
            else
                nodes(node) = -1;
            end
        end

        pre = predecessors(dG, node);
        suc = successors(dG, node);

        for i = 1:length(suc)
            % Test if the edge is weighted or not
            % If it is not, an error occurs
            try
                H = addedge(H, node, suc(i), G.Edges.Weight(findedge(G, node, suc(i))));
            catch M
                H = addedge(H, node, suc(i));
            end;
        end
        % remove edges from predecessors to node
        % cover successors by removing their in-edges "edges from their predecessors to them"
        for i = 1:length(pre)
            dG = rmedge(dG, pre(i), node);
        end
        
        for i = 1:length(suc)
            preOfSuc = predecessors(dG, suc(i));
            for j = 1:length(preOfSuc)
                dG = rmedge(dG, preOfSuc(j), suc(i));
            end
        end

        while (any(outdegree(dG, comps{k})))
            % start
            nodes = outdegree(dG);
            exit = false;
            while (~exit)
                [pDegree node] = max(nodes);
       
                if (indegree(dG, node) == 0 && connVector(node) == k)
                    exit = true;
                else
                    nodes(node) = 0;
                end
            end
            pre = predecessors(dG, node);
            suc = successors(dG, node);

            for i = 1:length(suc)
                % H.Nodes{str2double(suc{i}),:} = {suc{i}}; 
                try
                    H = addedge(H, node, suc(i), G.Edges.Weight(findedge(G, node, suc(i))));
                catch M
                    H = addedge(H, node, suc(i));
                end;
            end
            % remove edges from predecessors to node
            % cover successors by removing their in-edges "edges from their predecessors to them"
            for i = 1:length(pre)
                dG = rmedge(dG, pre(i), node);
            end
            for i = 1:length(suc)
                preOfSuc = predecessors(dG, suc(i));
                for j = 1:length(preOfSuc)
                    dG = rmedge(dG, preOfSuc(j), suc(i));
                end
            end
            % end
        end
    end
end