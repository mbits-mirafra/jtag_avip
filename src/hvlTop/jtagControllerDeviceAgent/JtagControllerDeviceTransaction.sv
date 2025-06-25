`ifndef JTAGControllerDeviceTRANSACTION_INCLUDED_
`define JTAGControllerDeviceTRANSACTION_INCLUDED_

class JtagControllerDeviceTransaction extends uvm_sequence_item;

  `uvm_object_utils(JtagControllerDeviceTransaction)

  rand logic[31:0]jtagTestVector;
  //logic[61:0]jtagTms = 'b 011000000000000000000000000000000000111000000110;
  logic[4:0]jtagInstruction;

  extern function new(string name = "JtagControllerDeviceTransaction");
  extern function void do_copy(uvm_object rhs);
  extern function bit do_compare(uvm_object rhs , uvm_comparer comparer = null);
  extern function void do_print(uvm_printer printer);

endclass : JtagControllerDeviceTransaction

function JtagControllerDeviceTransaction :: new(string name = "JtagControllerDeviceTransaction");
  super.new(name);
endfunction  : new


function void JtagControllerDeviceTransaction  :: do_copy(uvm_object rhs);
  JtagControllerDeviceTransaction sourceObject;

  if(!($cast(sourceObject,rhs)))
    `uvm_fatal("DO_COPY","THE TYPE OF SOURCE IS NOT COMPTATIBLE")
 
  super.copy(rhs);
  this.jtagTestVector = sourceObject.jtagTestVector;
endfunction : do_copy

function bit JtagControllerDeviceTransaction :: do_compare(uvm_object rhs,uvm_comparer comparer=null);
  JtagControllerDeviceTransaction sourceObject;

  if(!($cast(sourceObject,rhs)))
   `uvm_fatal("DO_COMPARE","THE TYPE OF SOURCE IS NOT COMPATIBLE")

  return (super.compare(rhs,comparer) && (this.jtagTestVector == sourceObject.jtagTestVector));
endfunction : do_compare

function void JtagControllerDeviceTransaction :: do_print(uvm_printer printer);
  super.do_print(printer);
  printer.print_field($sformatf("TEST VECTOR"),this.jtagTestVector,$bits(this.jtagTestVector),UVM_BIN);
endfunction : do_print

`endif
