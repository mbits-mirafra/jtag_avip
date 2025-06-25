`ifndef JTAGControllerDeviceAGENT_INCLUDED_
`define JTAGControllerDeviceAGENT_INCLUDED_

class JtagControllerDeviceAgent extends uvm_agent;
  `uvm_component_utils(JtagControllerDeviceAgent)

  uvm_analysis_port #(JtagControllerDeviceTransaction) jtagControllerDeviceAnalysisPort;

  JtagControllerDeviceAgentConfig jtagControllerDeviceAgentConfig;

  JtagControllerDeviceDriver jtagControllerDeviceDriver;
 
  JtagControllerDeviceMonitor jtagControllerDeviceMonitor;

  JtagControllerDeviceSequencer jtagControllerDeviceSequencer;

  JtagControllerDeviceCoverage jtagControllerDeviceCoverage;


  extern function new(string name ="JtagControllerDeviceAgent", uvm_component parent);
  
  extern virtual function void build_phase(uvm_phase phase);

  extern virtual function void connect_phase(uvm_phase phase);

endclass : JtagControllerDeviceAgent

function JtagControllerDeviceAgent :: new(string name ="JtagControllerDeviceAgent", uvm_component parent);
  super.new(name , parent);
endfunction  : new

function void  JtagControllerDeviceAgent ::build_phase (uvm_phase phase);
  super.build_phase(phase);

  if(!(uvm_config_db #(JtagControllerDeviceAgentConfig) :: get(this ,"","jtagControllerDeviceAgentConfig",jtagControllerDeviceAgentConfig)))
    `uvm_fatal(get_type_name(),"FAILED TO GET AGENT CONFIG IN ControllerDevice")

  

  if(jtagControllerDeviceAgentConfig.is_active == UVM_ACTIVE) begin 
    jtagControllerDeviceDriver = JtagControllerDeviceDriver :: type_id :: create("jtagControllerDeviceDriver",this);
    jtagControllerDeviceSequencer = JtagControllerDeviceSequencer :: type_id :: create("jtagControllerDeviceSequencer",this);
  end 

  jtagControllerDeviceMonitor = JtagControllerDeviceMonitor :: type_id :: create("jtagControllerDeviceMonitor",this);

  if(jtagControllerDeviceAgentConfig.hasCoverage == 1) begin 
   jtagControllerDeviceCoverage = JtagControllerDeviceCoverage :: type_id :: create("jtagControllerDeviceCoverage",this);
  end

  jtagControllerDeviceAnalysisPort = new("jtagControllerDeviceAnalysisPort",this);
endfunction  : build_phase

function void JtagControllerDeviceAgent :: connect_phase(uvm_phase phase);
  super.connect_phase(phase);

  if(jtagControllerDeviceAgentConfig.is_active == UVM_ACTIVE) begin 
    $display("CONNECTING DRIVER AND SEQUENCER");
    jtagControllerDeviceDriver.seq_item_port.connect(jtagControllerDeviceSequencer.seq_item_export);
  end  

  if(jtagControllerDeviceAgentConfig.hasCoverage ==1) begin 
  jtagControllerDeviceMonitor.jtagControllerDeviceMonitorAnalysisPort.connect(jtagControllerDeviceCoverage.analysis_export);
  end 

  jtagControllerDeviceMonitor.jtagControllerDeviceMonitorAnalysisPort.connect(this.jtagControllerDeviceAnalysisPort);
endfunction : connect_phase
`endif
