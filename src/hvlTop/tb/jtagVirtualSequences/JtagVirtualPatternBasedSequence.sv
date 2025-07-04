`ifndef JTAGCONTROLLERDEVICEPATTERNBASEDVIRTUALSEQUENCE_INCLUDED_
`define JTAGCONTROLLERDEVICEPATTERNBASEDVIRTUALSEQUENCE_INCLUDED_

class JtagVirtualControllerDevicePatternBasedSequence extends JtagVirtualBaseSequence;
  `uvm_object_utils(JtagVirtualControllerDevicePatternBasedSequence)
  logic trstEnable;
  JtagControllerDevicePatternBasedSequence jtagControllerDevicePatternBasedSequence;
  JtagTargetDeviceBaseSequence  jtagTargetDeviceBaseSequence;
  JtagControllerDeviceAgentConfig jtagControllerDeviceAgentConfig;

  extern function new(string name = "JtagVirtualControllerDevicePatternBasedSequence");
  extern virtual task body();
  extern task setConfig(JtagControllerDeviceAgentConfig jtagControllerDeviceAgentConfig);
endclass : JtagVirtualControllerDevicePatternBasedSequence 


function JtagVirtualControllerDevicePatternBasedSequence ::new(string name = "JtagVirtualControllerDevicePatternBasedSequence");
  super.new(name);
endfunction  : new

task JtagVirtualControllerDevicePatternBasedSequence :: body();
  super.body();
  `uvm_do_on_with(jtagControllerDevicePatternBasedSequence,p_sequencer.jtagControllerDeviceSequencer,{patternNeeded == jtagControllerDeviceAgentConfig.patternNeeded;tresetEnable == trstEnable;})
endtask : body 

task JtagVirtualControllerDevicePatternBasedSequence :: setConfig(JtagControllerDeviceAgentConfig jtagControllerDeviceAgentConfig);
  this.jtagControllerDeviceAgentConfig = jtagControllerDeviceAgentConfig;
endtask : setConfig
 
`endif
