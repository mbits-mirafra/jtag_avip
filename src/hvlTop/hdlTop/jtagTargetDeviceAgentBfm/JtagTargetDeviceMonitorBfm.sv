//-------------------------------------------------------
// Importing Jtag global package
//-------------------------------------------------------
import JtagGlobalPkg::*;

//--------------------------------------------------------------------------------------------
// Interface : JtagTargetDeviceMonitorBfm
//  Used as the HDL driver for Jtag
//  It connects with the HVL driver_proxy for driving the stimulus
//--------------------------------------------------------------------------------------------
interface JtagTargetDeviceMonitorBfm (input  logic   clk,
                              input  logic   reset,
                             input logic  Tdo,
			     input logic Tms,
			     input logic Tdi
                              );
	//-------------------------------------------------------
  // Importing uvm package file
  //-------------------------------------------------------
  import uvm_pkg::*;
  `include "uvm_macros.svh"
	
  //-------------------------------------------------------
  // Importing the Transmitter package file
  //-------------------------------------------------------
  import JtagTargetDevicePkg::*;
  JtagTapStates jtagTapState;
  //Variable: name
  //Used to store the name of the interface
  string name = "JTAG_TargetDevice_MONITOR_BFM"; 

  task waitForReset();
    jtagTapState = jtagResetState;
  endtask 

  task startMonitoring(inout JtagPacketStruct jtagPacketStruct,input JtagConfigStruct jtagConfigStruct);
  int  i,k ,m;
  automatic int count =0;
  m=0;
  for(int j=0 ; j<$bits(jtagPacketStruct.jtagTms);j++)
      begin
        @(posedge clk);
            $display("state of machine  is %s",jtagTapState.name());
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
	  
	  $display("### TARGET MONITOR ### IS IN SHIFT DR STATE AT %0t \n ",$time);
	    if(Tms ==1) begin
              jtagTapState = jtagExit1DrState;
	    end 
	    else if(Tms ==0) begin 
              jtagTapState = jtagShiftDrState;      
	    end

	    jtagPacketStruct.jtagTestVector = {Tdo, jtagPacketStruct.jtagTestVector[61:1]};  
	      $display("### TARGET MONITOR ### THE SERIAL DATA OBTAINED FROM TARGET DRIVER IS %b COMPLETE VECTORE IS %b AT %0t \n",Tdo,jtagPacketStruct.jtagTestVector,$time);

	  end 
          
	  
	  jtagExit1DrState : begin 

	    if(Tms == 1) begin 
              jtagTapState = jtagUpdateDrState;
	    end 
	    else if(Tms ==0) begin 
              jtagTapState = jtagPauseDrState;
	    end 
	    count++;

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

	    if(Tms == 1) begin 
              jtagTapState = jtagExit1IrState;
	    end 
	    else if(Tms == 0) begin 
              jtagTapState = jtagShiftIrState ;
	    end
	     jtagPacketStruct.jtagInstruction[m++] = Tdi;
	 $display("#########################INS IS %b",jtagPacketStruct.jtagInstruction);
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


  
  endtask 
	
endinterface : JtagTargetDeviceMonitorBfm
