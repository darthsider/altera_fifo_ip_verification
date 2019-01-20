`timescale 1 ps / 1 ps

typedef uvm_sequencer #(fifo_trans) fifo_seqr;

class fifo_seq extends uvm_sequence #(fifo_trans);
  
  `uvm_object_utils(fifo_seq)
  
  int count;
  
  function new(string name = "");
    super.new(name);
  endfunction
  
  
  task body;
    if(starting_phase != null)
      starting_phase.raise_objection(this);
      void'(uvm_config_db #(int)::get(null,"","no_of_transactions",count));
      repeat(count)
      begin
        req = fifo_trans::type_id::create("req");
        start_item(req);
        if(!req.randomize())
          `uvm_error("","Randomization Failed")
          finish_item(req);
        end
        
        if(starting_phase != null)
          starting_phase.drop_objection(this);
  endtask
        
  
endclass