`ifndef JTAGControllerDeviceCONFIGCONVERTER_INCLUDED_
`define JTAGControllerDeviceCONFIGCONVERTER_INCLUDED_

class JtagControllerDeviceConfigConverter extends uvm_object;
  `uvm_object_utils(JtagControllerDeviceConfigConverter)
  extern function new(string name = "JtagControllerDeviceConfigConverter");
  extern static function void fromClass(input JtagControllerDeviceAgentConfig jtagControllerDeviceAgentConfig,                    output JtagConfigStruct jtagConfigStruct);

endclass : JtagControllerDeviceConfigConverter 

function JtagControllerDeviceConfigConverter :: new(string name = "JtagControllerDeviceConfigConverter");
  super.new(name);
endfunction : new

function void JtagControllerDeviceConfigConverter :: fromClass(input JtagControllerDeviceAgentConfig jtagControllerDeviceAgentConfig,               output JtagConfigStruct jtagConfigStruct);
  jtagConfigStruct.jtagTestVectorWidth = jtagControllerDeviceAgentConfig.jtagTestVectorWidth;
  jtagConfigStruct.jtagInstructionWidth = jtagControllerDeviceAgentConfig.jtagInstructionWidth;
  for (int i=0; i<jtagControllerDeviceAgentConfig.jtagInstructionWidth;i++)
   jtagConfigStruct.jtagInstructionOpcode[i] = jtagControllerDeviceAgentConfig.jtagInstructionOpcode[i];
endfunction :fromClass

`endif
