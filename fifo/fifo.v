module fifo(clk, rst, data_in, data_out, wr_en, rd_en, empty, full, cnt);

parameter data_width = 1;
parameter addr_width = 1;
`define BUF_SIZE (1 << addr_width)

input clk, rst, wr_en, rd_en;
input[data_width-1:0] data_in;
output[data_width-1:0] data_out;
output empty, full;
output[addr_width-1:0] cnt;

reg[data_width-1:0] data_out;
reg[addr_width-1:0] cnt;

reg[addr_width-1:0] rd_ptr, wr_ptr;
reg[data_width-1:0] buf_mem[`BUF_SIZE-1:0];
wire rd, wr;

assign full = (cnt == (`BUF_SIZE-1));
assign empty = (!cnt);
assign rd = (!empty && rd_en);
assign wr = (!full && wr_en);

// cnt
always @ (posedge clk or posedge rst)
	cnt <= rst ? 0 : (rd && !wr) ? cnt-1 : (!rd && wr) ? cnt+1 : cnt;

// data_out
always @ (posedge clk or posedge rst)
	data_out <= rst ? 0 : rd ? buf_mem[rd_ptr] : data_out;

// data_in
always @ (posedge clk)
	buf_mem[wr_ptr] <= wr ? data_in : buf_mem[wr_ptr];

// pointers
always @ (posedge clk or posedge rst) begin
	if (rst) begin
		wr_ptr <= 0;
		rd_ptr <= 0;
	end else begin // the pointers overflow on their own
		rd_ptr <= rd ? rd_ptr+1 : rd_ptr;
		wr_ptr <= wr ? wr_ptr+1 : wr_ptr;
	end
end

endmodule
