class command_monitor extends monitor;
  
   
   protected cmd cmd_v; 
   
   
  function new (virtual interface alu_if alu_if_handle);
    super.new(alu_if_handle);
  endfunction
  
  function void connect ();
    alu_vi.command_monitor_h = this;
  endfunction
   
  task execute ();
    @(posedge alu_vi.clk)
    cmd_v.a = alu_vi.a;
    cmd_v.b = alu_vi.b;
    cmd_v.op_code = alu_vi.op_code;
  endtask
  
  function cmd get_cmd();
    return cmd_v;
  endfunction
  
endclass

