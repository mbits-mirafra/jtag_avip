`ifndef JTAGTargetDeviceMONITOR_INCLUDED_
`define JTAGTargetDeviceMONITOR_INCLUDED_

class JtagTargetDeviceMonitor extends uvm_monitor; 
  `uvm_component_utils(JtagTargetDeviceMonitor)
  
  uvm_analysis_port #(JtagTargetDeviceTransaction)jtagTargetDeviceMonitorAnalysisPort;
  virtual JtagTargetDeviceMonitorBfm jtagTargetDeviceMonitorBfm;
  JtagTargetDeviceAgentConfig jtagTargetDeviceAgentConfig;
  JtagTargetDeviceTransaction jtagTargetDeviceTransaction;
  JtagConfigStruct jtagConfigStruct;
  JtagPacketStruct jtagPacketStruct;
  
  extern function new(string name = "JtagTargetDeviceMonitor" , uvm_component parent);
  extern virtual function void  build_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : JtagTargetDeviceMonitor

function JtagTargetDeviceMonitor :: new( string name = "JtagTargetDeviceMonitor" , uvm_component parent);
  super.new(name,parent);
endfunction : new


function void JtagTargetDeviceMonitor :: build_phase(uvm_phase phase);
  super.build_phase(phase);

  if(!(uvm_config_db #(JtagTargetDeviceAgentConfig) :: get(this,"","jtagTargetDeviceAgentConfig",jtagTargetDeviceAgentConfig)))
    `uvm_fatal(get_type_name(),"FAILED TP GET TargetDevice AGENT CONFIG IN TargetDevice MONITOR")

    if(!(uvm_config_db #(virtual JtagTargetDeviceMonitorBfm) :: get(this,"","jtagTargetDeviceMonitorBfm",jtagTargetDeviceMonitorBfm)))
    `uvm_fatal(get_type_name(),"FAILED TO GET THE TargetDevice MONITOR BFM IN TargetDevice MONITOR")

      jtagTargetDeviceTransaction = JtagTargetDeviceTransaction :: type_id :: create("jtagTargetDeviceTransaction");
  jtagTargetDeviceMonitorAnalysisPort = new("jtagTargetDeviceMonitorAnalysisPort",this);  
endfunction : build_phase

task JtagTargetDeviceMonitor :: run_phase(uvm_phase phase);
  super.run_phase(phase);
  forever begin 
    JtagTargetDeviceConfigConverter :: fromClass (jtagTargetDeviceAgentConfig , jtagConfigStruct);
 jtagPacketStruct.jtagTestVector = 64'b x;
 jtagTargetDeviceMonitorBfm.waitForReset();
 jtagTargetDeviceMonitorBfm.startMonitoring(jtagPacketStruct,jtagConfigStruct);
  JtagTargetDeviceSeqItemConverter :: toClass (jtagPacketStruct , jtagConfigStruct , jtagTargetDeviceTransaction);
  $display("*****************************************************************************************************************************************************************************************\n");
  $display("THE RECEIVED VECTOR IN TARGET IS %b and instruction is %b",jtagTargetDeviceTransaction.jtagTestVector,jtagTargetDeviceTransaction.jtagInstruction);
jtagTargetDeviceMonitorAnalysisPort.write(jtagTargetDeviceTransaction);
end 
endtask : run_phase
`endif
