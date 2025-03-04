# Jtag_avip
This project deals with the Jtag protocol

# Accelerated VIP for Jtag Protocol
The idea of using Accelerated VIP is to push the synthesizable part of the testbench into the separate top module along with the interface and it is named as HDL TOP and the unsynthesizable part is pushed into the HVL TOP. This setup provides the ability to run longer tests quickly. This particular testbench can be used for the simulation as well as the emulation based on the mode of operation.

# Testbench Architecture Diagram
![JtagArchitecture](https://github.com/user-attachments/assets/d83eddce-aee2-4453-9c54-8d0bb5464294)
