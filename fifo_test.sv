`timescale 1 ps/1 ps

class fifo_test extends uvm_test;
  
  `uvm_component_utils(fifo_test);
  
  fifo_env env;
  
  function new(string name="",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  
  function void build_phase(uvm_phase phase);
    env = fifo_env::type_id::create("env",this);
  endfunction
  
  
  function void end_of_elaboration_phase(uvm_phase phase);
    `uvm_info("",this.sprint(),UVM_NONE)
  endfunction
  
  
  task run_phase(uvm_phase phase);
    fifo_seq seq;
    seq = fifo_seq::type_id::create("seq");
    if(!seq.randomize())
      `uvm_error("","Randomize Failed")
      seq.starting_phase = phase;
      seq.start(env.agent.seqr);
    endtask
    
    
  endclass
