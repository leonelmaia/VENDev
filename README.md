VEN-GUI that generates a ThorPackage
====
Thor is a Hermes-based (and improved) NoC implemented in VHDL. 

This repository contains a NoC generator that creates a ThorPackage.vhd, whose NoC receive yours parameters, based on application needs.
To create a NoC a few parameter are needed to user,
The parameters are: flit width, input buffers depth, NoC size and protection type.
These parameters have to be used like inputs in VEN-GUI. 