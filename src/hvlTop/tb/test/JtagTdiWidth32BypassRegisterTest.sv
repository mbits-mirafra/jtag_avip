
`ifndef JTAGTDIWIDTH32BYPASSREGISTERTEST_INCLUDED_
`define JTAGTDIWIDTH32BYPASSREGISTERTEST_INCLUDED_

class JtagTdiWidth32BypassRegisterTest extends JtagBaseTest;
  `uvm_component_utils(JtagTdiWidth32BypassRegisterTest)

  extern function new(string name = "JtagTdiWidth32BypassRegisterTest" , uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase (uvm_phase phase);
endclass : JtagTdiWidth32BypassRegisterTest


    function JtagTdiWidth32BypassRegisterTest :: new(string name = "JtagTdiWidth32BypassRegisterTest" , uvm_component parent);
  super.new(name,parent);
endfunction : new


function void JtagTdiWidth32BypassRegisterTest :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  jtagEnvConfig.jtagControllerDeviceAgentConfig.jtagTestVectorWidth = testVectorWidth32Bit;
  jtagEnvConfig.jtagControllerDeviceAgentConfig.jtagInstructionWidth = instructionWidth5Bit;
   jtagEnvConfig.jtagTargetDeviceAgentConfig.jtagTestVectorWidth = testVectorWidth32Bit;
   jtagEnvConfig.jtagTargetDeviceAgentConfig.jtagInstructionWidth = instructionWidth5Bit;
   jtagEnvConfig.jtagControllerDeviceAgentConfig.jtagInstructionOpcode = bypassRegister;
    jtagEnvConfig.jtagTargetDeviceAgentConfig.jtagInstructionOpcode = bypassRegister;
endfunction : build_phase



task  JtagTdiWidth32BypassRegisterTest :: run_phase(uvm_phase phase);
  jtagControllerDeviceTestingVirtualSequence = JtagControllerDeviceTestingVirtualSequence :: type_id :: create("JtagControllerDeviceTestingVirtualSequence");
  jtagControllerDeviceTestingVirtualSequence.setConfig(jtagEnvConfig.jtagControllerDeviceAgentConfig);
 
  phase.raise_objection(this);
  repeat( NO_OF_TESTS) begin 
  jtagControllerDeviceTestingVirtualSequence.start(jtagEnv.jtagVirtualSequencer);
  end 
  phase.drop_objection(this);

endtask : run_phase

`endif
