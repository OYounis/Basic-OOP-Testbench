if [file exists work] {vdel -all}
vlib work
vlog -f compile.f
vsim  top +TESTNAME=BASIC
set  NoQuitOnFinish 1
onbreak {resume}
run -all
#vsim  top +UVM_TESTNAME=MULTI_CYCLE
#run -all
#vsim  top +UVM_TESTNAME=LOGIC
#run -all
#vsim  top +UVM_TESTNAME=ARITH
#run -all
quit
