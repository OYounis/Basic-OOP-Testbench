class testbench;

    virtual interface alu_if alu_vi;

    coverage cvg;
    tester tst;
    scoreboard scr;
    //random rnd;
    command_monitor cmd_v;
    result_monitor rslt_v;
    //command_transaction cmd_tx;
    result_transaction rslt_tx;

    function new(virtual interface alu_if alu_if_handle);
        alu_vi = alu_if_handle;
    endfunction

    task execute();
        cmd_v = new(alu_vi);
        cmd_v.connect();
        rslt_v = new(alu_vi);
        rslt_v.connect();
        //rnd = new();
        cvg = new(alu_vi);
        tst = new(alu_vi);
        scr = new(alu_vi);

        fork
            cvg.execute();
            tst.execute();
            scr.execute();
            //cmd_v.execute();
            //rslt_v.execute();
        join_any

       // $stop;
    endtask
endclass