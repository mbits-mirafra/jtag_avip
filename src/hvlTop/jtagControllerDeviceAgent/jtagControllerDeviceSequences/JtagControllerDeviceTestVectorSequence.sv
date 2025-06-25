`ifndef JTAGControllerDeviceTESTVECTORSEQUENCE_INCLUDED_
`define JTAGControllerDeviceTESTVECTORSEQUENCE_INCLUDED_

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
  req.randomize();
  req.print();
  start_item(req);
  finish_item(req);
endtask : body

`endif
