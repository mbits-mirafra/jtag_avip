`ifndef JTAGCONTROLLERDEVICEASSERTIONS_INCLUDED_
`define JTAGCONTROLLERDEVICEASSERTIONS_INCLUDED_

import JtagGlobalPkg::*;

interface JtagControllerDeviceAssertions (input clk,
                                         input reset,
                                         input Tdi,
                                         input Tms
                                        );
 


  import uvm_pkg::*;
  `include "uvm_macros.svh"; 
 

    initial begin
    `uvm_info("JtagControllerDeviceAssertions","JtagControllerDeviceAssertions",UVM_LOW);
  end

  import JtagControllerDevicePkg ::JtagControllerDeviceAgentConfig;
  
  JtagControllerDeviceAgentConfig jtagControllerDeviceAgentConfig;

  bit startValidityCheck;
  bit startWidthCheck;

  bit[5:0] width=0;
  logic[4:0] instruction;
  logic[15:0]dataTest;
  logic[15:0] test;
  bit testVectorCheck;
  JtagInstructionWidthEnum jtagInstructionWidth;
  JtagTestVectorWidthEnum jtagTestVectorWidth;
  JtagInstructionOpcodeEnum jtagInstruction;
 always @(posedge clk) begin 
  if(!(uvm_config_db #(JtagControllerDeviceAgentConfig) :: get(null , "" , "jtagControllerDeviceAgentConfig" ,jtagControllerDeviceAgentConfig)))
      `uvm_fatal("CONTROLLER DEVICE]" , "FAILED TO GET CONFIG")

      jtagInstructionWidth = jtagControllerDeviceAgentConfig.jtagInstructionWidth;
      jtagTestVectorWidth = jtagControllerDeviceAgentConfig.jtagTestVectorWidth;
      jtagInstruction = jtagControllerDeviceAgentConfig.jtagInstructionOpcode;
      $display("THE INSTRUCTION  WIDTH IS %s",jtagInstructionWidth.name());

end 




  always @(posedge  clk)
    begin
     //$display("THE WIDTH OF ControllerDevice WIDTH IS %0d and data in is %0b",width,Tdi);
     if((!($isunknown(Tdi))) && (width < jtagControllerDeviceAgentConfig.jtagInstructionWidth) &&(!($isunknown(Tms)))) begin 
       width++;
       instruction = {Tdi,instruction[4:1]};
    end 

     if(width == jtagControllerDeviceAgentConfig.jtagInstructionWidth && (!($isunknown(Tms)))) begin 
       startValidityCheck = 1'b 1;
       repeat(2) @(posedge clk);
        startValidityCheck = 1'b 0;
	repeat(3) @(posedge clk);
        width =0;
	while(width < jtagTestVectorWidth)
	 begin 
          width++;

           @(posedge clk);

	 end
	 testVectorCheck =1;

      end 
    $display("THE WIDTH OF ControllerDevice WIDTH IS %0d and data in is %0b @%0t",width,Tdi,$time);
    end 


   property instructionValidityCheck;
	  @(posedge clk) disable iff (!(startValidityCheck))
              ##1  (((width)== jtagInstructionWidth));
  endproperty

	assert property (instructionValidityCheck)begin 
  $info("*************************************************************************************************************\n[ControllerDevice ASSERTION]\n INSTRUCTION %b MATCHES AND WIDTH %0d  IS CORRECT \n**************************************************************************************************************",instruction,width);
   instruction = 'bx;
	end 
else
 $error("\n \n \n INSTRUCTION BIT IS UNKNOWN ");


    property testVectorValidity;
	  @(posedge clk) disable iff (!testVectorCheck)
        (##1 (width == jtagTestVectorWidth) );
  endproperty

  assert property (testVectorValidity) begin 
  $info("*************************************************************************************************************\n[ControllerDevice ASSERTION]\nTEST VECTOR WIDTH %0d MATCHES \n************************************************************************************************************",width);
  testVectorCheck = 0;
  width=0;
  end 
  else
  $error("TEST VECTOR  INVALID ");



endinterface : JtagControllerDeviceAssertions

`endif

