`ifndef JTAGTARGETDEVICESEQUENCEPKG_INCLUDED_
`define JTAGTARGETDEVICESEQUENCEPKG_INCLUDED_

package JtagTargetDeviceSequencePkg;
  import uvm_pkg :: *;
  `include "uvm_macros.svh"
  import JtagGlobalPkg :: *;
  import JtagTargetDevicePkg :: *;

  `include "JtagTargetDeviceBaseSequence.sv"

endpackage : JtagTargetDeviceSequencePkg
`endif
