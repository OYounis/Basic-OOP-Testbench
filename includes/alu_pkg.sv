package alu_pkg;
  
    typedef struct {
    bit [31:0] a;
    bit [31:0] b;
    bit [2:0] op_code;
   } cmd;
   
   typedef struct { 
    bit ready;
    bit carry;
    bit [31:0] out;
   } rslt;
`include "command_transaction.svh"
`include "result_transaction.svh"
`include "monitor.svh"
`include "command_monitor.svh"
`include "result_monitor.svh"
`include "coverage.svh"
`include "tester.svh"
`include "scoreboard.svh"
`include "testbench.svh"


endpackage : alu_pkg