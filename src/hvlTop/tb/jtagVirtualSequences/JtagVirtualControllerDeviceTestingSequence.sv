`ifndef JTAGCONTROLLERDEVICETESTINGVIRTUALSEQUENCE_INCLUDED_
`define JTAGCONTROLLERDEVICETESTINGVIRTUALSEQUENCE_INCLUDED_

class JtagVirtualControllerDeviceTestingSequence extends JtagVirtualBaseSequence;
  `uvm_object_utils(JtagControllerDeviceTestingVirtualSequence)

  JtagControllerDeviceTestVectorSequence jtagControllerDeviceTestVectorSequence;
  JtagTargetDeviceBaseSequence  jtagTargetDeviceBaseSequence;
  JtagControllerDeviceAgentConfig jtagControllerDeviceAgentConfig;

  extern function new(string name = "JtagVirtualControllerDeviceTestingSequence");
  extern virtual task body();
  extern task setConfig(JtagControllerDeviceAgentConfig jtagControllerDeviceAgentConfig);
endclass : JtagVirtualControllerDeviceTestingSequence 


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
