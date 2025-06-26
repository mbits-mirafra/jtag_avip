
//--------------------------------------------------------------------------------------------
// Module      : jtag ControllerDevice Agent BFM
// Description : Instantiates driver and monitor
//--------------------------------------------------------------------------------------------

module JtagControllerDeviceAgentBfm(JtagIf jtagIf);

  //-------------------------------------------------------
  // Importing uvm package file
  //-------------------------------------------------------

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  
  initial begin
    `uvm_info("jtag ControllerDevice agent bfm",$sformatf("JTAG ControllerDevice AGENT BFM"),UVM_LOW)
  end
  
  //-------------------------------------------------------
  // ControllerDevice driver bfm instantiation
  //-------------------------------------------------------
  
  JtagControllerDeviceDriverBfm jtagControllerDeviceDriverBfm (.clk(jtagIf.clk),.Tdi(jtagIf.Tdi),.reset(jtagIf.reset) ,.Tms(jtagIf.Tms));

  //-------------------------------------------------------
  // ControllerDevice monitor bfm instantiation
  //-------------------------------------------------------
  
  JtagControllerDeviceMonitorBfm jtagControllerDeviceMonitorBfm (.clk(jtagIf.clk),.Tdi(jtagIf.Tdi),.reset(jtagIf.reset),.Tms(jtagIf.Tms));


  //-------------------------------------------------------
  // setting the virtual handle of BFMs into config_db
  //-------------------------------------------------------

  initial begin
    uvm_config_db#(virtual JtagControllerDeviceDriverBfm)::set(null,"*","jtagControllerDeviceDriverBfm",jtagControllerDeviceDriverBfm);
    uvm_config_db#(virtual JtagControllerDeviceMonitorBfm)::set(null,"*","jtagControllerDeviceMonitorBfm",jtagControllerDeviceMonitorBfm);
  end

  bind jtagControllerDeviceMonitorBfm JtagControllerDeviceAssertions TestVectrorTestingAssertions(.clk(clk),.Tdi(Tdi), .reset(reset),.Tms(Tms));

endmodule : JtagControllerDeviceAgentBfm
