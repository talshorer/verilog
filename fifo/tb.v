/*
 * downloaded from http://electrosofts.com/verilog/fifo.html
 * only changed names and defines
 */

`include "fifo.v"
`define DATA_WIDTH 8
`define ADDR_WIDTH 8

module fifo_test();
reg clk, rst, wr_en, rd_en ;
reg[`DATA_WIDTH-1:0] buf_in;
reg[`DATA_WIDTH-1:0] tempdata;
wire [`DATA_WIDTH-1:0] buf_out;
wire [`ADDR_WIDTH-1:0] fifo_counter;

fifo ff( .clk(clk), .rst(rst), .data_in(buf_in), .data_out(buf_out), 
         .wr_en(wr_en), .rd_en(rd_en), .empty(buf_empty), 
         .full(buf_full), .cnt(fifo_counter) );

initial
begin
   clk = 0;
   rst = 1;
        rd_en = 0;
        wr_en = 0;
        tempdata = 0;
        buf_in = 0;


        #15 rst = 0;
  
        push(1);
        fork
           push(2);
           pop(tempdata);
        join              //push and pop together   
        push(10);
        push(20);
        push(30);
        push(40);
        push(50);
        push(60);
        push(70);
        push(80);
        push(90);
        push(100);
        push(110);
        push(120);
        push(130);

        pop(tempdata);
        push(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
   push(140);
        pop(tempdata);
        push(tempdata);//
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        push(5);
        pop(tempdata);
        $finish;
end

always
   #5 clk = ~clk;

task push;
input[`DATA_WIDTH-1:0] data;


   if( buf_full )
            $display("---Cannot push: Buffer Full---");
        else
        begin
           $display("push ", data);
           buf_in = data;
           wr_en = 1;
                @(posedge clk);
                #1 wr_en = 0;
        end

endtask

task pop;
output [`DATA_WIDTH-1:0] data;

   if( buf_empty )
            $display("---Cannot Pop: Buffer Empty---");
   else
        begin

     rd_en = 1;
          @(posedge clk);

          #1 rd_en = 0;
          data = buf_out;
           $display("pop ", data);

        end
endtask

endmodule
