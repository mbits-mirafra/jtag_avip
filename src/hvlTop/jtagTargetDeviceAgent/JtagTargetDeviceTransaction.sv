`ifndef JTAGTargetDeviceTRANSACTION_INCLUDED_
`define JTAGTargetDeviceTRANSACTION_INCLUDED_

class JtagTargetDeviceTransaction extends uvm_sequence_item;

  `uvm_object_utils(JtagTargetDeviceTransaction)

  logic[31:0]jtagTestVector;
  logic[4:0]jtagInstruction;
  extern function new(string name = "JtagTargetDeviceTransaction");
  extern function void do_copy(uvm_object rhs);
  extern function bit do_compare(uvm_object rhs , uvm_comparer comparer = null);
  extern function void do_print(uvm_printer printer);

endclass : JtagTargetDeviceTransaction

function JtagTargetDeviceTransaction :: new(string name = "JtagTargetDeviceTransaction");
  super.new(name);
endfunction  : new


function void JtagTargetDeviceTransaction  :: do_copy(uvm_object rhs);
  JtagTargetDeviceTransaction sourceObject;

  if(!($cast(sourceObject,rhs)))
    `uvm_fatal("DO_COPY","THE TYPE OF SOURCE IS NOT COMPTATIBLE")
 
  super.copy(rhs);
  this.jtagTestVector = sourceObject.jtagTestVector;
endfunction : do_copy

function bit  JtagTargetDeviceTransaction :: do_compare(uvm_object rhs,uvm_comparer comparer=null);
  JtagTargetDeviceTransaction sourceObject;

  if(!($cast(sourceObject,rhs)))
   `uvm_fatal("DO_COMPARE","THE TYPE OF SOURCE IS NOT COMPATIBLE")

  return (super.compare(rhs,comparer) && (this.jtagTestVector == sourceObject.jtagTestVector));
endfunction : do_compare

function void JtagTargetDeviceTransaction :: do_print(uvm_printer printer);
  super.do_print(printer);
  printer.print_field($sformatf("TEST VECTOR"),this.jtagTestVector,$bits(this.jtagTestVector),UVM_BIN);
endfunction : do_print

`endif
