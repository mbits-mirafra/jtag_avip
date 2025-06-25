`ifndef JTAGTargetDeviceAGENT_INCLUDED_
`define JTAGTargetDeviceAGENT_INCLUDED_

class JtagTargetDeviceAgent extends uvm_agent;
  `uvm_component_utils(JtagTargetDeviceAgent)

  uvm_analysis_port #(JtagTargetDeviceTransaction) jtagTargetDeviceAnalysisPort;
  JtagTargetDeviceCoverage jtagTargetDeviceCoverage;
  JtagTargetDeviceMonitor jtagTargetDeviceMonitor;
  JtagTargetDeviceDriver jtagTargetDeviceDriver;
  JtagTargetDeviceAgentConfig jtagTargetDeviceAgentConfig;
  JtagTargetDeviceSequencer jtagTargetDeviceSequencer;
  extern function new(string name = "JtagTargetDeviceAgent" , uvm_component parent);
  extern virtual function void  build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
endclass : JtagTargetDeviceAgent 

function JtagTargetDeviceAgent::new(string name = "JtagTargetDeviceAgent",uvm_component parent);
  super.new(name,parent);
endfunction : new

function void JtagTargetDeviceAgent::build_phase(uvm_phase phase);
  super.build_phase(phase);

  if(!(uvm_config_db #(JtagTargetDeviceAgentConfig) :: get(this,"","jtagTargetDeviceAgentConfig",jtagTargetDeviceAgentConfig)))
    `uvm_fatal(get_type_name(),"FAILED TO GET TargetDevice CONFIG")

  if(jtagTargetDeviceAgentConfig.is_active == UVM_ACTIVE ) begin 
    jtagTargetDeviceDriver = JtagTargetDeviceDriver  :: type_id :: create("jtagTargetDeviceDriver",this);
    jtagTargetDeviceSequencer  = JtagTargetDeviceSequencer :: type_id :: create("jtagTargetDeviceSequencer",this);
  end 
   
  if(jtagTargetDeviceAgentConfig.hasCoverage==1) begin 
    jtagTargetDeviceCoverage = JtagTargetDeviceCoverage  :: type_id ::create("jtagTargetDeviceCoverage",this);
  end 

  jtagTargetDeviceMonitor = JtagTargetDeviceMonitor :: type_id :: create("jtagTargetDeviceMonitor",this);
  jtagTargetDeviceAnalysisPort = new("jtagTargetDeviceAnalysisPort",this);
endfunction :  build_phase

function void JtagTargetDeviceAgent :: connect_phase(uvm_phase phase);
  super.connect_phase(phase);

  if(jtagTargetDeviceAgentConfig.is_active ==UVM_ACTIVE ) begin 
    jtagTargetDeviceDriver.seq_item_port.connect(jtagTargetDeviceSequencer.seq_item_export);
  end 

  if(jtagTargetDeviceAgentConfig.hasCoverage ==1) begin
    jtagTargetDeviceMonitor.jtagTargetDeviceMonitorAnalysisPort.connect(jtagTargetDeviceCoverage.analysis_export);
  end   

  jtagTargetDeviceMonitor.jtagTargetDeviceMonitorAnalysisPort.connect(this.jtagTargetDeviceAnalysisPort);

endfunction  : connect_phase
`endif
