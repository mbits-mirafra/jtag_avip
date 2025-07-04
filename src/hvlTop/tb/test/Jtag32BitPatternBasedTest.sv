`ifndef JTAG32BitPATTERNBASEDTEST_INCLUDED_
`define JTAG32BitPATTERNBASEDTEST_INCLUDED_

class Jtag32BitPatternBasedTest extends JtagBaseTest;
  `uvm_component_utils(Jtag32BitPatternBasedTest)

  extern function new(string name = "Jtag32BitPatternBasedTest" , uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase (uvm_phase phase);

  JtagVirtualControllerDevicePatternBasedSequence jtagVirtualControllerDevicePatternBasedSequence;
endclass : Jtag32BitPatternBasedTest

function Jtag32BitPatternBasedTest :: new(string name = "Jtag32BitPatternBasedTest" , uvm_component parent);
  super.new(name,parent);
endfunction : new

function void Jtag32BitPatternBasedTest :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  jtagEnvConfig.jtagControllerDeviceAgentConfig.jtagTestVectorWidth = testVectorWidth32Bit;
  jtagEnvConfig.jtagControllerDeviceAgentConfig.jtagInstructionWidth = instructionWidth4Bit;
  jtagEnvConfig.jtagTargetDeviceAgentConfig.jtagTestVectorWidth = testVectorWidth32Bit;
  jtagEnvConfig.jtagTargetDeviceAgentConfig.jtagInstructionWidth = instructionWidth4Bit;
  jtagEnvConfig.jtagControllerDeviceAgentConfig.patternNeeded = 32'b 10101010;
endfunction : build_phase

task Jtag32BitPatternBasedTest :: run_phase(uvm_phase phase);
  jtagVirtualControllerDevicePatternBasedSequence = JtagVirtualControllerDevicePatternBasedSequence :: type_id :: create("jtagVirtualControllerDevicePatternBasedSequence");
  jtagVirtualControllerDevicePatternBasedSequence.setConfig(jtagEnvConfig.jtagControllerDeviceAgentConfig);
 
  phase.raise_objection(this);
  jtagVirtualControllerDevicePatternBasedSequence.trstEnable = 'b 0;
  jtagVirtualControllerDevicePatternBasedSequence.start(jtagEnv.jtagVirtualSequencer);
  jtagVirtualControllerDevicePatternBasedSequence.trstEnable = 'b 1;
  repeat( NO_OF_TESTS) begin
    jtagVirtualControllerDevicePatternBasedSequence.start(jtagEnv.jtagVirtualSequencer);
  end
  phase.drop_objection(this);

endtask : run_phase

`endif
