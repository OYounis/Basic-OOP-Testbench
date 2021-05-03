class result_monitor extends monitor;
  
   //protected rslt rslt_v;
   //protected result_transaction rslt_v;
   
   function new (virtual interface alu_if alu_if_handle);
    super.new(alu_if_handle);
  endfunction

  function void connect ();
    alu_vi.result_monitor_h = this;
  endfunction
   
  /*task execute ();
    @(posedge alu_vi.clk)
    rslt_v.ready = alu_vi.ready;
    rslt_v.carry = alu_vi.carry;
    rslt_v.out   = alu_vi.out;
  endtask*/
/*
  task execute();
    forever begin
        get_cmd();
    end
  endtask
 */ 
  /*function rslt get_cmd();
    return rslt_v;
  endfunction
  */

  /*function result_transaction get_cmd();
    return rslt_v;
  endfunction*/

    function void get_cmd();
        result_transaction cmd_v;
        cmd_v = new(alu_vi);
        cmd_v.ready = alu_vi.ready;
        cmd_v.carry = alu_vi.carry;
        cmd_v.out = alu_vi.out;        
        alu_vi.rslt_transaction_h = new(alu_vi);
        alu_vi.rslt_transaction_h.do_copy(cmd_v);
    endfunction
endclass
