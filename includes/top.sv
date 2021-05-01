import alu_pkg::*;
module top;
    alu_if alu_i();

    alu dut(
        .a          (alu_i.a),
        .b          (alu_i.b),
        .op_code    (alu_i.op_code),
        .clk        (alu_i.clk),
        .nrst       (alu_i.nrst),
        .carry      (alu_i.carry),
        .ready      (alu_i.ready),
        .out        (alu_i.out)
    );

    testbench tst_bench;
    initial begin
        tst_bench = new(alu_i);
        tst_bench.execute();
    end

endmodule