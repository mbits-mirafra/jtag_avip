`ifndef JTAGTDIWidth16INSTRUCTIONWIDTH3TEST_INCLUDED_
`define JTAGTDIWidth16INSTRUCTIONWIDTH3TEST_INCLUDED_

class JtagTdiWidth16InstructionWidth3Test extends JtagBaseTest;
  `uvm_component_utils(JtagTdiWidth16InstructionWidth3Test)

  extern function new(string name = "JtagTdiWidth16InstructionWidth3Test" , uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase (uvm_phase phase);
endclass : JtagTdiWidth16InstructionWidth3Test

function JtagTdiWidth16InstructionWidth3Test :: new(string name = "JtagTdiWidth16InstructionWidth3Test" , uvm_component parent);
  super.new(name,parent);
endfunction : new

function void JtagTdiWidth16InstructionWidth3Test :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  jtagEnvConfig.jtagControllerDeviceAgentConfig.jtagTestVectorWidth = testVectorWidth16Bit;
  jtagEnvConfig.jtagControllerDeviceAgentConfig.jtagInstructionWidth = instructionWidth3Bit;
  jtagEnvConfig.jtagTargetDeviceAgentConfig.jtagTestVectorWidth = testVectorWidth16Bit;
  jtagEnvConfig.jtagTargetDeviceAgentConfig.jtagInstructionWidth = instructionWidth3Bit;
endfunction : build_phase

task JtagTdiWidth16InstructionWidth3Test :: run_phase(uvm_phase phase);
  jtagVirtualControllerDeviceTestingSequence = JtagVirtualControllerDeviceTestingSequence :: type_id :: create("jtagVirtualControllerDeviceTestingSequence");
  jtagVirtualControllerDeviceTestingSequence.setConfig(jtagEnvConfig.jtagControllerDeviceAgentConfig);
 
  phase.raise_objection(this);
  repeat( NO_OF_TESTS) begin 
    jtagVirtualControllerDeviceTestingSequence.start(jtagEnv.jtagVirtualSequencer);
  end 
  phase.drop_objection(this);

endtask : run_phase

`endif
