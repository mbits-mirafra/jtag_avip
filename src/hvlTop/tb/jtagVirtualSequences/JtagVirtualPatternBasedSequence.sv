
`ifndef JTAGControllerDevicePATTERNBASEDVIRTUALSEQUENCE_INCLUDED_
`define JTAGControllerDevicePATTERNBASEDVIRTUALSEQUENCE_INCLUDED_

class JtagControllerDevicePatternBasedVirtualSequence extends JtagVirtualBaseSequence;
  `uvm_object_utils(JtagControllerDevicePatternBasedVirtualSequence)

  JtagControllerDevicePatternBasedSequence jtagControllerDevicePatternBasedSequence;
  JtagTargetDeviceBaseSequence  jtagTargetDeviceBaseSequence;
  JtagControllerDeviceAgentConfig jtagControllerDeviceAgentConfig;

  extern function new(string name = "JtagControllerDevicePatternBasedVirtualSequence");
  extern virtual task body();
  extern task setConfig(JtagControllerDeviceAgentConfig jtagControllerDeviceAgentConfig);
endclass : JtagControllerDevicePatternBasedVirtualSequence 


function JtagControllerDevicePatternBasedVirtualSequence ::new(string name = "JtagControllerDevicePatternBasedVirtualSequence");
  super.new(name);
endfunction  : new

task JtagControllerDevicePatternBasedVirtualSequence :: body();
  super.body();
  `uvm_do_on_with(jtagControllerDevicePatternBasedSequence,p_sequencer.jtagControllerDeviceSequencer,{patternNeeded == jtagControllerDeviceAgentConfig.patternNeeded;})
endtask : body 

task JtagControllerDevicePatternBasedVirtualSequence :: setConfig(JtagControllerDeviceAgentConfig jtagControllerDeviceAgentConfig);
  this.jtagControllerDeviceAgentConfig = jtagControllerDeviceAgentConfig;
endtask : setConfig
 
`endif
