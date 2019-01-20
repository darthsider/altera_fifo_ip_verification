`timescale 1 ps/1 ps

class fifo_mon extends uvm_monitor;
  
  virtual fifo_intf intf;
  fifo_trans trans;
  uvm_analysis_port #(fifo_trans) ap_port;
  `uvm_component_utils(fifo_mon)
  
  function new(string name="",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ap_port = new("ap_port",this);
    trans = fifo_trans::type_id::create("trans");
    if(!uvm_config_db #(virtual fifo_intf)::get(this,"","fifo_intf",intf))
      begin
        `uvm_error("","uvm_config_db get failed in fifo_mon")
      end
    endfunction
    
  
  task run_phase(uvm_phase phase);
  while(1) begin
  @(posedge intf.clock);
  trans = fifo_trans::type_id::create("trans");
  trans.wrreq = intf.wrreq;
  trans.rdreq = intf.rdreq;
  trans.data = intf.data;
  trans.empty = intf.empty;
  trans.full = intf.full;
  trans.q = intf.q;
  ap_port.write(trans);
  end
  endtask

endclass