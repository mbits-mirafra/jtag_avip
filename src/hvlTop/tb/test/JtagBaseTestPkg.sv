`ifndef JTAGBASETESTPKG_INCLUDED_
`define JTAGBASETESTPKG_INCLUDED_

package JtagBaseTestPkg;
  `include "uvm_macros.svh"

  import uvm_pkg :: *;
  import JtagGlobalPkg :: *;

  import JtagControllerDevicePkg :: *;
  import JtagTargetDevicePkg :: *;
  import JtagEnvPkg :: *;
  import JtagControllerDeviceSequencePkg :: *;
  import JtagTargetDeviceSequencePkg :: *;
  import JtagVirtualSequencePkg :: *;

  `include "JtagBaseTest.sv"
  `include "JtagTdiWidth8Test.sv"
  `include "JtagTdiWidth16Test.sv"
  `include "JtagTdiWidth24Test.sv"
  `include "JtagTdiWidth32Test.sv"
  `include "JtagTdiWidth16InstructionWidth3Test.sv"
  `include "JtagTdiWidth16InstructionWidth4Test.sv"
  `include "JtagTdiWidth24InstructionWidth3Test.sv"
  `include "JtagTdiWidth24InstructionWidth4Test.sv"
  `include "JtagTdiWidth8InstructionWidth3Test.sv"
  `include "JtagTdiWidth8InstructionWidth4Test.sv"
  `include "JtagTdiWidth32InstructionWidth3Test.sv"
  `include "JtagTdiWidth32InstructionWidth4Test.sv" 
  `include "JtagTdiWidth8BypassRegisterTest.sv"
  `include "JtagTdiWidth16BypassRegisterTest.sv"
   `include "JtagTdiWidth24BypassRegisterTest.sv"
   `include "JtagTdiWidth32BypassRegisterTest.sv"
   `include "JtagTdiWidth16UDR.sv"
  `include "JtagTdiWidth8UDR.sv"
  `include "JtagTdiWidth24UDR.sv"
  `include "JtagTdiWidth32UDR.sv"
  `include "Jtag8BitPatternBasedTest.sv"
  `include "Jtag16BitPatternBasedTest.sv"
  `include "Jtag32BitPatternBasedTest.sv"
  `include "Jtag24BitPatternBasedTest.sv"
 endpackage : JtagBaseTestPkg

 `endif
