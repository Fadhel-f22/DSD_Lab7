`timescale 1ns / 1ps


module tb_Digital_Lock_A;

logic [3:0]password;
logic open;
logic close; 
logic clk;
logic reset_n;
logic locked_state;
logic unlocked_state;

Digital_Lock_A DL (.password(password), .open(open), .unlocked_state(unlocked_state), .clk(clk), .reset_n(reset_n));

always #5 clk = ~clk;

initial begin
#5
    clk = 1'b0;
   reset_n = 1'b0;
   open = 1'b0;
   close = 1'b0;
#10
   reset_n = 1'b1;
#10
   reset_n = 1'b0;
#10
   reset_n = 1'b1; 
   password = 4'b1010;
   open = 1'b1; 
#10
   open = 1'b0; 
#10
   password = 4'b1110;
   open = 1'b1;    
#10
   password = 4'b0101;
   open = 1'b0; 
#10
   open = 1'b1;    
#20
    close = 1'b1;
    open = 1'b0;  
#500   
$finish;   
end   
endmodule
