class testbench;

    virtual interface alu_if alu_vi;

    coverage cvg;
    tester tst;
    scoreboard scr;
    random rnd;

    function new(virtual interface alu_if alu_if_handle);
        alu_vi = alu_if_handle;
    endfunction

    task execute();
        rnd = new();
        cvg = new(alu_vi);
        tst = new(alu_vi, rnd);
        scr = new(alu_vi);

        fork
            cvg.execute();
            tst.execute();
            scr.execute();
        join_any

        $stop;
    endtask
endclass