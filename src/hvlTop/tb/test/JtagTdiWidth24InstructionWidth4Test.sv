
`ifndef JTAGTDIWidth24INSTRUCTIONWIDTH4TEST_INCLUDED_
`define JTAGTDIWidth24INSTRUCTIONWIDTH4TEST_INCLUDED_

class JtagTdiWidth24InstructionWidth4Test extends JtagBaseTest;
  `uvm_component_utils(JtagTdiWidth24InstructionWidth4Test)

  extern function new(string name = "JtagTdiWidth24InstructionWidth4Test" , uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase (uvm_phase phase);
endclass : JtagTdiWidth24InstructionWidth4Test

function JtagTdiWidth24InstructionWidth4Test :: new(string name = "JtagTdiWidth24InstructionWidth4Test" , uvm_component parent);
  super.new(name,parent);
endfunction : new


function void JtagTdiWidth24InstructionWidth4Test :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  jtagEnvConfig.jtagControllerDeviceAgentConfig.jtagTestVectorWidth = testVectorWidth24Bit;
  jtagEnvConfig.jtagControllerDeviceAgentConfig.jtagInstructionWidth = instructionWidth4Bit;
   jtagEnvConfig.jtagTargetDeviceAgentConfig.jtagTestVectorWidth = testVectorWidth24Bit;
   jtagEnvConfig.jtagTargetDeviceAgentConfig.jtagInstructionWidth = instructionWidth4Bit;
endfunction : build_phase



task JtagTdiWidth24InstructionWidth4Test :: run_phase(uvm_phase phase);
  jtagControllerDeviceTestingVirtualSequence = JtagControllerDeviceTestingVirtualSequence :: type_id :: create("JtagControllerDeviceTestingVirtualSequence");
  jtagControllerDeviceTestingVirtualSequence.setConfig(jtagEnvConfig.jtagControllerDeviceAgentConfig);
 
  phase.raise_objection(this);
  repeat( NO_OF_TESTS) begin 
  jtagControllerDeviceTestingVirtualSequence.start(jtagEnv.jtagVirtualSequencer);
  end 
  phase.drop_objection(this);

endtask : run_phase

`endif
