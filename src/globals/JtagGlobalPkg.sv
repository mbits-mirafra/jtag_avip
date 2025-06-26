`ifndef JTAGGLOBALPKG_INCLUDED_
`define JTAGGLOBALPKG_INCLUDED_

package JtagGlobalPkg;
 
  parameter JTAGREGISTERWIDTH =10;
  
  parameter [4:0] JTAGMOVETILLSHIFTIR = 5'b 00110;
  
  parameter [2:0] JTAGMOVETILLSELECTDR = 3'b 111;

  parameter [1:0] JTAGMOVETILLSHIFTDR = 2'b 00;

  parameter [2:0] JTAGMOVETOIDLE = 3'b 011;

  parameter NO_OF_TESTS = 10;


  typedef enum bit [5:0]{testVectorWidth8Bit= 8,
                         testVectorWidth16Bit = 16,
			 testVectorWidth24Bit = 24 , 
			 testVectorWidth32Bit=32} JtagTestVectorWidthEnum;
  
  typedef enum bit [2:0]{instructionWidth3Bit= 3,
                         instructionWidth4Bit = 4,
			 instructionWidth5Bit = 5} JtagInstructionWidthEnum;
 
  typedef enum bit[4:0] {bypassRegister = 5'b 00000,
                         userDefinedRegister = 5'b 00001, 
			 boundaryScanRegisters=5'b 00110 }JtagInstructionOpcodeEnum;

  typedef struct packed {JtagTestVectorWidthEnum jtagTestVectorWidth;
                         JtagInstructionWidthEnum jtagInstructionWidth;
			 logic[4:0] jtagInstructionOpcode;}JtagConfigStruct;
 
 
  typedef struct packed{logic[61:0] jtagTestVector; logic[4:0]jtagInstruction; logic[61:0]jtagTms;}JtagPacketStruct;

  typedef enum{jtagResetState ,jtagIdleState,jtagDrScanState, jtagIrScanState,jtagCaptureIrState,jtagShiftIrState,jtagExit1IrState,jtagPauseIrState,jtagExit2IrState,jtagUpdateIrState,jtagCaptureDrState,jtagShiftDrState,jtagExit1DrState,jtagPauseDrState,jtagExit2DrState,jtagUpdateDrState}JtagTapStates;

endpackage : JtagGlobalPkg

`endif
