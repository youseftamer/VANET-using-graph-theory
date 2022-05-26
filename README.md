# VANET-planning-with-Graph-theory

<h2 style="text-align: center">Welcome in the VANET environment simulator.</h2>
- To run the simulation, run the Main_simulation.m file in MATLAB.<br>
By default, the used map is map1 (El-Tahrir Square Map).<br>
No topology control is applied by default. Only the UDG is shown.<br>
- To change the used map, change the value of the variable "map" (The allowed values are 1:11).<br>
- To apply a certain topology, change the value of the variable "topology" (0 => The UDG without applying any topologies, 1 => MST, 2 => MCDS, 3 => GG).<br><br>

Inside this repository, there are 4 folders to be found:<br>
1-) "AssetFunctions" which contains complementary functions used to implement the different algorithms used in the simulation.<br>
2-) "TopologyControl" which contains the Topology Control Algorithms Functions.<br>
3-) "Maps" which contains the different maps to be tested.<br>
4-) "Skel2Graph3D" which is an open-source toolbox used in the image processing of the maps.<br>
