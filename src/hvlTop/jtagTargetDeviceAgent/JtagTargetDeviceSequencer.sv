`ifndef JTAGTargetDeviceEQUENCER_INCLUDED_
`define JTAGTargetDeviceSEQUENCER_INCLUDED_

class JtagTargetDeviceSequencer extends uvm_sequencer #(JtagTargetDeviceTransaction);
  `uvm_component_utils(JtagTargetDeviceSequencer)

  extern function new(string name = "JtagTargetDeviceSequencer",uvm_component parent);

endclass : JtagTargetDeviceSequencer 

function JtagTargetDeviceSequencer :: new(string name = "JtagTargetDeviceSequencer",uvm_component parent);
  super.new(name,parent);
endfunction  : new

`endif
