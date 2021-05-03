class result_monitor extends monitor;
  
   protected rslt rslt_v;
   
   function new (virtual interface alu_if alu_if_handle);
    super.new(alu_if_handle);
  endfunction
  function void connect ();
    alu_vi.result_monitor_h = this;
  endfunction
   
  task execute ();
    @(posedge alu_vi.clk)
    rslt_v.ready = alu_vi.ready;
    rslt_v.carry = alu_vi.carry;
    rslt_v.out   = alu_vi.out;
  endtask
  
  function rslt get_cmd();
    return rslt_v;
  endfunction
  
endclass
