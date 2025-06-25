`ifndef JTAGTARGETDEVICEASSERTIONS_INCLUDED_
`define JTAGTARGETDEVICEASSERTIONS_INCLUDED_

import JtagGlobalPkg::*;

interface JtagTargetDeviceAssertions (input clk,
                                         input reset,
                                         input Tdo,
                                         input Tms
                                        );
 


  import uvm_pkg::*;
  `include "uvm_macros.svh"; 
 

    initial begin
    `uvm_info("JtagTargetDeviceAssertions","JtagTargetDeviceAssertions",UVM_LOW);
  end

  import JtagTargetDevicePkg ::JtagTargetDeviceAgentConfig;
  
  JtagTargetDeviceAgentConfig jtagTargetDeviceAgentConfig;

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
  if(!(uvm_config_db #(JtagTargetDeviceAgentConfig) :: get(null , "" , "jtagTargetDeviceAgentConfig" ,jtagTargetDeviceAgentConfig)))
      `uvm_fatal("CONTROLLER DEVICE]" , "FAILED TO GET CONFIG")   
      jtagTestVectorWidth = jtagTargetDeviceAgentConfig.jtagTestVectorWidth;
end 




  always @(posedge  clk)
    begin
     if((!($isunknown(Tdo))) && (width <jtagTargetDeviceAgentConfig.jtagTestVectorWidth) && (!($isunknown(Tms)))) begin 
       width++;
       $display("THE WIDTH IS %0d and serial in is %0b",width,Tdo);

    end 

     if(width == jtagTargetDeviceAgentConfig.jtagTestVectorWidth && (!($isunknown(Tms)))) begin 
       startWidthCheck = 1'b 1;
       repeat(2) @(posedge clk);
        startWidthCheck = 1'b 0;
      end 
    end 


   property testWidthCheck;
	  @(posedge clk) disable iff (!(startWidthCheck))
              ##1 (((width)== jtagTestVectorWidth));
  endproperty

  assert property (testWidthCheck) begin
  $info("******************************************************************************************************\n [TargetDevice ASSERTION] \n TargetDevice TDI WIDTH IS VALID =%0d \n************************************************************************************************************",width);
  width= 1'b 0;
  end
  else
 $error("\n \n \n WIDTH MISMATCH \n \n \n");

endinterface : JtagTargetDeviceAssertions

`endif
