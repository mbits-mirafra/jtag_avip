//-------------------------------------------------------
// Importing Jtag global package
//-------------------------------------------------------
import JtagGlobalPkg::*;

//--------------------------------------------------------------------------------------------
// Interface : JtagTargetDeviceDriverBfm
//  Used as the HDL driver for Jtag
//  It connects with the HVL driver_proxy for driving the stimulus
//--------------------------------------------------------------------------------------------
interface JtagTargetDeviceDriverBfm (input  logic   clk,
                              input  logic   reset,
                             input logic Tdi,
                             input logic Tms,
                             output logic  Tdo
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
  reg byPassRegister;
  reg[(JTAGREGISTERWIDTH -1):0]registerBank[JtagInstructionOpcodeEnum];
  reg[4:0]instructionRegister;
  JtagInstructionOpcodeEnum jtagInstructionOpcode;
  //Variable: name
  //Used to store the name of the interface
  string name = "JTAG_TargetDeviceDRIVER_BFM";
   task waitForReset();
    jtagTapState = jtagResetState;
    Tdo = 'b x;
    instructionRegister = 'b x;
  endtask : waitForReset


task registeringData(reg[4:0]instructionRegister , logic dataIn,JtagConfigStruct jtagConfigStruct);
    for (int i=0;i<(jtagInstructionOpcode.num()) ;i++) begin


      case(jtagConfigStruct.jtagInstructionWidth)

        'd 5 : begin
           if(jtagInstructionOpcode == instructionRegister) begin
             if(instructionRegister == jtagInstructionOpcode.first())
                begin
                  byPassRegister = dataIn;
                  Tdo  = byPassRegister ;
                end
             else begin
               registerBank[instructionRegister] = {dataIn,registerBank[instructionRegister][(JTAGREGISTERWIDTH -1):1] };
               Tdo = registerBank[instructionRegister][0];
               $display("### TARGET DRIVER ### THE SERIAL DATA %b FROM CONTROLLER DRIVER IS STORED IN REG WHOSE VECTOR IS %b AT %0t \n",dataIn,registerBank[instructionRegister],$time);
               break;
             end
           end
           else begin
             jtagInstructionOpcode = jtagInstructionOpcode.next();
           end
        end


        'd 4: begin
           if(jtagInstructionOpcode [3:0]== instructionRegister[4:1]) begin
             if(instructionRegister[4:1] == jtagInstructionOpcode.first()[3:0])
               begin
                 byPassRegister = dataIn;
                 Tdo  = byPassRegister ;
               end
             else begin
               registerBank[instructionRegister] = {dataIn,registerBank[instructionRegister][(JTAGREGISTERWIDTH -1):1] };
               Tdo = registerBank[instructionRegister][0];
               $display("### TARGET DRIVER ### THE SERIAL DATA %b FROM CONTROLLER DRIVER IS STORED IN REG WHOSE VECTOR IS %b AT %0t \n",dataIn,registerBank[instructionRegister],$time);
               break;
             end
           end
           else begin
              jtagInstructionOpcode = jtagInstructionOpcode.next();
           end
         end



         'd 3: begin
             if(jtagInstructionOpcode [2:0]== instructionRegister[4:2]) begin
                if(instructionRegister[4:2] == jtagInstructionOpcode.first()[2:0])
                  begin
                     byPassRegister = dataIn;
                     Tdo  = byPassRegister ;
                  end
                  else begin
                    registerBank[instructionRegister] = {dataIn,registerBank[instructionRegister][(JTAGREGISTERWIDTH -1):1] };
                    Tdo = registerBank[instructionRegister][0];
                    $display("### TARGET DRIVER ### THE SERIAL DATA %b FROM CONTROLLER DRIVER IS STORED IN REG WHOSE VECTOR IS %b AT %0t \n",dataIn,registerBank[instructionRegister],$time);
                    break;
                  end
                end
               else begin
                 jtagInstructionOpcode = jtagInstructionOpcode.next();
               end
          end

      endcase
   end
endtask

task observeData(JtagConfigStruct jtagConfigStruct);
  int  i,k ,m;
    for(int j=0 ; j< 62;j++)
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
            $display("### TARGET DRIVER ### IS IN SHIFT DR STATE AT %0t\n",$time);
            if(Tms ==1) begin
              jtagTapState = jtagExit1DrState;

            end
            else if(Tms ==0) begin
              jtagTapState = jtagShiftDrState;
            end
            registeringData(instructionRegister,Tdi,jtagConfigStruct);
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
            instructionRegister = 'b 00010;
          end


          jtagShiftIrState : begin
            $display("### TARGET DRIVER ### IS IN SHIFT IR STATE AT %0t \n",$time);
            if(Tms == 1) begin
              jtagTapState = jtagExit1IrState;
            end
            else if(Tms == 0) begin
              jtagTapState = jtagShiftIrState ;
            end
            instructionRegister = {Tdi,instructionRegister[4:1]};
            $display("### TARGET DRIVER ### THE INSTRUCTION BIT OBTAINED HERE IS %b COMPLETE VECTOR IS %b AT %0t \n",Tdi,instructionRegister,$time);
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
  endtask : observeData





endinterface : JtagTargetDeviceDriverBfm
