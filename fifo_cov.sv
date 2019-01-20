`timescale 1 ps/1 ps

class fifo_cov extends uvm_subscriber #(fifo_trans);
  
  `uvm_component_utils(fifo_cov)
  fifo_trans trans;
  
  
  covergroup cov_inst;
  WRREQ:coverpoint trans.wrreq {option.auto_bin_max = 1;}
  RDREQ:coverpoint trans.rdreq {option.auto_bin_max = 1;}
  DATA:coverpoint trans.data {option.auto_bin_max = 8;}
  FULL:coverpoint trans.full {option.auto_bin_max = 1;}
  EMPTY:coverpoint trans.empty {option.auto_bin_max = 1;}
  Q:coverpoint trans.q {option.auto_bin_max = 8;}
  endgroup


function new(string name="",uvm_component parent);
  super.new(name,parent);
  cov_inst = new();
endfunction

function void build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction

virtual function void write(fifo_trans t);
$cast(trans, t);
cov_inst.sample();
endfunction

endclass
