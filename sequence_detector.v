`timescale 1ns/1ps

module sequence_detector (
    input clk,
    input rst,
    input din,
    output reg dout
);

    parameter S0 = 3'b000,
              S1 = 3'b001,
              S2 = 3'b010,
              S3 = 3'b011,
              S4 = 3'b100;

    reg [2:0] state, next_state;

    
    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= S0;
        else
            state <= next_state;
    end

    
    always @(*) begin
        case (state)
            S0: next_state = din ? S1 : S0;
            S1: next_state = din ? S1 : S2;
            S2: next_state = din ? S3 : S0;
            S3: next_state = din ? S1 : S4;
            S4: next_state = din ? S3 : S0;

            default: next_state = S0;
        endcase
    end

    
    always @(*) begin
        dout = (state == S4 && din == 0);
    end

endmodule
