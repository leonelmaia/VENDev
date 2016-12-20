VEN-GUI that generates a ThorPackage
====
Thor is a Hermes-based (and improved) Network-On-Chip(NoC) implemented in VHDL. 

This repository contains a NoC generator that creates a ThorPackage.vhd, which its parameters are used to create a NoC, based on application needs.
To create a NoC a few parameter are needed to be passed by the user,
The parameters are: flit width, input buffers depth, NoC size and protection type.
These parameters are used like inputs in VEN-GUI. 