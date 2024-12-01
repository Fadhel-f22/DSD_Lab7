`timescale 1ns / 1ps


module Sequence_Detector(
input logic clk,
input logic reset_n,
input logic in_bit,
output logic detected
    );
    
typedef enum logic [2:0] {
IDLE,
S1,
S2,
S3,
S4
} state_t;

state_t current_state, next_state;

// State transition on clock edge
 
always @ ( posedge clk, negedge reset_n) 
begin
    if (!reset_n)
        current_state <= IDLE;
    else
        current_state <= next_state;
end    

// Next-state logic
always @ (current_state, in_bit)
begin
    case (current_state)
    
        IDLE: next_state = in_bit ? S1 : IDLE;
        S1: next_state = in_bit ? S1 : S2;
        S2: next_state = in_bit ? S3 : IDLE;
        S3: next_state = in_bit ? S4 : S2;
        S4: next_state = in_bit ? S1 : S2;
        default: next_state = IDLE;
    
    endcase
end     

// Output logic
always_comb 
begin
    detected = (current_state == S4);
end

    
endmodule
