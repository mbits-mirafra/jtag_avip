`ifndef JTAGTargetDeviceCONFIGCONVERTER_INCLUDED_
`define JTAGTargetDeviceCONFIGCONVERTER_INCLUDED_

class JtagTargetDeviceConfigConverter extends uvm_object;
  `uvm_object_utils(JtagTargetDeviceConfigConverter)
  extern function new(string name = "JtagTargetDeviceConfigConverter");
  extern static function void fromClass(input JtagTargetDeviceAgentConfig jtagTargetDeviceAgentConfig,                    output JtagConfigStruct jtagConfigStruct);

endclass : JtagTargetDeviceConfigConverter 

function JtagTargetDeviceConfigConverter :: new(string name = "JtagTargetDeviceConfigConverter");
  super.new(name);
endfunction : new

function void JtagTargetDeviceConfigConverter :: fromClass(input JtagTargetDeviceAgentConfig jtagTargetDeviceAgentConfig,output JtagConfigStruct jtagConfigStruct);
  jtagConfigStruct.jtagTestVectorWidth = jtagTargetDeviceAgentConfig.jtagTestVectorWidth;
  jtagConfigStruct.jtagInstructionWidth = jtagTargetDeviceAgentConfig.jtagInstructionWidth;
  for (int i=0; i<jtagTargetDeviceAgentConfig.jtagInstructionWidth;i++)
   jtagConfigStruct.jtagInstructionOpcode[i] = jtagTargetDeviceAgentConfig.jtagInstructionOpcode[i];
endfunction :fromClass

`endif
