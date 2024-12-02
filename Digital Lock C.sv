`timescale 1ns / 1ps


module Digital_Lock_C(
input logic [3:0]password,
input logic open,
input logic clk,
input logic reset_n,
input logic change_password,
output logic filed_state,
output logic unlocked_state
    );
    
typedef enum logic [2:0] {
S1,
S2,
S3,
S4
} state_t;   

state_t current_state, next_state;

logic [1:0] number_of_detection;
logic [3:0] number_of_sec;
logic [3:0] pass;

// State transition on clock edge
always @ ( posedge clk, negedge reset_n) 
begin
    if (!reset_n)
        current_state <= S1;
    else
        current_state <= next_state;
end   


// register
always @ ( posedge clk, negedge reset_n) 
begin
    if (!reset_n)
        pass <= 4'b0101;
        
    else if (change_password & open)
        pass <= password;
end


// counter
always @(posedge clk or negedge reset_n)
begin
    if (!reset_n)  begin
        number_of_detection <= 2'b00;
        number_of_sec <= 4'b0000;
        end
    else if(filed_state)
        number_of_sec <= number_of_sec + 1;
    else if (password != pass) 
    begin
        number_of_detection <= number_of_detection + 1;
        number_of_sec <= 0;
    end
    else if (password == pass) 
        number_of_detection <= 0;
end  


// Next-state logic 
always @ (current_state, password, open,number_of_sec, change_password)
begin
    case (current_state)
    
        S1: next_state = ((password == pass) & open) ? S2 :
        (number_of_detection == 2'b11) ? S3 : S1;
        S2: next_state = (~open) ? S1 : 
        (change_password) ? S4 : S2;
        S3: next_state = (number_of_sec >= 9)? S1 : S3;
        S4: next_state = (~change_password) ? S1: S4;
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
    
   