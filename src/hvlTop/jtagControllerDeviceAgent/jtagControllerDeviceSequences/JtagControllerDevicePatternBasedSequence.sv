
`ifndef JTAGControllerDevicePATTERNBASEDSEQUENCE_INCLUDED_
`define JTAGControllerDevicePATTERNBASEDSEQUENCE_INCLUDED_

class JtagControllerDevicePatternBasedSequence extends JtagControllerDeviceBaseSequence;
  `uvm_object_utils(JtagControllerDevicePatternBasedSequence)
  rand logic[31:0]patternNeeded;
  extern function new(string name = "JtagControllerDevicePatternBasedSequence");
  extern virtual task body();

endclass : JtagControllerDevicePatternBasedSequence 

function JtagControllerDevicePatternBasedSequence :: new(string name = "JtagControllerDevicePatternBasedSequence");
  super.new(name);
endfunction : new

task JtagControllerDevicePatternBasedSequence :: body();
  super.body();
  req = JtagControllerDeviceTransaction :: type_id :: create("req");
  req.randomize() with{jtagTestVector == patternNeeded;};
  req.print();
  start_item(req);
  finish_item(req);
endtask : body

`endif
