class monitor;
  virtual interface alu_if alu_vi;
  
  function new (virtual interface alu_if alu_if_handle);
    alu_vi = alu_if_handle;
  endfunction
   

  
endclass
