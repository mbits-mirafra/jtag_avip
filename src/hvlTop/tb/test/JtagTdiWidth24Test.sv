`ifndef JTAGTDIWidth24TEST_INCLUDED_
`define JTAGTDIWidth24TEST_INCLUDED_

class JtagTdiWidth24Test extends JtagBaseTest;
  `uvm_component_utils(JtagTdiWidth24Test)

  extern function new(string name = "JtagTdiWidth24Test" , uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase (uvm_phase phase);
endclass : JtagTdiWidth24Test

function JtagTdiWidth24Test :: new(string name = "JtagTdiWidth24Test" , uvm_component parent);
  super.new(name,parent);
endfunction : new

function void JtagTdiWidth24Test :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  jtagEnvConfig.jtagControllerDeviceAgentConfig.jtagTestVectorWidth = testVectorWidth24Bit;
  jtagEnvConfig.jtagControllerDeviceAgentConfig.jtagInstructionWidth = instructionWidth5Bit;
  jtagEnvConfig.jtagTargetDeviceAgentConfig.jtagTestVectorWidth = testVectorWidth24Bit;
  jtagEnvConfig.jtagTargetDeviceAgentConfig.jtagInstructionWidth = instructionWidth5Bit;
endfunction : build_phase

task  JtagTdiWidth24Test :: run_phase(uvm_phase phase);
  jtagVirtualControllerDeviceTestingSequence = JtagVirtualControllerDeviceTestingSequence :: type_id :: create("jtagVirtualControllerDeviceTestingSequence");
  jtagVirtualControllerDeviceTestingSequence.setConfig(jtagEnvConfig.jtagControllerDeviceAgentConfig);
 
  phase.raise_objection(this);
    jtagVirtualControllerDeviceTestingSequence.trstEnable = 'b 0;
    jtagVirtualControllerDeviceTestingSequence.start(jtagEnv.jtagVirtualSequencer);
    jtagVirtualControllerDeviceTestingSequence.trstEnable = 'b 1;
    repeat( NO_OF_TESTS) begin
      jtagVirtualControllerDeviceTestingSequence.start(jtagEnv.jtagVirtualSequencer);
    end
  phase.drop_objection(this);

endtask : run_phase

`endif



  
