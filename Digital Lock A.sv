`timescale 1ns / 1ps



module Digital_Lock_A(
input logic [3:0]password,
input logic open,
//input logic close, 
input logic clk,
input logic reset_n,
//output logic locked_state,
output logic unlocked_state
    );
    
typedef enum logic [2:0] {
S1,
S2
} state_t;   

state_t current_state, next_state;

// State transition on clock edge
always @ ( posedge clk, negedge reset_n) 
begin
    if (!reset_n)
        current_state <= S1;
    else
        current_state <= next_state;
end     

//assign password = 4'b0101;

// Next-state logic 
always @ (current_state, password, open)
begin
    case (current_state)
    
        S1: next_state = ((password == 4'b0101) & open) ? S2 : S1;
        S2: next_state = (~open) ? S1 : S2;
        default: next_state = S1;
    
    endcase
end

// Output logic
always_comb 
begin
//    locked_state = (current_state == S1);
    unlocked_state = (current_state == S2) ? 1'b1: 1'b0; 
end     
endmodule