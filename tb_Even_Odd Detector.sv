`timescale 1ns / 1ps


module tb_Even_Odd_Detector;

logic clk;
logic reset_n;
logic in_bit;
logic detected_0;
logic detected_1;



Even_Odd_Detector EOD (.clk(clk), .reset_n(reset_n), .in_bit(in_bit), .detected_1(detected_1), .detected_0(detected_0));
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
   in_bit = 1'b0;
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

                                                         
                                   

#500
$finish;
end 
endmodule
