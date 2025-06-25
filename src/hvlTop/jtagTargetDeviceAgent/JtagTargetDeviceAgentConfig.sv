`ifndef JTAGTargetDeviceAGENTCONFIG_INCLUDED_
`define JTAGTargetDeviceAGENTCONFIG_INCLUDED_

class JtagTargetDeviceAgentConfig extends uvm_object;
  `uvm_object_utils(JtagTargetDeviceAgentConfig)

  bit hasCoverage;
  uvm_active_passive_enum is_active;
  JtagTestVectorWidthEnum jtagTestVectorWidth;
  JtagInstructionWidthEnum jtagInstructionWidth;
  JtagInstructionOpcodeEnum jtagInstructionOpcode;

  extern function new(string name = "JtagTargetDeviceAgentConfig");
endclass : JtagTargetDeviceAgentConfig

function JtagTargetDeviceAgentConfig :: new(string name = "JtagTargetDeviceAgentConfig");
  super.new(name);
endfunction  : new

`endif
