`ifndef JTAGControllerDeviceTESTINGVIRTUALSEQUENCE_INCLUDED_
`define JTAGControllerDeviceTESTINGVIRTUALSEQUENCE_INCLUDED_

class JtagControllerDeviceTestingVirtualSequence extends JtagVirtualBaseSequence;
  `uvm_object_utils(JtagControllerDeviceTestingVirtualSequence)

  JtagControllerDeviceTestVectorSequence jtagControllerDeviceTestVectorSequence;
  JtagTargetDeviceBaseSequence  jtagTargetDeviceBaseSequence;
  JtagControllerDeviceAgentConfig jtagControllerDeviceAgentConfig;

  extern function new(string name = "JtagControllerDeviceTestingVirtualSequence");
  extern virtual task body();
  extern task setConfig(JtagControllerDeviceAgentConfig jtagControllerDeviceAgentConfig);
endclass : JtagControllerDeviceTestingVirtualSequence 


function JtagControllerDeviceTestingVirtualSequence ::new(string name = "JtagControllerDeviceTestingVirtualSequence");
  super.new(name);
endfunction  : new

task JtagControllerDeviceTestingVirtualSequence :: body();
  super.body();
  `uvm_do_on_with(jtagControllerDeviceTestVectorSequence,p_sequencer.jtagControllerDeviceSequencer,{numberOfTests == jtagControllerDeviceAgentConfig.NumberOfTests;})
endtask : body 

task JtagControllerDeviceTestingVirtualSequence :: setConfig(JtagControllerDeviceAgentConfig jtagControllerDeviceAgentConfig);
  this.jtagControllerDeviceAgentConfig = jtagControllerDeviceAgentConfig;
endtask : setConfig
 
`endif
