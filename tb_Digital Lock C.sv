`timescale 1ns / 1ps


module tb_Digital_Lock_C;

logic [3:0]password;
logic open;
logic clk;
logic reset_n;
logic change_password;
logic filed_state;
logic unlocked_state;

Digital_Lock_C DL (.password(password), .open(open), .unlocked_state(unlocked_state), .clk(clk), .reset_n(reset_n), .change_password(change_password), .filed_state(filed_state));

always #5 clk = ~clk;

initial begin
#5
   clk = 1'b0;
   reset_n = 1'b0;
   open = 1'b0;
   change_password = 1'b0;
   
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
   password = 4'b0101;
   open = 1'b0; 
#10
   open = 1'b1;    
#20
    change_password = 1'b1;
#10
    password = 4'b1000; 
#20
    change_password = 1'b0;
 #10
   password = 4'b0101;
   open = 1'b0; 
#10
   open = 1'b1;
   #10
   password = 4'b0101;
   open = 1'b0; 
#10
   open = 1'b1;
   #10
   password = 4'b0101;
   open = 1'b0; 
#10
   open = 1'b1;
#50
   password = 4'b1000;
   open = 1'b1;             
#500   
$finish;   
end   
endmodule


