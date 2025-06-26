
`ifndef JTAG8BitPATTERNBASEDTEST_INCLUDED_
`define JTAG8BitPATTERNBASEDTEST_INCLUDED_

class Jtag8BitPatternBasedTest extends JtagBaseTest;
  `uvm_component_utils(Jtag8BitPatternBasedTest)

  extern function new(string name = "Jtag8BitPatternBasedTest" , uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase (uvm_phase phase);

 JtagControllerDevicePatternBasedVirtualSequence jtagControllerDevicePatternBasedVirtualSequence;
endclass : Jtag8BitPatternBasedTest

function Jtag8BitPatternBasedTest :: new(string name = "Jtag8BitPatternBasedTest" , uvm_component parent);
  super.new(name,parent);
endfunction : new


function void Jtag8BitPatternBasedTest :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  jtagEnvConfig.jtagControllerDeviceAgentConfig.jtagTestVectorWidth = testVectorWidth8Bit;
  jtagEnvConfig.jtagControllerDeviceAgentConfig.jtagInstructionWidth = instructionWidth4Bit;
   jtagEnvConfig.jtagTargetDeviceAgentConfig.jtagTestVectorWidth = testVectorWidth8Bit;
   jtagEnvConfig.jtagTargetDeviceAgentConfig.jtagInstructionWidth = instructionWidth4Bit;
   jtagEnvConfig.jtagControllerDeviceAgentConfig.patternNeeded = 8'b 10101010;
endfunction : build_phase



task Jtag8BitPatternBasedTest :: run_phase(uvm_phase phase);
  jtagControllerDevicePatternBasedVirtualSequence = JtagControllerDevicePatternBasedVirtualSequence :: type_id :: create("JtagControllerDevicePatternBasedVirtualSequence");
  jtagControllerDevicePatternBasedVirtualSequence.setConfig(jtagEnvConfig.jtagControllerDeviceAgentConfig);
 
  phase.raise_objection(this);
  repeat(NO_OF_TESTS) begin 
  jtagControllerDevicePatternBasedVirtualSequence.start(jtagEnv.jtagVirtualSequencer);
  end 
  phase.drop_objection(this);

endtask : run_phase

`endif
