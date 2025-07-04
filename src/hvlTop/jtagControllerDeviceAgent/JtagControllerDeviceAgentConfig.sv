`ifndef JTAGCONTROLLERDEVICEAGENTCONFIG_INCLUDED_
`define JTAGCONTROLLERDEVICEAGENTCONFIG_INCLUDED_

class JtagControllerDeviceAgentConfig extends uvm_object;
  `uvm_object_utils(JtagControllerDeviceAgentConfig)

  bit hasCoverage;
  uvm_active_passive_enum   is_active;
  rand JtagTestVectorWidthEnum   jtagTestVectorWidth;
  rand JtagInstructionWidthEnum  jtagInstructionWidth;
  rand JtagInstructionOpcodeEnum jtagInstructionOpcode;
  int NumberOfTests;
  logic[31:0]patternNeeded;
  bit trstEnable;

  extern function new(string name = "JtagControllerDeviceAgentConfig");
  extern function void do_print(uvm_printer printer);
endclass : JtagControllerDeviceAgentConfig

function JtagControllerDeviceAgentConfig :: new(string name = "JtagControllerDeviceAgentConfig");
  super.new(name);
endfunction : new

function void JtagControllerDeviceAgentConfig :: do_print(uvm_printer printer);
  super.do_print(printer);
  printer.print_field($sformatf("TDI WIDTH"),this.jtagTestVectorWidth,$bits(this.jtagTestVectorWidth),UVM_BIN);
  printer.print_field($sformatf("INSTRUCTION WIDTH"),this.jtagInstructionWidth,$bits(this.jtagInstructionWidth),UVM_BIN);
  printer.print_field($sformatf("INSTRUCTION "),this.jtagInstructionOpcode,$bits(this.jtagInstructionOpcode),UVM_BIN);
  printer.print_field($sformatf("hasCoverage"),this.hasCoverage,$bits(this.hasCoverage),UVM_BIN);
  printer.print_field($sformatf("Reset Enable"),this.trstEnable,$bits(this.trstEnable),UVM_BIN);
endfunction : do_print


`endif
