`ifndef HVLTOP_INCLUDED_
`define HVLTOP_INCLUDED_
//--------------------------------------------------------------------------------------------
// Module: Hvl top module
//--------------------------------------------------------------------------------------------
module HvlTop;
  
  //-------------------------------------------------------
  // Package : Importing Uvm Pakckage and Test Package
  //-------------------------------------------------------

    import uvm_pkg :: *;
    import JtagBaseTestPkg :: *;

    initial 
    begin 
	run_test("JtagBaseTest");
    end
endmodule : HvlTop
`endif
