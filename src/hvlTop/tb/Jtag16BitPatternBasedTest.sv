

`ifndef JTAG16BitPATTERNBASEDTEST_INCLUDED_
`define JTAG16BitPATTERNBASEDTEST_INCLUDED_

class Jtag16BitPatternBasedTest extends JtagBaseTest;
  `uvm_component_utils(Jtag16BitPatternBasedTest)

  extern function new(string name = "Jtag16BitPatternBasedTest" , uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase (uvm_phase phase);

 JtagControllerDevicePatternBasedVirtualSequence jtagControllerDevicePatternBasedVirtualSequence;
endclass : Jtag16BitPatternBasedTest

function Jtag16BitPatternBasedTest :: new(string name = "Jtag16BitPatternBasedTest" , uvm_component parent);
  super.new(name,parent);
endfunction : new


function void Jtag16BitPatternBasedTest :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  jtagEnvConfig.jtagControllerDeviceAgentConfig.jtagTestVectorWidth = testVectorWidth16Bit;
  jtagEnvConfig.jtagControllerDeviceAgentConfig.jtagInstructionWidth = instructionWidth4Bit;
   jtagEnvConfig.jtagTargetDeviceAgentConfig.jtagTestVectorWidth = testVectorWidth16Bit;
   jtagEnvConfig.jtagTargetDeviceAgentConfig.jtagInstructionWidth = instructionWidth4Bit;
   jtagEnvConfig.jtagControllerDeviceAgentConfig.patternNeeded = 16'b 10101010;
endfunction : build_phase



task Jtag16BitPatternBasedTest :: run_phase(uvm_phase phase);
  jtagControllerDevicePatternBasedVirtualSequence = JtagControllerDevicePatternBasedVirtualSequence :: type_id :: create("JtagControllerDevicePatternBasedVirtualSequence");
  jtagControllerDevicePatternBasedVirtualSequence.setConfig(jtagEnvConfig.jtagControllerDeviceAgentConfig);
 
  phase.raise_objection(this);
  repeat( NO_OF_TESTS) begin 
  jtagControllerDevicePatternBasedVirtualSequence.start(jtagEnv.jtagVirtualSequencer);
  end 
  phase.drop_objection(this);

endtask : run_phase

`endif
