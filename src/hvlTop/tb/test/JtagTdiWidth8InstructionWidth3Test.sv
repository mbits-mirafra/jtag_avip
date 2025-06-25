
`ifndef JTAGTDIWidth8INSTRUCTIONWIDTH3TEST_INCLUDED_
`define JTAGTDIWidth8INSTRUCTIONWIDTH3TEST_INCLUDED_

class JtagTdiWidth8InstructionWidth3Test extends JtagBaseTest;
  `uvm_component_utils(JtagTdiWidth8InstructionWidth3Test)

  extern function new(string name = "JtagTdiWidth8InstructionWidth3Test" , uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase (uvm_phase phase);
endclass : JtagTdiWidth8InstructionWidth3Test

function JtagTdiWidth8InstructionWidth3Test :: new(string name = "JtagTdiWidth8InstructionWidth3Test" , uvm_component parent);
  super.new(name,parent);
endfunction : new


function void JtagTdiWidth8InstructionWidth3Test :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  jtagEnvConfig.jtagControllerDeviceAgentConfig.jtagTestVectorWidth = testVectorWidth8Bit;
  jtagEnvConfig.jtagControllerDeviceAgentConfig.jtagInstructionWidth = instructionWidth3Bit;
   jtagEnvConfig.jtagTargetDeviceAgentConfig.jtagTestVectorWidth = testVectorWidth8Bit;
   jtagEnvConfig.jtagTargetDeviceAgentConfig.jtagInstructionWidth = instructionWidth3Bit;
endfunction : build_phase



task JtagTdiWidth8InstructionWidth3Test :: run_phase(uvm_phase phase);
  jtagControllerDeviceTestingVirtualSequence = JtagControllerDeviceTestingVirtualSequence :: type_id :: create("JtagControllerDeviceTestingVirtualSequence");
  jtagControllerDeviceTestingVirtualSequence.setConfig(jtagEnvConfig.jtagControllerDeviceAgentConfig);
 
  phase.raise_objection(this);
  repeat( NO_OF_TESTS) begin 
  jtagControllerDeviceTestingVirtualSequence.start(jtagEnv.jtagVirtualSequencer);
  end 
  phase.drop_objection(this);

endtask : run_phase

`endif
