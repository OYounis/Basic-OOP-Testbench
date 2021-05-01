timeunit 1ns;

module alu(
    input logic [31:0] a,b,
    input logic [2:0] op_code,
    input logic clk, nrst,
    
    output logic carry,
    output logic ready,
    output logic [31:0] out 
);
    int delay;
    always_ff @(posedge clk or negedge nrst) begin
        if (!nrst) begin
            carry = '0;
            out = '0;
            ready = 1;
        end else begin
            case (op_code)
                3'b000: begin
                    carry = carry;
                    out = out;
                    ready = 0;
                end 3'b001: begin
                    ready = 0;
                    {carry, out} = a + b;
                    ready = 1;
                end 3'b010: begin
                    ready = 0;
                    {carry, out} = a - b;
                    ready = 1;
                end 3'b011: begin
                    ready = 0;
                    delay = $urandom_range(0, 50);
                    #delay;
                    out = a * b;
                    carry = 0;
                    ready = 1;
                end 3'b100: begin
                    ready = 0;
                    out = a ^ b;
                    carry = 0;
                    ready = 1;
                end 3'b101: begin
                    ready = 0;
                    out = a & b;
                    carry = 0;
                    ready = 1;
                end 3'b110: begin
                    ready = 0;
                    out = a | b;
                    carry = 0;
                    ready = 1;
                end 3'b111: begin
                    ready = 0;
                    out = ~a;
                    carry = 0;
                    ready = 1;
                end default: begin
                    carry = carry;
                    out = out;
                    ready = 0;
                end
            endcase
        end
end
endmodule