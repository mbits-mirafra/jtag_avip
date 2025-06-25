`ifndef JTAGTargetDeviceSEQITEMCONVERTER_INCLUDED_
`define JTAGTargetDeviceSEQITEMCONVERTER_INCLUDED_

class JtagTargetDeviceSeqItemConverter extends uvm_object;
  `uvm_object_utils(JtagTargetDeviceSeqItemConverter)

  extern function new(string name = "JtagTargetDeviceSeqItemConverter");
  extern static function void fromClass(input JtagTargetDeviceTransaction jtagTargetDeviceTransaction , input JtagConfigStruct jtagConfigStruct , output JtagPacketStruct jtagPacketStruct);
  extern static function void toClass (input JtagPacketStruct jtagPacketStruct ,input JtagConfigStruct jtagConfigStruct , inout JtagTargetDeviceTransaction jtagTargetDeviceTransaction);
 
endclass : JtagTargetDeviceSeqItemConverter 

function JtagTargetDeviceSeqItemConverter :: new(string  name = "JtagTargetDeviceSeqItemConverter");
  super.new(name);
endfunction : new


function void JtagTargetDeviceSeqItemConverter :: fromClass(input JtagTargetDeviceTransaction jtagTargetDeviceTransaction ,          input JtagConfigStruct jtagConfigStruct , output JtagPacketStruct jtagPacketStruct);
 for (int i=0;i<jtagConfigStruct.jtagTestVectorWidth;i++)
    jtagPacketStruct.jtagTestVector[i] = jtagTargetDeviceTransaction.jtagTestVector[i];


   

  // for(int i=0 ; i<32 ; i++)
  //  jtagPacketStruct.jtagTms[i]= jtagTargetDeviceTransaction.jtagTms[i];
 endfunction : fromClass

function void JtagTargetDeviceSeqItemConverter :: toClass (input JtagPacketStruct jtagPacketStruct ,input JtagConfigStruct  jtagConfigStruct , inout JtagTargetDeviceTransaction jtagTargetDeviceTransaction);
 //  for (int i=0;i<jtagConfigStruct.jtagTestVectorWidth;i++)
   //  jtagTargetDeviceTransaction.jtagTestVector[i] = jtagPacketStruct.jtagTestVector[i];

  int j;
  j=0;

 /*
   case(jtagConfigStruct.jtagTestVectorWidth)
    'd 8 : jtagTargetDeviceTransaction.jtagTestVector[7:0] = jtagPacketStruct.jtagTestVector[61:54];
    'd 16: jtagTargetDeviceTransaction.jtagTestVector[15:0]= jtagPacketStruct.jtagTestVector[61:46];
    'd 24 : jtagTargetDeviceTransaction.jtagTestVector[23:0] = jtagPacketStruct.jtagTestVector[61:38];
    'd 32 : jtagTargetDeviceTransaction.jtagTestVector[31:0] = jtagPacketStruct.jtagTestVector[61:30];
   endcase
*/


  for (int i=0;i<=61;i++)
   if(!($isunknown(jtagPacketStruct.jtagTestVector[i]))) begin 
     jtagTargetDeviceTransaction.jtagTestVector[j++] = jtagPacketStruct.jtagTestVector[i];
   end


   for (int i=0 ;i<jtagConfigStruct.jtagInstructionWidth ; i++)
     jtagTargetDeviceTransaction.jtagInstruction[i] = jtagPacketStruct.jtagInstruction[i];

 endfunction : toClass

 `endif
