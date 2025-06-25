`ifndef JTAGCONTROLLERDEVICESEQUENCER_INCLUDED_
`define JTAGCONTROLLERDEVICESEQUENCER_INCLUDED_

class JtagControllerDeviceSequencer extends uvm_sequencer #(JtagControllerDeviceTransaction);
  `uvm_component_utils(JtagControllerDeviceSequencer)

  extern function new(string name = "JtagControllerDeviceSequencer",uvm_component parent);

endclass : JtagControllerDeviceSequencer 

function JtagControllerDeviceSequencer :: new(string name = "JtagControllerDeviceSequencer",uvm_component parent);
  super.new(name,parent);
endfunction  : new

`endif
