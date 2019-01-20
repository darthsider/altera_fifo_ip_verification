`timescale 1 ps / 1 ps

class fifo_driv extends uvm_driver #(fifo_trans);
  
  parameter FIFO_DEPTH = 256;
  
  `uvm_component_utils(fifo_driv)
  
  virtual fifo_intf intf;
  int no_transactions;
  
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  
  
  function void build_phase(uvm_phase phase);
    if(!uvm_config_db #(virtual fifo_intf)::get(this,"","fifo_intf",intf))
      `uvm_error("","uvm_config_db::get failed");
    endfunction
    

  task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      `uvm_info("","---------------------------------------------",UVM_MEDIUM)
      `uvm_info("",$sformatf("\t Transaction No. = %0d",no_transactions),UVM_MEDIUM)
      @(posedge intf.clock);
      intf.wrreq <= req.wrreq;
      intf.rdreq <= req.rdreq;
      intf.data <= req.data;
      req.empty = intf.empty;
      req.full = intf.full;
      req.q = intf.q;
      `uvm_info("", $sformatf("\t wrreq = %0b, \t rdreq = %0b,\t data = %0b, \t empty = %0b, \t full = %0b, \t q = %0b",req.wrreq,req.rdreq,req.data,intf.empty,intf.full,intf.q),UVM_MEDIUM)
      `uvm_info("","---------------------------------------------",UVM_MEDIUM)
      @(posedge intf.clock); 
      seq_item_port.item_done();
      no_transactions++;
    end
  endtask

  
  
/*  
task run_phase(uvm_phase phase);
  //test write, read, full and empty
forever begin
       seq_item_port.get_next_item(req);
      `uvm_info("","---------------------------------------------",UVM_MEDIUM)
      //`uvm_info("",$sformatf("\t Transaction No. = %0d",no_transactions),UVM_MEDIUM)
		  `uvm_info("","WRITE FIFO TEST",UVM_MEDIUM)
		  for (int i = 0; i < FIFO_DEPTH; i++) begin
				@(posedge intf.clock);
				intf.wrreq = 1;
				intf.rdreq = 0;
				intf.data = req.data;
				`uvm_info("", $sformatf("\t i = %0d, \t wrreq = %0b, \t rdreq = %0b,\t data = %0d",i,req.wrreq,req.rdreq,req.data),UVM_MEDIUM)
     
				req.empty = intf.empty;
      req.full = intf.full;
      req.q = intf.q;
			`uvm_info("", $sformatf("\t empty = %0b, \t full = %0b, \t q = %0d",req.data,intf.empty,intf.full,intf.q),UVM_MEDIUM)
      
      end
			@(posedge intf.clock);
			intf.wrreq = 0;
			intf.data = 0;
			
			`uvm_info("","READ FIFO TEST",UVM_MEDIUM)
			for (int i = 0; i < FIFO_DEPTH; i++) begin
				@(posedge intf.clock);
				intf.rdreq = 1;
				intf.wrreq = 0;
			  `uvm_info("", $sformatf("\t i = %0d, \t wrreq = %0b, \t rdreq = %0b",i,req.wrreq,req.rdreq),UVM_MEDIUM)
      
			  req.empty = intf.empty;
      req.full = intf.full;
      req.q = intf.q;
			`uvm_info("", $sformatf("\t data = %0d, \t empty = %0b, \t full = %0b, \t q = %0d",req.data,intf.empty,intf.full,intf.q),UVM_MEDIUM)
      
      end
			@(posedge intf.clock);
			intf.rdreq = 0;
	    `uvm_info("","---------------------------------------------",UVM_MEDIUM)
	   seq_item_port.item_done();
     // no_transactions++;
    end
  endtask
*/


  
endclass
      
