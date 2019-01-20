`timescale 1 ps/ 1 ps

`include "fifo_trans.sv"
`include "fifo_seq.sv"
`include "fifo_intf.sv"
`include "fifo_driv.sv"
`include "fifo_mon.sv"
`include "fifo_cov.sv"
`include "fifo_agent.sv"
`include "fifo_env.sv"
`include "fifo_test.sv"

module tb_fifo_top;
  
parameter FIFO_DEPTH = 256;

bit clock;

fifo_intf intf(clock);


fifo_top	dut (
	.clock ( intf.clock ),
	.data ( intf.data ),
	.rdreq ( intf.rdreq ),
	.wrreq ( intf.wrreq ),
	.empty ( intf.empty ),
	.full ( intf.full ),
	.q ( intf.q )
	);


 
//generate clock
 initial begin
  clock = 0;
  forever #10 clock = ~clock;
end

initial begin
  uvm_config_db #(virtual fifo_intf)::set(null,"*","fifo_intf",intf);
  void'(uvm_config_db #(int)::set(null,"*","no_of_transactions",100));
  uvm_top.finish_on_completion = 1;
  run_test("fifo_test");
end

endmodule

