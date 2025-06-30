//-------------------------------------------------------
// Importing Jtag global package
//-------------------------------------------------------
`timescale 1ns/1ps
import JtagGlobalPkg::*;

//--------------------------------------------------------------------------------------------
// Interface : JtagIf
// Declaration of pin level signals for Jtag interface
//--------------------------------------------------------------------------------------------

interface JtagIf (input clk, input reset);
  
  logic Tdi;

  logic Tdo;

  logic Tms;

  logic Trst;
  
endinterface : JtagIf 
