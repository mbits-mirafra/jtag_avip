`ifndef UARTControllerDeviceMONITOR_INCLUDED_
`define UARTControllerDeviceMONITOR_INCLUDED_

class JtagControllerDeviceMonitor extends uvm_monitor; 
  `uvm_component_utils(JtagControllerDeviceMonitor)
  
  uvm_analysis_port #(JtagControllerDeviceTransaction)jtagControllerDeviceMonitorAnalysisPort;
  virtual JtagControllerDeviceMonitorBfm jtagControllerDeviceMonitorBfm;
  JtagControllerDeviceAgentConfig jtagControllerDeviceAgentConfig;
  JtagPacketStruct jtagPacketStruct;
  JtagConfigStruct jtagConfigStruct;
  JtagControllerDeviceTransaction jtagControllerDeviceTransaction;
  extern function new(string name = "JtagControllerDeviceMonitor" , uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : JtagControllerDeviceMonitor

function JtagControllerDeviceMonitor :: new( string name = "JtagControllerDeviceMonitor" , uvm_component parent);
  super.new(name,parent);
endfunction : new


function void JtagControllerDeviceMonitor :: build_phase(uvm_phase phase);
  super.build_phase(phase);

  if(!(uvm_config_db #(JtagControllerDeviceAgentConfig) :: get(this,"","jtagControllerDeviceAgentConfig",jtagControllerDeviceAgentConfig)))
    `uvm_fatal(get_type_name(),"FAILED TP GET ControllerDevice AGENT CONFIG IN ControllerDevice MONITOR")

  if(!(uvm_config_db #(virtual JtagControllerDeviceMonitorBfm) :: get(this,"","jtagControllerDeviceMonitorBfm",jtagControllerDeviceMonitorBfm)))
    `uvm_fatal(get_type_name(),"FAILED TO GET THE ControllerDevice MONITOR BFM IN ControllerDevice MONITOR")
  
  jtagControllerDeviceTransaction = JtagControllerDeviceTransaction :: type_id :: create("jtagControllerDeviceTransaction");
  jtagControllerDeviceMonitorAnalysisPort = new("jtagControllerDeviceMonitorAnalysisPort",this);

endfunction : build_phase

task JtagControllerDeviceMonitor :: run_phase(uvm_phase phase);
  super.run_phase(phase);
  forever begin 
  JtagControllerDeviceConfigConverter :: fromClass (jtagControllerDeviceAgentConfig , jtagConfigStruct);
  jtagPacketStruct.jtagTestVector=64'b x;
  jtagControllerDeviceMonitorBfm.waitForReset();
  jtagControllerDeviceMonitorBfm.startMonitoring(jtagPacketStruct,jtagConfigStruct);
  JtagControllerDeviceSeqItemConverter :: toClass (jtagPacketStruct , jtagConfigStruct , jtagControllerDeviceTransaction);
  
  $display("THE RECEIVED VECTOR IN CONTROLLER SIDE IS %b AND INSTRUCTION IS %b\n",jtagControllerDeviceTransaction.jtagTestVector,jtagControllerDeviceTransaction.jtagInstruction);
  $display("****************************************************************************************************************************************************************");

  jtagControllerDeviceMonitorAnalysisPort.write(jtagControllerDeviceTransaction);
end 
endtask : run_phase

`endif
