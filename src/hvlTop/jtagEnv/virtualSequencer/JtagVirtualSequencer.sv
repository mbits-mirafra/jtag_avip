`ifndef JTAGVIRTUALSEQUENCER_INCLUDED_
`define JTAGVIRTUALSEQUENCER_INCLUDED_

class JtagVirtualSequencer extends uvm_sequencer;
  `uvm_component_utils(JtagVirtualSequencer)

  JtagControllerDeviceSequencer jtagControllerDeviceSequencer;
  JtagTargetDeviceSequencer jtagTargetDeviceSequencer;

  extern function new(string name ="JtagVirtualSequencer" , uvm_component parent);

endclass : JtagVirtualSequencer

function JtagVirtualSequencer :: new(string name = "JtagVirtualSequencer",uvm_component parent);
  super.new(name,parent);
endfunction : new

`endif
