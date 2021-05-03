class scoreboard;
  
  command_monitor command_monitor_h;
  result_monitor  result_monitor_h;
    
    virtual interface alu_if alu_vi;
    int predicted = 0;
    bit pass;
    
    command_transaction cmd_v;
    result_transaction rslt_v;

    function new(virtual interface alu_if alu_if_handle);
        alu_vi = alu_if_handle;
        command_monitor_h = alu_vi.command_monitor_h;
        result_monitor_h  = alu_vi.result_monitor_h;
    endfunction 

    task execute();
        forever begin
            @(posedge alu_vi.clk);
            result_monitor_h.get_cmd();
            rslt_v = new(alu_vi);
            rslt_v.do_copy(alu_vi.rslt_transaction_h);
            cmd_v = command_monitor_h.get_cmd();
            @(posedge rslt_v.ready);
            case (cmd_v.op_code)
                3'b001: predicted  = cmd_v.a + cmd_v.b;
                3'b010: predicted  = cmd_v.a - cmd_v.b;
                3'b011: predicted  = cmd_v.a * cmd_v.b;
                3'b100: predicted  = cmd_v.a ^ cmd_v.b;
                3'b101: predicted  = cmd_v.a & cmd_v.b;
                3'b110: predicted  = cmd_v.a | cmd_v.b;
                3'b111: predicted  = ~cmd_v.a;
                default: predicted = predicted;
            endcase

            pass = (predicted == rslt_v.out);
            if(!pass) $error("Check failed: a = %h, b = %h, op_code = %h", cmd_v.a, cmd_v.b, cmd_v.op_code);
        end
    endtask
endclass
