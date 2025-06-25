`ifndef JTAGTargetDeviceBASESEQUENCE_INCLUDED_
`define JTAGTargetDeviceBASESEQUENCE_INCLUDED_

class JtagTargetDeviceBaseSequence extends uvm_sequence#(JtagTargetDeviceTransaction);
  `uvm_object_utils(JtagTargetDeviceBaseSequence) 

  extern function new(string name = "JtagTargetDeviceBaseSequence");
  extern virtual task body();

endclass : JtagTargetDeviceBaseSequence 

function JtagTargetDeviceBaseSequence :: new (string name = "JtagTargetDeviceBaseSequence");
  super.new(name);
endfunction : new

task JtagTargetDeviceBaseSequence :: body();
  req = JtagTargetDeviceTransaction :: type_id :: create("req");

  start_item(req);
  req.randomize();
  req.print();
  finish_item(req);
endtask : body

`endif
