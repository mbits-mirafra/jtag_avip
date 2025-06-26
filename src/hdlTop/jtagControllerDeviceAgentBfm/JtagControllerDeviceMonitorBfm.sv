//-------------------------------------------------------
// Importing Jtag global package
//-------------------------------------------------------
import JtagGlobalPkg::*;

//--------------------------------------------------------------------------------------------
// Interface : JtagControllerDeviceMonitorBfm
//  Used as the HDL driver for Jtag
//  It connects with the HVL driver_proxy for driving the stimulus
//--------------------------------------------------------------------------------------------
interface JtagControllerDeviceMonitorBfm (input  logic   clk,
                              input  logic   reset,
                             input logic  Tdi,
			     input logic Tms
                              );
	//-------------------------------------------------------
  // Importing uvm package file
  //-------------------------------------------------------
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  JtagTapStates jtagTapState;	
  reg[31:0] temp;
  //-------------------------------------------------------
  // Importing the Transmitter package file
  //-------------------------------------------------------
  import JtagControllerDevicePkg::*;
  
  //Variable: name
  //Used to store the name of the interface
  string name = "JTAG_ControllerDevice_MONITOR_BFM";

  task waitForReset();
    jtagTapState = jtagResetState;
  endtask 
	
  
task startMonitoring(inout JtagPacketStruct jtagPacketStruct,input JtagConfigStruct jtagConfigStruct);
  int  i,k ,m;
  m=0;
  k=0;
    for(int j=0 ; j<$bits(jtagPacketStruct.jtagTms);j++)
      begin
        @(posedge clk);
        case(jtagTapState)

          jtagResetState :begin 
          
	    if(Tms == 1) begin 
	      jtagTapState = jtagResetState;
	    end 
	    else if(Tms ==0) begin 
	      jtagTapState = jtagIdleState;
	    end 
	  end


	  jtagIdleState : begin 
	   
	   if(Tms ==0) begin 
             jtagTapState = jtagIdleState;
	   end 
	   else if(Tms == 1) begin 
             jtagTapState = jtagDrScanState;
	   end 
	  end


          jtagDrScanState : begin 
	   
	   if(Tms == 1) begin 
             jtagTapState = jtagIrScanState;
	   end
	   else if(Tms == 0) begin 
             jtagTapState = jtagCaptureDrState;
	   end
	  end 

	  
	  jtagCaptureDrState : begin 
	    
	    if(Tms == 1) begin 
             jtagTapState = jtagExit1DrState;
	    end 
	    else if(Tms ==0) begin 
              jtagTapState = jtagShiftDrState;
	    end 
	  end 

	  
	  jtagShiftDrState : begin 
            $display("### CONTROLLER MONITOR ### IS IN SHIFT DR STATE AT %0t \n",$time);          
	    if(Tms ==1) begin
              jtagTapState = jtagExit1DrState;
	    end 
	    else if(Tms ==0) begin 
              jtagTapState = jtagShiftDrState;      
	    end
		  jtagPacketStruct.jtagTestVector = {Tdi , jtagPacketStruct.jtagTestVector[61:1]};       
	  
	         $display("### CONTROLLER MONITOR### THE SERIAL DATA OBTAINED HERE IS %b COMPLETE VECTOR IS %b AT %0t \n",Tdi,jtagPacketStruct.jtagTestVector,$time);
	  end 
          
	  
	  jtagExit1DrState : begin 

	    if(Tms == 1) begin 
              jtagTapState = jtagUpdateDrState;
	    end 
	    else if(Tms ==0) begin 
              jtagTapState = jtagPauseDrState;
	    end 
	  end 
          

          jtagPauseDrState : begin 
	    
	    if(Tms ==1) begin 
              jtagTapState = jtagExit2DrState;
 	    end 
	    else if(Tms ==0) begin
              jtagTapState = jtagPauseDrState;
	    end 
	  end 


          jtagExit2DrState : begin 

	    if(Tms == 1) begin 
              jtagTapState = jtagUpdateDrState;
	    end 
 	    else if(Tms == 0) begin 
              jtagTapState = jtagShiftDrState;
            end 
	  end 

	  jtagUpdateDrState : begin 

	    if(Tms == 1) begin 
              jtagTapState = jtagDrScanState;
	    end  
	    else if(Tms == 0) begin 
	      jtagTapState = jtagIdleState;
	    end 
	  end 

	  jtagIrScanState : begin 
	    
            if(Tms == 1) begin 
	      jtagTapState = jtagResetState;
            end 
	    else if(Tms ==0) begin 
              jtagTapState = jtagCaptureIrState;
	    end
	  end 

	  jtagCaptureIrState : begin 

	    if(Tms == 1) begin 
              jtagTapState = jtagExit1IrState;
	    end 
	    else if(Tms == 0) begin 
              jtagTapState = jtagShiftIrState;
	    end 
	  end 


	  jtagShiftIrState : begin 
           $display("### CONTROLLER MONITOR ### IS IN SHIFT IR STATE AT %0t \n",$time);
	    if(Tms == 1) begin 
              jtagTapState = jtagExit1IrState;
	    end 
	    else if(Tms == 0) begin 
              jtagTapState = jtagShiftIrState ;
	    end
		  jtagPacketStruct.jtagInstruction[m++] = Tdi;
                  $display("### CONTROLLER MONITOR### THE INSTRUCTION BIT OBTAINED HERE IS %b COMPLETE VECTOR IS %b AT %0t \n",Tdi,jtagPacketStruct.jtagInstruction,$time);

            end 
 
      
          jtagExit1IrState : begin 
            
 	    if(Tms == 1) begin 
              jtagTapState = jtagUpdateIrState ;
	    end 
	    else if(Tms == 0) begin 
              jtagTapState = jtagPauseIrState;
	    end 
	  end 


	  jtagPauseIrState : begin 
  
            if(Tms == 1) begin 
              jtagTapState = jtagExit2IrState;
	    end 
	    else if(Tms == 0) begin 
              jtagTapState = jtagPauseIrState;
	    end
	  end 

	  jtagExit2IrState : begin 
      
            if(Tms ==0) begin 
              jtagTapState = jtagShiftIrState;
	    end 
	    else if(Tms == 1) begin 
              jtagTapState = jtagUpdateIrState;
	    end 
	  end

	  jtagUpdateIrState: begin 
            
	    if(Tms == 1) begin 
	      jtagTapState = jtagDrScanState;
            end
	    else if(Tms == 0) begin 
               jtagTapState = jtagIdleState;
	    end
	  end 
          
	endcase  
	//$display("THE STATE IN ControllerDevice MONITOR %s @%0t and jtag instruction obtained is %b and data is %b",jtagTapState.name(),$time,jtagPacketStruct.jtagInstruction,jtagPacketStruct.jtagTestVector);
      end  

   
endtask 
	
endinterface : JtagControllerDeviceMonitorBfm
