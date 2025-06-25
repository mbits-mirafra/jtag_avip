`ifndef JTAGControllerDeviceSEQUENCEPKG_INCLUDED_
`define JTAGControllerDeviceSEQUENCEPKG_INCLUDED_

package JtagControllerDeviceSequencePkg;
  import uvm_pkg :: *;
  `include "uvm_macros.svh"
  import JtagGlobalPkg :: *;
  import JtagControllerDevicePkg :: *;

  `include "JtagControllerDeviceBaseSequence.sv"
  `include "JtagControllerDeviceTestVectorSequence.sv"
  `include "JtagControllerDevicePatternBasedSequence.sv"
endpackage : JtagControllerDeviceSequencePkg
`endif
