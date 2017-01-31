This file serves to show an example of and explain the pattern used for the input file of VEN-GUI.

It is based on the pattern for the input files used in NOIA for the creation of NoCs.

Each line represents the column of routers in a NoC.
Each line is segmented by semicolons(;) which are used to divide each router from one another.
Each segment of a line holds four numbers, whose values range from 0-3. Signifying the level of protection applied to each link.

Here is the input file used to implement the security in the buffers of a 3x3 NoC(the placement of the different securities is random):
From left to right: WEST, NORTH, EAST, SOUTH. 

0 2 3 0; 0 3 2 2; 0 0 0 3;
3 1 2 0; 2 0 0 1; 0 0 1 0;
2 0 0 0; 0 2 0 0; 1 0 0 2;

Remember that a link can have only a single type of protection, thus the symmetry of a NoC needs to be respected.
For example, the protection applied to the North link of router 0,0 needs to be the same applied to the South link of router 0,1.

The different number between 0 - 3 signify:
0 - No protection
1 - Extended Hamming Protection
2 - Matrix Protection
3 - CLC Protection