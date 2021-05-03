class result_transaction;
    virtual interface alu_if alu_vi;
    rand bit ready;
    rand bit carry;
    rand bit [31:0] out;
   
    function new (virtual interface alu_if alu_if_handle);
        alu_vi = alu_if_handle;
    endfunction
    
    function void connect ();
        alu_vi.rslt_transaction_h = this;
    endfunction

    function void do_copy(result_transaction rhs);
        //result_transaction copied_transaction_h;

        if(rhs == null) $warning("could not connect to null object");

        //if(!$cast(copied_transaction_h, rhs)) $fatal("Could not cast");

        /*ready = copied_transaction_h.ready;
        carry = copied_transaction_h.carry;
        out   = copied_transaction_h.out;*/

        ready = rhs.ready;
        carry = rhs.carry;
        out   = rhs.out;
    endfunction

    function result_transaction clone_me();
        result_transaction clone;

        clone.ready = this.ready;
        clone.carry = this.carry;
        clone.out   = this.out;

        return clone;
    endfunction

    function bit do_compare(result_transaction rhs);
        result_transaction compared_transaction_h;
        bit same;

        if(rhs == null) $fatal("could not connect to null object");
        if(!$cast(compared_transaction_h, rhs)) 
            same = 0;
        else 
            same = (compared_transaction_h.ready  == this.ready) &&
                    (compared_transaction_h.carry == this.carry) &&
                    (compared_transaction_h.out   == this.out);

        return same;
    endfunction

    function string convert2string();
        string s;
        s = $sformatf("ready: %h, carry: %h, out: %h", ready, carry, out);
        return s;
    endfunction
endclass
