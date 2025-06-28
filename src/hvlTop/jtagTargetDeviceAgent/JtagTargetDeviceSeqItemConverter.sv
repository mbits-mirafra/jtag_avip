`ifndef JTAGTARGETDEVICESEQITEMCONVERTER_INCLUDED_
`define JTAGTARGETDEVICESEQITEMCONVERTER_INCLUDED_

class JtagTargetDeviceSeqItemConverter extends uvm_object;
  `uvm_object_utils(JtagTargetDeviceSeqItemConverter)

  extern function new(string name = "JtagTargetDeviceSeqItemConverter");
  extern static function void fromClass(input JtagTargetDeviceTransaction jtagTargetDeviceTransaction , input JtagConfigStruct jtagConfigStruct , output JtagPacketStruct jtagPacketStruct);
  extern static function void toClass (input JtagPacketStruct jtagPacketStruct ,input JtagConfigStruct jtagConfigStruct , inout JtagTargetDeviceTransaction jtagTargetDeviceTransaction);
 
endclass : JtagTargetDeviceSeqItemConverter 

function JtagTargetDeviceSeqItemConverter :: new(string  name = "JtagTargetDeviceSeqItemConverter");
  super.new(name);
endfunction : new


function void JtagTargetDeviceSeqItemConverter :: fromClass(input JtagTargetDeviceTransaction jtagTargetDeviceTransaction ,input JtagConfigStruct jtagConfigStruct , output JtagPacketStruct jtagPacketStruct);
  for (int i=0;i<jtagConfigStruct.jtagTestVectorWidth;i++)
    jtagPacketStruct.jtagTestVector[i] = jtagTargetDeviceTransaction.jtagTestVector[i];
endfunction : fromClass

function void JtagTargetDeviceSeqItemConverter :: toClass (input JtagPacketStruct jtagPacketStruct ,input JtagConfigStruct  jtagConfigStruct , inout JtagTargetDeviceTransaction jtagTargetDeviceTransaction);

  int j;
  j=0;

  for (int i=0;i<=61;i++)
    if(!($isunknown(jtagPacketStruct.jtagTestVector[i]))) begin 
      jtagTargetDeviceTransaction.jtagTestVector[j++] = jtagPacketStruct.jtagTestVector[i];
    end

  for (int i=0 ;i<jtagConfigStruct.jtagInstructionWidth ; i++)
    jtagTargetDeviceTransaction.jtagInstruction[i] = jtagPacketStruct.jtagInstruction[i];

endfunction : toClass

 `endif
