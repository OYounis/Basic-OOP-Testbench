class command_transaction;
    virtual interface alu_if alu_vi;
    rand bit [31:0] a;
    rand bit [31:0] b;
    rand bit [2:0] op_code;
   
    function new (virtual interface alu_if alu_if_handle);
        alu_vi = alu_if_handle;
    endfunction
    
    function void connect ();
        alu_vi.cmd_transaction_h = this;
    endfunction

    function void do_copy(command_transaction rhs);
        command_transaction copied_transaction_h;

        if(rhs == null) $fatal("could not connect to null object");

        if(!$cast(copied_transaction_h, rhs)) $fatal("Could not cast");

        a       = copied_transaction_h.a;
        b       = copied_transaction_h.b;
        op_code = copied_transaction_h.op_code;
    endfunction

    function command_transaction clone_me();
        command_transaction clone;

        clone.a = this.a;
        clone.b = this.b;
        clone.op_code = this.op_code;

        return clone; 
    endfunction

    function bit do_compare(command_transaction rhs);
        command_transaction compared_transaction_h;
        bit same;

        if(rhs == null) $fatal("could not connect to null object");
        if(!$cast(compared_transaction_h, rhs)) 
            same = 0;
        else 
            same = (compared_transaction_h.a == this.a) &&
                    (compared_transaction_h.b == this.b) &&
                    (compared_transaction_h.op_code == this.op_code);

        return same;
    endfunction

    function string convert2string();
        string s;
        s = $sformatf("a: %h, b: %h, op_code: %h", a, b, op_code);

        return s;
    endfunction
endclass
