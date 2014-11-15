`include "arbiter.v"
module arbiter_tb;

reg clk, rst, req0,req1;
wire gnt0,gnt1;

initial begin
	$monitor ("rst=%b,req0=%b,req1=%b,gnt0=%b,gnt1=%b",
		rst, req0, req1, gnt0, gnt1);
	clk = 0;
	rst = 0;
	req0 = 0;
	req1 = 0;
	#5  rst = 1;
	#15  rst = 0;
	#10  req0 = 1;
	#10  req0 = 0;
	#10  req1 = 1;
	#10  req1 = 0;
	#10  {req0, req1} = 2'b11;
	#10  {req0, req1} = 2'b00;
	#10  $finish;
end

always begin
  #5  clk =  ! clk;
end

arbiter U0 (
.clk (clk),
.rst (rst),
.req0 (req0),
.req1 (req1),
.gnt0 (gnt0),
.gnt1 (gnt1)
);

endmodule
