`timescale 1ns / 1ps



module Even_Odd_Detector(
input logic clk,
input logic reset_n,
input logic in_bit,
output logic detected_1,
output logic detected_0
    );
 
typedef enum logic [2:0] {
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
        current_state <= S1;
    else
        current_state <= next_state;
end    

// Next-state logic 
always @ (current_state, in_bit)
begin
    case (current_state)
    
        S1: next_state = in_bit ? S2 : S4;
        S2: next_state = in_bit ? S1 : S3;
        S3: next_state = in_bit ? S4 : S2;
        S4: next_state = in_bit ? S3 : S1;
        default: next_state = S1;
    
    endcase
end     

// Output logic
always_comb 
begin
    detected_1 = (current_state == S1 | current_state == S4);
    detected_0 = (current_state == S1 | current_state == S2);
end
    
endmodule
