`ifndef JTAGBASETEST_INCLUDED_
`define JTAGBASETEST_INCLUDED_

class JtagBaseTest extends uvm_test;
  `uvm_component_utils(JtagBaseTest)

  JtagControllerDeviceTestingVirtualSequence jtagControllerDeviceTestingVirtualSequence;
  JtagEnv jtagEnv;
  JtagEnvConfig jtagEnvConfig;
  
  extern function new(string name = "JtagBaseTest" , uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern function void setupJtagEnvConfig();
  extern function void setupJtagControllerDeviceAgentConfig();
  extern function void setupJtagTargetDeviceAgentConfig();
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual task run_phase (uvm_phase phase);
endclass : JtagBaseTest


function JtagBaseTest :: new(string name = "JtagBaseTest" , uvm_component parent);
  super.new(name,parent);
endfunction : new


function void JtagBaseTest :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  setupJtagEnvConfig();
  jtagEnv = JtagEnv :: type_id :: create("jtagEnv",this);
endfunction : build_phase

function void  JtagBaseTest :: setupJtagEnvConfig();
  jtagEnvConfig = JtagEnvConfig :: type_id :: create("jtagEnvConfig");
  jtagEnvConfig.hasScoreboard = 1 ;
  jtagEnvConfig.hasVirtualSequencer = 1;
  uvm_config_db #(JtagEnvConfig) :: set(this,"*", "jtagEnvConfig",jtagEnvConfig);
  setupJtagControllerDeviceAgentConfig();
  setupJtagTargetDeviceAgentConfig();
endfunction : setupJtagEnvConfig

function void  JtagBaseTest :: setupJtagControllerDeviceAgentConfig();
  jtagEnvConfig.jtagControllerDeviceAgentConfig = JtagControllerDeviceAgentConfig :: type_id :: create("jtagControllerDeviceAgentConfig");
  jtagEnvConfig.jtagControllerDeviceAgentConfig.hasCoverage =1;
  jtagEnvConfig.jtagControllerDeviceAgentConfig.is_active = UVM_ACTIVE;
  jtagEnvConfig.jtagControllerDeviceAgentConfig.jtagTestVectorWidth = testVectorWidth32Bit;
  jtagEnvConfig.jtagControllerDeviceAgentConfig.jtagInstructionWidth = instructionWidth3Bit;
  jtagEnvConfig.jtagControllerDeviceAgentConfig.jtagInstructionOpcode = boundaryScanRegisters;


  uvm_config_db #(JtagControllerDeviceAgentConfig) :: set(null,"*", "jtagControllerDeviceAgentConfig",jtagEnvConfig.jtagControllerDeviceAgentConfig);

endfunction : setupJtagControllerDeviceAgentConfig

function void  JtagBaseTest :: setupJtagTargetDeviceAgentConfig();
 jtagEnvConfig.jtagTargetDeviceAgentConfig = JtagTargetDeviceAgentConfig :: type_id :: create("jtagTargetDeviceAgentConfig");
 jtagEnvConfig.jtagTargetDeviceAgentConfig.hasCoverage =1;
 jtagEnvConfig.jtagTargetDeviceAgentConfig.is_active = UVM_ACTIVE;
 jtagEnvConfig.jtagTargetDeviceAgentConfig.jtagTestVectorWidth = testVectorWidth32Bit;
 jtagEnvConfig.jtagTargetDeviceAgentConfig.jtagInstructionWidth = instructionWidth3Bit;
 jtagEnvConfig.jtagTargetDeviceAgentConfig.jtagInstructionOpcode =  boundaryScanRegisters;
  uvm_config_db #(JtagTargetDeviceAgentConfig) :: set(null,"*", "jtagTargetDeviceAgentConfig",jtagEnvConfig.jtagTargetDeviceAgentConfig);
endfunction : setupJtagTargetDeviceAgentConfig

function void JtagBaseTest :: end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  uvm_top.print_topology();
endfunction :  end_of_elaboration_phase

task  JtagBaseTest :: run_phase(uvm_phase phase);
  jtagControllerDeviceTestingVirtualSequence = JtagControllerDeviceTestingVirtualSequence :: type_id :: create("JtagControllerDeviceTestingVirtualSequence");
  jtagControllerDeviceTestingVirtualSequence.setConfig(jtagEnvConfig.jtagControllerDeviceAgentConfig);
 
  phase.raise_objection(this);
  repeat( NO_OF_TESTS) begin 
  jtagControllerDeviceTestingVirtualSequence.start(jtagEnv.jtagVirtualSequencer);
  end 
  phase.drop_objection(this);

endtask : run_phase

`endif



  
