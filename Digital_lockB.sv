`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2024 12:55:48 PM
// Design Name: 
// Module Name: Digital_lockB
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


module Digital_lockB(
input logic [3:0]password,
input logic open,
input logic clk,
input logic reset_n,
output logic filed_state,
output logic unlocked_state
    );
    
typedef enum logic [2:0] {
S1,
S2,
S3
} state_t;   

state_t current_state, next_state;

logic [1:0] number_of_detection;
logic [3:0] number_of_sec;
// State transition on clock edge
always @ ( posedge clk, negedge reset_n) 
begin
    if (!reset_n)
        current_state <= S1;
    else
        current_state <= next_state;
end   

always @(posedge clk or negedge reset_n)
begin
    if (!reset_n)  begin
        number_of_detection <= 2'b00;
        number_of_sec <= 4'b0000;
        end
    else if(filed_state)
        number_of_sec <= number_of_sec + 1;
    else if (password != 4'b0101 | open) begin
        number_of_detection <= number_of_detection + 1;
        number_of_sec <= 0;
        end
    
end  


//assign password = 4'b0101;

// Next-state logic 
always @ (current_state, password, open,number_of_sec )
begin
    case (current_state)
    
        S1: next_state = ((password == 4'b0101) & open) ? S2 :
       (number_of_detection == 2'b11) ? S3 : S1;
        S2: next_state = (~open) ? S1 : S2;
        S3: next_state = (number_of_sec >= 9)? S1 :S3;//(~open) ? S1 : S2;
        default: next_state = S1;
    
    endcase
end

// Output logic
always_comb 
begin
    filed_state = (current_state == S3)  ? 1'b1: 1'b0; ;
    unlocked_state = (current_state == S2) ? 1'b1: 1'b0; 
end     
endmodule
