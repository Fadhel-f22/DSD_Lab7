`timescale 1ns / 1ps


module tb_Sequence_Detector;
logic clk;
logic reset_n;
logic in_bit;
logic detected;



Sequence_Detector SD (.clk(clk), .reset_n(reset_n), .in_bit(in_bit), .detected(detected));
always #5 clk = ~clk;

initial begin
#5
    clk = 1'b0;
   reset_n = 1'b0; 
#10
   reset_n = 1'b1;
#10
   reset_n = 1'b0;
#10
   reset_n = 1'b1;   
   in_bit = 1'b0;
#10
   in_bit = 1'b1;
#10
   in_bit = 1'b0;
#10
   in_bit = 1'b0;
#10
   in_bit = 1'b1;
#10
   in_bit = 1'b0;
#10
   in_bit = 1'b1;
#10
   in_bit = 1'b1;
#10
   in_bit = 1'b0;
#10
   in_bit = 1'b1;
#10
   in_bit = 1'b1;
#10
   in_bit = 1'b1;
#10
   in_bit = 1'b0;
#10
   in_bit = 1'b1;
#10
   in_bit = 1'b1;
#10
   in_bit = 1'b0;
                                                         
                                   

#500
$finish;
end 
endmodule
