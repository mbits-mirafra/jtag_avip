//-------------------------------------------------------
// Importing Jtag global package
//-------------------------------------------------------
import JtagGlobalPkg::*;

//--------------------------------------------------------------------------------------------
// Interface : JtagControllerDeviceDriverBfm
//  Used as the HDL driver for Jtag
//  It connects with the HVL driver_proxy for driving the stimulus
//--------------------------------------------------------------------------------------------
interface JtagControllerDeviceDriverBfm (input  logic   clk,
                              input  logic   reset,
                             output logic  Tdi,
			     output logic Tms
                              );
	//-------------------------------------------------------
  // Importing uvm package file
  //-------------------------------------------------------
  import uvm_pkg::*;
  `include "uvm_macros.svh"
	
  //-------------------------------------------------------
  // Importing the Transmitter package file
  //-------------------------------------------------------
  import JtagControllerDevicePkg::*;
  JtagTapStates jtagTapState; 
  //Variable: name
  //Used to store the name of the interface
  string name = "JTAG_ControllerDeviceDRIVER_BFM"; 

  task waitForReset();
    jtagTapState = jtagResetState;
    Tdi = 'b x;
  endtask : waitForReset
  task DriveToBfm(JtagPacketStruct jtagPacketStruct , JtagConfigStruct jtagConfigStruct);
    int  i,k ,m;
    i=0; 
    m=0;
    k=0;
    for(int j=0 ; j< $bits(jtagPacketStruct.jtagTms);j++)
      begin
	      @(posedge clk) Tms = jtagPacketStruct.jtagTms[i++];
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
           $display("### CONTROLLER DRIVER ### IS IN SHIFT DR STATE AT %0t\n",$time);	    
	    if(Tms ==1) begin
              jtagTapState = jtagExit1DrState;
	    end 
	    else if(Tms ==0) begin 
              jtagTapState = jtagShiftDrState;      
	    end 
	    Tdi=jtagPacketStruct.jtagTestVector[k++];
	  $display("### CONTROLLER DRIVER ### THE SERIAL DATA SENT OUT FROM CONTROLLER IS %b AT %0t \n",Tdi,$time);
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
            $display("### CONTROLLER DRIVER ### IS IN SHIFT IR STATE AT %0t \n",$time);
	    if(Tms == 1) begin 
              jtagTapState = jtagExit1IrState;
	    end 
	    else if(Tms == 0) begin 
              jtagTapState = jtagShiftIrState ;
	    end
	    Tdi = jtagConfigStruct.jtagInstructionOpcode[m++];
	    $display("### CONTROLLER DRIVER ### THE INSTRUCTION SENT OUT IS %b\n",Tdi);
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
      end  
  endtask :DriveToBfm

	
endinterface : JtagControllerDeviceDriverBfm
