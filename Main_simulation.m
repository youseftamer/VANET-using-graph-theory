startup;
map = 1;
save = 0;
lod = 0;
topology = 0;
transRange = 150;                                                  %the transimision range which any tow nodes will have an edge between them if the distance is less or equal it(the readius of the OBU)
plotResults = true;

motionFig = simulate(map, topology, transRange, save, lod, plotResults);