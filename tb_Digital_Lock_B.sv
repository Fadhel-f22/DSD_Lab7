`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2024 02:09:23 PM
// Design Name: 
// Module Name: tb_Digital_Lock_B
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_Digital_Lock_B;

logic [3:0]password;
logic open;
//logic close; 
logic clk;
logic reset_n;
//logic locked_state;
logic unlocked_state;
logic filed_state;

Digital_lockB DL (.password(password), .open(open), .unlocked_state(unlocked_state), .clk(clk), .reset_n(reset_n), .filed_state(filed_state));

always #5 clk = ~clk;

initial begin
#5
    clk = 1'b0;
   reset_n = 1'b0;
   open = 1'b0;
//   close = 1'b0;
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
   password = 4'b0111;
   open = 1'b0; 
#10
   open = 1'b1;    
#20
    open = 1'b0;  
#10
   password = 4'b0111;
   open = 1'b1; 
   
#20
   password = 4'b0101;
   open = 1'b1;    
#500   
$finish;   
end   
endmodule


