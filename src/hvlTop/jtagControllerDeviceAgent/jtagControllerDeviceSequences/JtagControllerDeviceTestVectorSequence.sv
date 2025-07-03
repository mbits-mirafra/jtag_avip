`ifndef JTAGCONTROLLERDEVICETESTVECTORSEQUENCE_INCLUDED_
`define JTAGCONTROLLERDEVICETESTVECTORSEQUENCE_INCLUDED_

class JtagControllerDeviceTestVectorSequence extends JtagControllerDeviceBaseSequence;
  `uvm_object_utils(JtagControllerDeviceTestVectorSequence)
  extern function new(string name = "JtagControllerDeviceTestVectorSequence");
  extern virtual task body();

endclass : JtagControllerDeviceTestVectorSequence 

function JtagControllerDeviceTestVectorSequence :: new(string name = "JtagControllerDeviceTestVectorSequence");
  super.new(name);
endfunction : new

task JtagControllerDeviceTestVectorSequence :: body();
  super.body();
  req = JtagControllerDeviceTransaction :: type_id :: create("req");
  start_item(req);
  req.randomize() with{trstEnable == tresetEnable;};
  req.print(); 
  finish_item(req);
endtask : body

`endif
