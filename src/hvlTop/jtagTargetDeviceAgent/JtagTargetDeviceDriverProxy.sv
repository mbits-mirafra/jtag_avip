`ifndef JTAGTargetDeviceDRIVER_INCLUDED_
`define JTAGTargetDeviceDRIVER_INCLUDED_

class JtagTargetDeviceDriver extends uvm_driver#(JtagTargetDeviceTransaction);
  `uvm_component_utils(JtagTargetDeviceDriver)
  virtual JtagTargetDeviceDriverBfm jtagTargetDeviceDriverBfm;
  JtagTargetDeviceAgentConfig jtagTargetDeviceAgentConfig;
  JtagConfigStruct jtagConfigStruct;
  extern function new (string name = "JtagTargetDeviceDriver", uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
endclass : JtagTargetDeviceDriver

function JtagTargetDeviceDriver::new(string name = "JtagTargetDeviceDriver",uvm_component parent);
  super.new(name,parent);
endfunction  : new

function void JtagTargetDeviceDriver :: build_phase(uvm_phase phase);
  super.build_phase(phase);

  if(!(uvm_config_db #(JtagTargetDeviceAgentConfig) :: get(this,"","jtagTargetDeviceAgentConfig",jtagTargetDeviceAgentConfig)))
    `uvm_fatal(get_type_name(),"FAILED TO GET CONFIG IN TargetDevice DRIVER")

    if(!(uvm_config_db #(virtual JtagTargetDeviceDriverBfm) :: get(this,"","jtagTargetDeviceDriverBfm",jtagTargetDeviceDriverBfm)))
      `uvm_fatal(get_type_name(),"FAILED TO GET VIRTUAL POINTER TO TargetDevice DRIVERBFM IN TargetDevice DRIVER")
endfunction : build_phase

task JtagTargetDeviceDriver :: run_phase(uvm_phase phase);
  super.run_phase(phase);
  forever begin
  JtagTargetDeviceConfigConverter ::fromClass(jtagTargetDeviceAgentConfig ,jtagConfigStruct);
  jtagTargetDeviceDriverBfm.waitForReset();
  jtagTargetDeviceDriverBfm.observeData(jtagConfigStruct);
  end 
endtask : run_phase

`endif
