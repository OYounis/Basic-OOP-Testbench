class coverage;
    bit [2:0] op_code;
    virtual interface alu_if alu_vi;
    command_monitor command_monitor_h; 
    command_transaction cmd_v;   
    
    covergroup op_cov;
        coverpoint op_code{
            bins single_cycle[] = {[0:2], [4:7]};
            bins multi_cycle    = {3'b011};
            bins logical[]      = {[4:7]};
            bins arith[]        = {[1:3]};
            bins add[] = {3'b001};
            bins sub[] = {3'b010};
            bins nop[] = {3'b000};
            bins mul[] = {3'b011};
            bins o_xor[] = {3'b100};
            bins o_and[] = {3'b101};
            bins o_or[]  = {3'b110};
            bins o_not[] = {3'b111};
        }
    endgroup

    function new (virtual interface alu_if alu_if_handle);
        op_cov = new();
        alu_vi = alu_if_handle;
        cmd_v = new(alu_vi);
        command_monitor_h = alu_vi.command_monitor_h; 
    endfunction
    
    task execute();
        forever begin
            @(negedge alu_vi.clk);
            cmd_v = command_monitor_h.get_cmd();
            op_code = cmd_v.op_code;
            op_cov.sample();
        end 
   endtask
endclass 