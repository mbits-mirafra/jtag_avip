`ifndef JTAGCONTROLLERDEVICETESTINGVIRTUALSEQUENCE_INCLUDED_
`define JTAGCONTROLLERDEVICETESTINGVIRTUALSEQUENCE_INCLUDED_

class JtagVirtualControllerDeviceTestingSequence extends JtagVirtualBaseSequence;
  `uvm_object_utils(JtagVirtualControllerDeviceTestingSequence)

  JtagControllerDeviceTestVectorSequence jtagControllerDeviceTestVectorSequence;
  JtagTargetDeviceBaseSequence  jtagTargetDeviceBaseSequence;
  JtagControllerDeviceAgentConfig jtagControllerDeviceAgentConfig;

  extern function new(string name = "JtagVirtualControllerDeviceTestingSequence");
  extern virtual task body();
  extern task setConfig(JtagControllerDeviceAgentConfig jtagControllerDeviceAgentConfig);
endclass : JtagVirtualControllerDeviceTestingSequence 


function JtagVirtualControllerDeviceTestingSequence ::new(string name = "JtagVirtualControllerDeviceTestingSequence");
  super.new(name);
endfunction  : new

task JtagVirtualControllerDeviceTestingSequence :: body();
  super.body();
  `uvm_do_on_with(jtagControllerDeviceTestVectorSequence,p_sequencer.jtagControllerDeviceSequencer,{numberOfTests == jtagControllerDeviceAgentConfig.NumberOfTests;})
endtask : body 

task JtagVirtualControllerDeviceTestingSequence :: setConfig(JtagControllerDeviceAgentConfig jtagControllerDeviceAgentConfig);
  this.jtagControllerDeviceAgentConfig = jtagControllerDeviceAgentConfig;
endtask : setConfig
 
`endif
