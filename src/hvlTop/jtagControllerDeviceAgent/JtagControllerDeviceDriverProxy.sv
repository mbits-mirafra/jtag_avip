`ifndef JTAGControllerDeviceDRIVER_INCLUDED_
`define JTAGControllerDeviceDRIVER_INCLUDED_

class JtagControllerDeviceDriver extends uvm_driver#(JtagControllerDeviceTransaction);
  `uvm_component_utils(JtagControllerDeviceDriver)
  virtual JtagControllerDeviceDriverBfm jtagControllerDeviceDriverBfm;
  JtagControllerDeviceAgentConfig jtagControllerDeviceAgentConfig;
  JtagConfigStruct jtagConfigStruct;
  JtagPacketStruct jtagPacketStruct;
  extern function new (string name = "JtagControllerDeviceDriver", uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
endclass : JtagControllerDeviceDriver

function JtagControllerDeviceDriver::new(string name = "JtagControllerDeviceDriver",uvm_component parent);
  super.new(name,parent);
endfunction  : new

function void JtagControllerDeviceDriver :: build_phase(uvm_phase phase);
  super.build_phase(phase);

  if(!(uvm_config_db #(JtagControllerDeviceAgentConfig) :: get(this,"","jtagControllerDeviceAgentConfig",jtagControllerDeviceAgentConfig)))
    `uvm_fatal(get_type_name(),"FAILED TO GET CONFIG IN ControllerDevice DRIVER")

    if(!(uvm_config_db #(virtual JtagControllerDeviceDriverBfm) :: get(this,"","jtagControllerDeviceDriverBfm",jtagControllerDeviceDriverBfm)))
      `uvm_fatal(get_type_name(),"FAILED TO GET VIRTUAL POINTER TO ControllerDevice DRIVERBFM IN ControllerDevice DRIVER")
endfunction : build_phase

task JtagControllerDeviceDriver :: run_phase(uvm_phase phase);
  super.run_phase(phase);
  JtagControllerDeviceConfigConverter :: fromClass(jtagControllerDeviceAgentConfig,jtagConfigStruct);
 
  $display("ENTERED TO DRIVER PROXY SUCCESSFULLY");
  forever begin 
  seq_item_port.get_next_item(req);
 
  $display("\nTHE CONFIG FOR THE CONTROLLER DEVICE ARE: \nTHE TEST VECTOR WIDTH IS %0d \nTHE INSTRUCTION WIDTH IS %0d\n",jtagConfigStruct.jtagTestVectorWidth,jtagConfigStruct.jtagInstructionWidth); 
  JtagControllerDeviceSeqItemConverter :: fromClass(req ,jtagConfigStruct,jtagPacketStruct);
  $display("************************************************************************************************************************************************************************************************************\n \t \t THE SENT SENT FROM CONTROLLER DEVICE IS %b \n \t \t THE TMS BEING SENT IS %b \n************************************************************************************************************************************************************************************************************\n",jtagPacketStruct.jtagTestVector,jtagPacketStruct.jtagTms);
  jtagControllerDeviceDriverBfm.waitForReset();
  jtagControllerDeviceDriverBfm.DriveToBfm(jtagPacketStruct,jtagConfigStruct); 
  
  seq_item_port.item_done(rsp);
  end 
endtask : run_phase

`endif
