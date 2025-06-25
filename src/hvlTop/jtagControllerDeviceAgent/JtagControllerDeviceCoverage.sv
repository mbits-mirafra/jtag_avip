`ifndef JTAGControllerDeviceCOVERAGE_INCLUDED_
`define JTAGControllerDeviceCOVERAGE_INCLUDED_

class JtagControllerDeviceCoverage extends uvm_subscriber#(JtagControllerDeviceTransaction);
  `uvm_component_utils(JtagControllerDeviceCoverage)
  
  bit[31:0] testVector;
  bit[4:0]instruction;
  JtagControllerDeviceAgentConfig jtagControllerDeviceAgentConfig;
  int j;
  int index;
  extern function new(string name = "JtagControllerDeviceCoverage",uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern function void write(JtagControllerDeviceTransaction t);
  extern function void report_phase(uvm_phase phase);
  covergroup JtagControllerDeviceCoverGroup with function sample(bit[31:0]TestVector,JtagControllerDeviceAgentConfig jtagControllerDeviceAgentConfig);

    JtagTestVector_CP : coverpoint TestVector{ bins low_range = {[0:(2**12)]};
                                               bins mid_range = {[(2**12)+1 : 2**24]} ;
					       bins high_range = {[(2**24)+1 : 0]};}
   
    JTAG_TESTVECTOR_WIDTH : coverpoint jtagControllerDeviceAgentConfig.jtagTestVectorWidth{ bins TDI_WIDTH_8 = {testVectorWidth8Bit};
     										  bins TDI_WIDTH_16 = {testVectorWidth16Bit};
										   bins TDI_WIDTH_24 = {testVectorWidth24Bit};
										    bins TDI_WIDTH_32 = {testVectorWidth32Bit};
										    }

    JTAG_INSTRUCTION_WIDTH:coverpoint jtagControllerDeviceAgentConfig.jtagInstructionWidth{ bins INSTRUCTION_WIDTH_3 = {instructionWidth3Bit};
                                                                                   bins INSTRUCTION_WIDTH_4 = {instructionWidth4Bit};
										    bins INSTRUCTION_WIDTH_5 = {instructionWidth5Bit};
										    }
    JTAG_INSTRUCTION : coverpoint jtagControllerDeviceAgentConfig.jtagInstructionOpcode;


/*
      DATA_PATTERN_8 : coverpoint TestVector{
      bins pattern1_8 = {8'b 11111111};
      bins pattern2_8 = {8'b 10101010};
      bins pattern3_8 = {8'b 11110000};
      bins pattern4_8 = {8'b 00000000};
      bins pattern5_8 = {8'b 01010101};}

      DATA_PATTERN_16 : coverpoint TestVector{
      bins pattern1_16 = {16'b 1111111111111111};
	      bins pattern2_16 = {16'b 1010101010101010};
	      bins pattern3_16 = {16'b 1111000011110000};
	      bins pattern4_16 = {16'b 0000000000000000};
	      bins pattern5_16 = {16'b 0101010101010101};}


      DATA_PATTERN_24 : coverpoint TestVector{
	      bins pattern1_24 = {24'b 111111111111111111111111};
	      bins pattern2_24 = {24'b 101010101010101010101010};
	      bins pattern3_24 = {24'b 111100001111000011110000};
	      bins pattern4_24 = {24'b 000000000000000000000000};
	      bins pattern5_24 = {24'b 010101010101010101010101};}

      DATA_PATTERN_32 : coverpoint TestVector{
	      bins pattern1_32 = {32'b 11111111111111111111111111111111};
	      bins pattern2_32 = {32'b 10101010101010101010101010101010};
	      bins pattern3_32 = {32'b 11110000111100001111000011110000};
	      bins pattern4_32 = {32'b 00000000000000000000000000000000};
	      bins pattern5_32 = {32'b 01010101010101010101010101010101};}
       

	  DATA_PATTERN_8_DATA_WIDTH_CP : cross DATA_PATTERN_8,JTAG_TESTVECTOR_WIDTH { ignore_bins data_8 =  !binsof(JTAG_TESTVECTOR_WIDTH)intersect{testVectorWidth8Bit};}
	  DATA_PATTERN_16_DATA_WIDTH_CP : cross DATA_PATTERN_16,JTAG_TESTVECTOR_WIDTH { ignore_bins data_16 =  !binsof(JTAG_TESTVECTOR_WIDTH) intersect{testVectorWidth16Bit};}
	  DATA_PATTERN_24_DATA_WIDTH_CP : cross DATA_PATTERN_24,JTAG_TESTVECTOR_WIDTH { ignore_bins data_24 =  !binsof(JTAG_TESTVECTOR_WIDTH) intersect {testVectorWidth24Bit};}
	  DATA_PATTERN_32_DATA_WIDTH_CP : cross DATA_PATTERN_32,JTAG_TESTVECTOR_WIDTH { ignore_bins data_32 =  !binsof(JTAG_TESTVECTOR_WIDTH) intersect{testVectorWidth32Bit};}

  */    


	  
  endgroup

endclass : JtagControllerDeviceCoverage

function JtagControllerDeviceCoverage :: new(string name= "JtagControllerDeviceCoverage",uvm_component parent);
 super.new(name,parent);
  JtagControllerDeviceCoverGroup = new();
endfunction : new

function void JtagControllerDeviceCoverage :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!(uvm_config_db #(JtagControllerDeviceAgentConfig) :: get(this,"","jtagControllerDeviceAgentConfig",jtagControllerDeviceAgentConfig)))
    `uvm_fatal(get_type_name(),"FAILED TO GET ControllerDevice CONFIG IN COVERRAGE")
endfunction : build_phase

function void JtagControllerDeviceCoverage :: write(JtagControllerDeviceTransaction t);
  testVector =0;
  for(int i=0;i<62 ;i++)
  if(!($isunknown(t.jtagTestVector[i])))
  testVector[j++] = t.jtagTestVector[i];

    
  JtagControllerDeviceCoverGroup.sample(testVector,jtagControllerDeviceAgentConfig );
 
endfunction : write

function void  JtagControllerDeviceCoverage::report_phase(uvm_phase phase);
  `uvm_info(get_type_name(), $sformatf("******************** JTAGController Agent Coverage = %0.2f %% *********************",  JtagControllerDeviceCoverGroup.get_coverage()), UVM_NONE);
  endfunction: report_phase
`endif

