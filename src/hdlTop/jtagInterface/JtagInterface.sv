//-------------------------------------------------------
// Importing Jtag global package
//-------------------------------------------------------

import JtagGlobalPkg::*;

//--------------------------------------------------------------------------------------------
// Interface : JtagIf
// Declaration of pin level signals for Jtag interface
//--------------------------------------------------------------------------------------------

interface JtagIf (input clk, input reset);
  
  logic Tdi;

  logic Tdo;

  logic Tms;
  
endinterface : JtagIf 
