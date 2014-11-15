module arbiter (
clk,   // clock
rst,   // Active high, syn reset
req0, // Request 0
req1, // Request 1
gnt0, // Grant 0
gnt1, // Grant 1
);
input clk, rst, req0, req1;
output gnt0, gnt1;

reg gnt0=0, gnt1=0;

always @ (posedge clk or posedge rst)
	{gnt0, gnt1} <= rst ? 2'b00 : req0 ? 2'b10 : req1 ? 2'b01 : 2'b00;

endmodule
