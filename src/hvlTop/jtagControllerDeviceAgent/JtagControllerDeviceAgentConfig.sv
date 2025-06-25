`ifndef JTAGControllerDeviceAGENTCONFIG_INCLUDED_
`define JTAGControllerDeviceAGENTCONFIG_INCLUDED_

class JtagControllerDeviceAgentConfig extends uvm_object;

  `uvm_object_utils(JtagControllerDeviceAgentConfig)

  bit hasCoverage;
  uvm_active_passive_enum   is_active;
  rand JtagTestVectorWidthEnum   jtagTestVectorWidth;
  rand JtagInstructionWidthEnum  jtagInstructionWidth;
  rand JtagInstructionOpcodeEnum jtagInstructionOpcode;
  int NumberOfTests;
  logic[31:0]patternNeeded;

  extern function new(string name = "JtagControllerDeviceAgentConfig");

endclass : JtagControllerDeviceAgentConfig

function JtagControllerDeviceAgentConfig :: new(string name = "JtagControllerDeviceAgentConfig");
  super.new(name);
endfunction : new
`endif
