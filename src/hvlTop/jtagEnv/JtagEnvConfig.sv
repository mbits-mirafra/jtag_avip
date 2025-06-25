`ifndef JTAGENVCONFIG_INCLUDED_
`define JTAGENVCONFIG_INCLUDED_

class JtagEnvConfig extends uvm_object;
  `uvm_object_utils(JtagEnvConfig)

  JtagControllerDeviceAgentConfig jtagControllerDeviceAgentConfig;
  JtagTargetDeviceAgentConfig jtagTargetDeviceAgentConfig;

  bit hasScoreboard;
  bit hasVirtualSequencer;

  extern function new(string name = "JtagEnvConfig");

endclass : JtagEnvConfig

function JtagEnvConfig :: new(string name = "JtagEnvConfig");
  super.new(name);
endfunction : new

`endif
