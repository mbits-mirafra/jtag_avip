`ifndef JTAGControllerDevicePKG_INCLUDED_
`define JTAGControllerDevicePKG_INCLUDED_

package JtagControllerDevicePkg;
  `include "uvm_macros.svh"

  import uvm_pkg :: *;
  import JtagGlobalPkg :: *;
  `include "JtagControllerDeviceAgentConfig.sv"
  `include "JtagControllerDeviceTransaction.sv"
  `include "JtagControllerDeviceSeqItemConverter.sv"
  `include "JtagControllerDeviceConfigConverter.sv"
  `include "JtagControllerDeviceSequencer.sv"
  `include "JtagControllerDeviceDriverProxy.sv"
  `include "JtagControllerDeviceMonitorProxy.sv"
  `include "JtagControllerDeviceCoverage.sv"
  `include "JtagControllerDeviceAgent.sv"

endpackage : JtagControllerDevicePkg

`endif
