`ifndef JTAGTARGETDEVICEAGENTCONFIG_INCLUDED_
`define JTAGTARGETDEVICEAGENTCONFIG_INCLUDED_

class JtagTargetDeviceAgentConfig extends uvm_object;
  `uvm_object_utils(JtagTargetDeviceAgentConfig)

  bit hasCoverage;
  uvm_active_passive_enum is_active;
  JtagTestVectorWidthEnum jtagTestVectorWidth;
  JtagInstructionWidthEnum jtagInstructionWidth;
  JtagInstructionOpcodeEnum jtagInstructionOpcode;

  extern function new(string name = "JtagTargetDeviceAgentConfig");
  extern function void do_print(uvm_printer printer);

endclass : JtagTargetDeviceAgentConfig

function JtagTargetDeviceAgentConfig :: new(string name = "JtagTargetDeviceAgentConfig");
  super.new(name);
endfunction  : new

function void JtagTargetDeviceAgentConfig :: do_print(uvm_printer printer);
  super.do_print(printer);
  printer.print_field($sformatf("TDI WIDTH"),this.jtagTestVectorWidth,$bits(this.jtagTestVectorWidth),UVM_BIN);
  printer.print_field($sformatf("INSTRUCTION WIDTH"),this.jtagInstructionWidth,$bits(this.jtagInstructionWidth),UVM_BIN);
  printer.print_field($sformatf("INSTRUCTION "),this.jtagInstructionOpcode,$bits(this.jtagInstructionOpcode),UVM_BIN);
  printer.print_field($sformatf("hasCoverage"),this.hasCoverage,$bits(this.hasCoverage),UVM_BIN);
endfunction : do_print

`endif
