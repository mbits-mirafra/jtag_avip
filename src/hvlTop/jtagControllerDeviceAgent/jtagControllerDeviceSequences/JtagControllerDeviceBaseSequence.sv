`ifndef JTAGControllerDeviceBASESEQUENCE_INCLUDED_
`define JTAGControllerDeviceBASESEQUENCE_INCLUDED_

class JtagControllerDeviceBaseSequence extends uvm_sequence#(JtagControllerDeviceTransaction);
  `uvm_object_utils(JtagControllerDeviceBaseSequence) 

  rand int numberOfTests;
  extern function new(string name = "JtagControllerDeviceBaseSequence");
  extern virtual task body();

endclass : JtagControllerDeviceBaseSequence 

function JtagControllerDeviceBaseSequence :: new (string name = "JtagControllerDeviceBaseSequence");
  super.new(name);
endfunction : new

task JtagControllerDeviceBaseSequence :: body();
  super.body();
endtask : body

`endif
