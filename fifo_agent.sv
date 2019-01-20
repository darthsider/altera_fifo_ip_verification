`timescale 1 ps/1 ps

class fifo_agent extends uvm_agent;
  
  `uvm_component_utils(fifo_agent)
  
  fifo_seqr seqr;
  fifo_driv driv;
  fifo_mon mon;
  fifo_cov cov;
  
  function new(string name="",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    seqr = fifo_seqr::type_id::create("seqr",this);
    driv = fifo_driv::type_id::create("driv",this);
    mon = fifo_mon::type_id::create("mon",this);
    cov = fifo_cov::type_id::create("cov",this);
  endfunction
  
  
  function void connect_phase(uvm_phase phase);
    driv.seq_item_port.connect(seqr.seq_item_export);
    mon.ap_port.connect(cov.analysis_export);
  endfunction
  
  
endclass
