module hello_pli ();

reg[0:31] val;

initial begin
	val = 1;
	$hello(val);
	$display("%x", val);
	$finish;
end

endmodule
