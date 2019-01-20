`timescale 1 ps/ 1 ps

interface fifo_intf(input logic clock);

logic [7:0] data;
logic rdreq;
logic wrreq;
logic empty;
logic full;
logic [7:0] q;

endinterface