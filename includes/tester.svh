class tester;

    virtual interface alu_if alu_vi;
    string TESTNAME;
    command_transaction randomizer;

    function new(virtual interface alu_if alu_if_handle);
        alu_vi = alu_if_handle;
        $value$plusargs("TESTNAME=%s",TESTNAME);
        randomizer = new(alu_vi);
        alu_vi.cmd_transaction_h = randomizer;
        //randomizer = alu_vi.cmd_transaction_h;
    endfunction 

    task execute();
        repeat(100) begin
            @(negedge alu_vi.clk);
            random_arith();
            random_basic();
            random_logic();
            random_multi();
            /*`ifdef MULTI_CYCLE              
            `elsif LOGIC
                if(!(randomizer.randomize() with { op_code inside {[4:7]};}))
                    $fatal("Randomization failed");
            `elsif ARITH
                if(!(randomizer.randomize() with { op_code inside {[1:3]};}))
                    $fatal("Randomization failed");
            `else
                if(!randomizer.randomize())
                    $fatal("Randomization failed");
            `endif*/

            //@(alu_vi.ready);
            alu_vi.a = randomizer.a;
            alu_vi.b = randomizer.b;
            alu_vi.op_code = randomizer.op_code;
        end
    endtask

    function void random_multi();
        if(TESTNAME == "MULTI_CYCLE") begin
            if(!(randomizer.randomize() with { op_code == 3'b011;}))
                $fatal("Randomization failed");
        end
    endfunction

    function void random_logic();
        if(TESTNAME == "LOGIC") begin
            if(!(randomizer.randomize() with { op_code inside {[4:7]};}))
                $fatal("Randomization failed");
        end
    endfunction

    function void random_arith();
        if(TESTNAME == "ARITH") begin
            if(!(randomizer.randomize() with { op_code inside {[1:3]};}))
                $fatal("Randomization failed");
        end
    endfunction

    function void random_basic();
        if(TESTNAME == "BASIC") begin
            if(!randomizer.randomize())
                $fatal("Randomization failed");
        end
    endfunction
endclass : tester