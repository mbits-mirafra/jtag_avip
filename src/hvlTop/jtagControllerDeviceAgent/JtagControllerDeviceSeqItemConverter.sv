`ifndef JTAGControllerDeviceSEQITEMCONVERTER_INCLUDED_
`define JTAGControllerDeviceSEQITEMCONVERTER_INCLUDED_

class JtagControllerDeviceSeqItemConverter extends uvm_object;
  `uvm_object_utils(JtagControllerDeviceSeqItemConverter)


 //localparam int TEST_VECTOR_WIDTH = (JTAGREGISTERWIDTH + jtagConfigStruct.jtagTestVectorWidth)-1;
 //localparam int INSTRUCTION_WIDTH = jtagConfigStruct.jtagInstructionWidth;

  extern function new(string name = "JtagControllerDeviceSeqItemConverter");
  extern static function void fromClass(input JtagControllerDeviceTransaction jtagControllerDeviceTransaction , input JtagConfigStruct jtagConfigStruct , output JtagPacketStruct jtagPacketStruct);
  extern static function void toClass (input JtagPacketStruct jtagPacketStruct ,input JtagConfigStruct jtagConfigStruct , inout JtagControllerDeviceTransaction jtagControllerDeviceTransaction);
 
endclass : JtagControllerDeviceSeqItemConverter 

function JtagControllerDeviceSeqItemConverter :: new(string  name = "JtagControllerDeviceSeqItemConverter");
  super.new(name);
endfunction : new


function void JtagControllerDeviceSeqItemConverter :: fromClass(input JtagControllerDeviceTransaction jtagControllerDeviceTransaction ,          input JtagConfigStruct jtagConfigStruct , output JtagPacketStruct jtagPacketStruct);

  int i=0;
 
  for (int i=0;i<jtagConfigStruct.jtagTestVectorWidth;i++)
    jtagPacketStruct.jtagTestVector[i] = jtagControllerDeviceTransaction.jtagTestVector[i];
 
//  jtagPacketStruct.jtagTms = {JTAGMOVETOIDLE , {TEST_VECTOR_WIDTH{0}},JTAGMOVETILLSHIFTDR , JTAGMOVETILLSELECTDR , {INSTRUCTION_WIDTH{0}} ,JTAGMOVETILLSHIFTIR}; 



  jtagPacketStruct.jtagTms= {64'b x ,JTAGMOVETILLSHIFTIR};


   for(i=0;i<jtagConfigStruct.jtagInstructionWidth-1;i++)
    jtagPacketStruct.jtagTms[($bits(JTAGMOVETILLSHIFTIR))+i] = 1'b 0;


  
    case(jtagConfigStruct.jtagInstructionWidth) 
      'd 3 : jtagPacketStruct.jtagTms = {JTAGMOVETILLSHIFTDR , JTAGMOVETILLSELECTDR , jtagPacketStruct.jtagTms[6:0]};
      'd 4 : jtagPacketStruct.jtagTms = {JTAGMOVETILLSHIFTDR , JTAGMOVETILLSELECTDR , jtagPacketStruct.jtagTms[7:0]};
      'd 5 : jtagPacketStruct.jtagTms = {JTAGMOVETILLSHIFTDR , JTAGMOVETILLSELECTDR , jtagPacketStruct.jtagTms[8:0]};
    endcase

 if(!(jtagConfigStruct.jtagInstructionOpcode == bypassRegister)) begin
   case(jtagConfigStruct.jtagTestVectorWidth)
 
    'd 8: begin 
           case(jtagConfigStruct.jtagInstructionWidth)
               'd 3 : jtagPacketStruct.jtagTms = {'b x ,JTAGMOVETOIDLE,{JTAGREGISTERWIDTH{1'b 0}} , 7'b 0 , jtagPacketStruct.jtagTms[11:0]};
	       'd 4 : jtagPacketStruct.jtagTms = {'b x,JTAGMOVETOIDLE,{JTAGREGISTERWIDTH{1'b 0}} , 7'b 0 , jtagPacketStruct.jtagTms[12:0]};
	       'd 5 : jtagPacketStruct.jtagTms = {'b x ,JTAGMOVETOIDLE,{JTAGREGISTERWIDTH{1'b 0}} , 7'b 0 , jtagPacketStruct.jtagTms[13:0]};
	    endcase 
        end  
    'd 16: begin
       case(jtagConfigStruct.jtagInstructionWidth)
         'd 3 : jtagPacketStruct.jtagTms = {'b x,JTAGMOVETOIDLE,{JTAGREGISTERWIDTH{1'b 0}} , 15'b 0 , jtagPacketStruct.jtagTms[11:0]};
	 'd 4 : jtagPacketStruct.jtagTms = {'b x,JTAGMOVETOIDLE,{JTAGREGISTERWIDTH{1'b 0}} , 15'b 0 , jtagPacketStruct.jtagTms[12:0]};
	 'd 5 : jtagPacketStruct.jtagTms = {'b x,JTAGMOVETOIDLE,{JTAGREGISTERWIDTH{1'b 0}} , 15'b 0 , jtagPacketStruct.jtagTms[13:0]};
       endcase
   end 

    'd 24: begin
        case(jtagConfigStruct.jtagInstructionWidth)
           'd 3 : jtagPacketStruct.jtagTms = {'b x,JTAGMOVETOIDLE,{JTAGREGISTERWIDTH{1'b 0}}, 23'b 0 , jtagPacketStruct.jtagTms[11:0]};
           'd 4 : jtagPacketStruct.jtagTms = {'b x,JTAGMOVETOIDLE,{JTAGREGISTERWIDTH{1'b 0}} , 23'b 0 , jtagPacketStruct.jtagTms[12:0]};
           'd 5 : jtagPacketStruct.jtagTms = {'b x,JTAGMOVETOIDLE,{JTAGREGISTERWIDTH{1'b 0}} , 23'b 0 , jtagPacketStruct.jtagTms[13:0]};
       endcase
     end

      'd 32: begin
        case(jtagConfigStruct.jtagInstructionWidth)
		'd 3 : jtagPacketStruct.jtagTms = {'b x,JTAGMOVETOIDLE,{JTAGREGISTERWIDTH{1'b 0}}, 31'b 0 , jtagPacketStruct.jtagTms[11:0]};
		'd 4 : jtagPacketStruct.jtagTms = {'b x,JTAGMOVETOIDLE,{JTAGREGISTERWIDTH{1'b 0}} , 31'b 0 , jtagPacketStruct.jtagTms[12:0]};
		'd 5 : jtagPacketStruct.jtagTms = {'b x,JTAGMOVETOIDLE,{JTAGREGISTERWIDTH{1'b 0}} , 31'b 0 , jtagPacketStruct.jtagTms[13:0]};
       endcase
     end
     

  endcase
end 
else 
  begin 
     case(jtagConfigStruct.jtagTestVectorWidth)
       'd 8: begin
          case(jtagConfigStruct.jtagInstructionWidth)
	     'd 3 : jtagPacketStruct.jtagTms = {64'b x ,JTAGMOVETOIDLE, 8'b 0 , jtagPacketStruct.jtagTms[11:0]};
	     'd 4 : jtagPacketStruct.jtagTms = {64'b x,JTAGMOVETOIDLE, 8'b 0 , jtagPacketStruct.jtagTms[12:0]};
              'd 5: jtagPacketStruct.jtagTms = {64'b x ,JTAGMOVETOIDLE ,8'b 0, jtagPacketStruct.jtagTms[13:0]};
          endcase
       end 

       'd 16: begin
         case(jtagConfigStruct.jtagInstructionWidth)
	     'd 3 : jtagPacketStruct.jtagTms = {64'b x ,JTAGMOVETOIDLE, 16'b 0 , jtagPacketStruct.jtagTms[11:0]};
	      'd 4 : jtagPacketStruct.jtagTms = {64'b x,JTAGMOVETOIDLE, 16'b 0 , jtagPacketStruct.jtagTms[12:0]};
	      'd 5: jtagPacketStruct.jtagTms = {64'b x ,JTAGMOVETOIDLE ,16'b 0, jtagPacketStruct.jtagTms[13:0]};
	 endcase

       end 

       'd 24: begin
        case(jtagConfigStruct.jtagInstructionWidth)
	  'd 3 : jtagPacketStruct.jtagTms = {64'b x ,JTAGMOVETOIDLE, 24'b 0 , jtagPacketStruct.jtagTms[11:0]};
	  'd 4 : jtagPacketStruct.jtagTms = {64'b x,JTAGMOVETOIDLE, 24'b 0 , jtagPacketStruct.jtagTms[12:0]};
	  'd 5: jtagPacketStruct.jtagTms = {64'b x ,JTAGMOVETOIDLE ,24'b 0, jtagPacketStruct.jtagTms[13:0]};
	endcase
       end 

       'd 32: begin
        case(jtagConfigStruct.jtagInstructionWidth)
		'd 3 : jtagPacketStruct.jtagTms = {64'b x ,JTAGMOVETOIDLE, 32'b 0 , jtagPacketStruct.jtagTms[11:0]};
		'd 4 : jtagPacketStruct.jtagTms = {64'b x,JTAGMOVETOIDLE, 32'b 0 , jtagPacketStruct.jtagTms[12:0]};
		'd 5: jtagPacketStruct.jtagTms = {64'b x ,JTAGMOVETOIDLE ,32'b 0, jtagPacketStruct.jtagTms[13:0]};
	endcase
       end 

	
     endcase

  end 




 endfunction : fromClass

function void JtagControllerDeviceSeqItemConverter :: toClass (input JtagPacketStruct jtagPacketStruct ,input JtagConfigStruct  jtagConfigStruct , inout JtagControllerDeviceTransaction jtagControllerDeviceTransaction);

int j;
j=0;
for (int i=0;i<=61;i++)
   if(!($isunknown(jtagPacketStruct.jtagTestVector[i]))) begin 
     jtagControllerDeviceTransaction.jtagTestVector[j++] = jtagPacketStruct.jtagTestVector[i];
   end


   for (int i=0 ;i<jtagConfigStruct.jtagInstructionWidth ; i++)
     jtagControllerDeviceTransaction.jtagInstruction[i] = jtagPacketStruct.jtagInstruction[i];

 endfunction : toClass

 `endif
