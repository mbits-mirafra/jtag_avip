`ifndef JTAGMTargetDevicePKG_INCLUDED_
`define JTAGTargetDevicePKG_INCLUDED_

package JtagTargetDevicePkg;
  `include "uvm_macros.svh"

  import uvm_pkg :: *;
  import JtagGlobalPkg :: *;
  `include "JtagTargetDeviceAgentConfig.sv"
  `include "JtagTargetDeviceTransaction.sv"
  `include "JtagTargetDeviceSeqItemConverter.sv"
  `include "JtagTargetDeviceConfigConverter.sv"
  `include "JtagTargetDeviceSequencer.sv"
  `include "JtagTargetDeviceDriverProxy.sv"
  `include "JtagTargetDeviceMonitorProxy.sv"
  `include "JtagTargetDeviceCoverage.sv"
  `include "JtagTargetDeviceAgent.sv"

endpackage : JtagTargetDevicePkg

`endif
