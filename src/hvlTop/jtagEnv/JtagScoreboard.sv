`ifndef JTAGSCOREBOARD_INCLUDED_
`define JTAGSCOREBOARD_INCLUDED_

class JtagScoreboard extends uvm_scoreboard;
 `uvm_component_utils(JtagScoreboard)

 uvm_analysis_export #(JtagControllerDeviceTransaction) jtagScoreboardControllerDeviceAnalysisExport;
 uvm_analysis_export #(JtagTargetDeviceTransaction)  jtagScoreboardTargetDeviceAnalysisExport;

 uvm_tlm_analysis_fifo #(JtagControllerDeviceTransaction) jtagScoreboardControllerDeviceAnalysisFifo;
 uvm_tlm_analysis_fifo #(JtagTargetDeviceTransaction) jtagScoreboardTargetDeviceAnalysisFifo; 
 
 JtagControllerDeviceTransaction jtagControllerDeviceTransaction;
 JtagTargetDeviceTransaction jtagTargetDeviceTransaction;

 extern function new(string name = "JtagScoreboard" , uvm_component parent);
 extern virtual function void build_phase(uvm_phase phase);
 extern virtual function void connect_phase(uvm_phase phase);
 extern virtual task run_phase(uvm_phase phase);

endclass : JtagScoreboard


function JtagScoreboard  :: new (string name = "JtagScoreboard",uvm_component parent);
  super.new(name,parent);
endfunction : new

function void JtagScoreboard :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  jtagScoreboardControllerDeviceAnalysisExport = new("jtagScoreboardControllerDeviceAnalysisExport",this);
  jtagScoreboardTargetDeviceAnalysisExport = new("jtagScoreboardTargetDeviceAnalysisExport",this);
  jtagScoreboardControllerDeviceAnalysisFifo = new("jtagScoreboardControllerDeviceAnalysisFifo",this);
  jtagScoreboardTargetDeviceAnalysisFifo = new("jtagScoreboardTargetDeviceAnalysisFifo",this);
 
endfunction : build_phase

function void JtagScoreboard :: connect_phase(uvm_phase phase);
  super.connect_phase(phase);

  jtagScoreboardControllerDeviceAnalysisExport.connect(jtagScoreboardControllerDeviceAnalysisFifo.analysis_export);
  jtagScoreboardTargetDeviceAnalysisExport.connect(jtagScoreboardTargetDeviceAnalysisFifo.analysis_export);

endfunction:connect_phase

task compareResult(JtagControllerDeviceTransaction jtagControllerDeviceTransaction,JtagTargetDeviceTransaction jtagTargetDeviceTransaction);
  if((jtagControllerDeviceTransaction.jtagTestVector ===jtagTargetDeviceTransaction.jtagTestVector)&& (jtagControllerDeviceTransaction.jtagInstruction===jtagTargetDeviceTransaction.jtagInstruction))
  begin 
    `uvm_info("[ PASS ]",$sformatf("TDI = %b AND INSTRUCTION=%b",jtagControllerDeviceTransaction.jtagTestVector,jtagControllerDeviceTransaction.jtagInstruction),UVM_LOW);
  end 
  else begin 
   `uvm_info("[ FAIL ]",$sformatf("TDI = %b AND INSTRUCTION=%b",jtagControllerDeviceTransaction.jtagTestVector,jtagControllerDeviceTransaction.jtagInstruction),UVM_LOW);
  end 
endtask 

task JtagScoreboard :: run_phase(uvm_phase phase);
  super.run_phase(phase);
  forever begin 
    jtagScoreboardControllerDeviceAnalysisFifo.get(jtagControllerDeviceTransaction);
    `uvm_info("[ControllerDevice TRANSACTION IN SCB]",$sformatf("THE INSTRUCTION IS %b and test vector is %b",jtagControllerDeviceTransaction.jtagInstruction,jtagControllerDeviceTransaction.jtagTestVector),UVM_LOW);
  
  jtagScoreboardTargetDeviceAnalysisFifo.get(jtagTargetDeviceTransaction);
   `uvm_info("[TargetDevice TRANSACTION IN SCB]",$sformatf("THE INSTRUCTION IS %b and test vector is %b",jtagTargetDeviceTransaction.jtagInstruction,jtagTargetDeviceTransaction.jtagTestVector),UVM_LOW);

compareResult(jtagControllerDeviceTransaction,jtagTargetDeviceTransaction);

  end 
endtask : run_phase 

`endif
