`ifndef JTAGVIRTUALBASESEQUENCE_INCLUDED_
`define JTAGVIRTUALBASESEQUENCE_INCLUDED_

class JtagVirtualBaseSequence extends uvm_sequence;
  `uvm_object_utils(JtagVirtualBaseSequence)
  `uvm_declare_p_sequencer(JtagVirtualSequencer)

  extern function new(string name = "JtagVirtualBaseSequence");
  extern virtual task body();

endclass : JtagVirtualBaseSequence

function JtagVirtualBaseSequence :: new(string name = "JtagVirtualBaseSequence");
  super.new(name);
endfunction : new

task JtagVirtualBaseSequence :: body();
 
if(!($cast(p_sequencer,m_sequencer)))
  `uvm_fatal("VIRTUAL SEQUENCE","VIRTUAL SEQUENCER TYPE CASTING FAILED")

endtask : body
`endif
