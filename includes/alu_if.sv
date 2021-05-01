interface alu_if;
    bit [31:0] a;
    bit [31:0] b;
    bit [2:0] op_code;
    bit clk;
    bit nrst;

    bit ready;
    bit carry;
    bit [31:0] out;

    initial begin 
        forever #5 clk = ~clk;
    end
    initial #10 nrst = 1;

    modport c1(
        input a,
        input b,
        input op_code,
        input clk,
        input nrst,

        output carry,
        output out
    );
    
endinterface