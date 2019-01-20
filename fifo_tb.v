`timescale 1 ps/ 1 ps

module fifo_tb;

parameter FIFO_DEPTH = 256;

reg clock;
reg [7:0] data;
reg rdreq;
reg wrreq;
wire empty;
wire full;
wire [7:0] q;

integer i;


fifo_top	dut (
	.clock ( clock ),
	.data ( data ),
	.rdreq ( rdreq ),
	.wrreq ( wrreq ),
	.empty ( empty ),
	.full ( full ),
	.q ( q )
	);


 
//generate clock
 initial begin
  clock = 0;
  forever #10 clock = ~clock;
end

//test write, read, full and empty
initial begin

		  for (i = 0; i < FIFO_DEPTH; i=i+1) begin
				@(posedge clock);
				wrreq = 1;
				rdreq = 0;
				data = $random;
			end
			@(posedge clock);
			wrreq = 0;
			data = 0;
			
			for (i = 0; i < FIFO_DEPTH; i=i+1) begin
				@(posedge clock);
				rdreq = 1;
				wrreq = 0;
			end
			@(posedge clock);
			rdreq = 0;
	
#5000;
$finish;
end



endmodule