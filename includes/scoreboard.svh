class scoreboard;
    
    virtual interface alu_if alu_vi;
    int predicted = 0;
    bit pass;

    function new(virtual interface alu_if alu_if_handle);
        alu_vi = alu_if_handle;
    endfunction 

    task execute();
        forever begin
            @(posedge alu_vi.ready);
            case (alu_vi.op_code)
                3'b001: predicted  = alu_vi.a + alu_vi.b;
                3'b010: predicted  = alu_vi.a - alu_vi.b;
                3'b011: predicted  = alu_vi.a * alu_vi.b;
                3'b100: predicted  = alu_vi.a ^ alu_vi.b;
                3'b101: predicted  = alu_vi.a & alu_vi.b;
                3'b110: predicted  = alu_vi.a | alu_vi.b;
                3'b111: predicted  = ~alu_vi.a;
                default: predicted = predicted;
            endcase

            pass = (predicted == alu_vi.out);
            if(!pass) $error("Check failed: a = %h, b = %h, op_code = %h", alu_vi.a, alu_vi.b, alu_vi.op_code);
        end
    endtask
endclass
