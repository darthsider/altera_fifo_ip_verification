`timescale 1 ps/ 1 ps

`include "uvm_macros.svh"
import uvm_pkg::*;

class fifo_trans extends uvm_sequence_item;
  
`uvm_object_utils(fifo_trans);

rand bit [7:0] data;
rand bit rdreq;
rand bit wrreq;
//bit rdreq;
//bit wrreq;
bit empty;
bit full;
bit [7:0] q;

constraint wr_rd_c {rdreq != wrreq;};

function new(string name = "");
  super.new(name);
endfunction

endclass