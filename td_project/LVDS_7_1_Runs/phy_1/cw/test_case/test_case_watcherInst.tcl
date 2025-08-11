source "D:/APP/Anlogic/ip/depot/ChipWatcher_1.0/ChipWatcher/Other/templa.tcl"
set fd [open "D:/APP/Anlogic/ip/depot/ChipWatcher_1.0/ChipWatcher/Other/cwc.atpl" r]
set tmpl [read $fd]
close $fd
set parser [::tmpl_parser::tmpl_parser $tmpl]

set ComponentName   test_case
set bus_num         10
set bus_din_num     34
set ram_len         34
set input_pipe_num  0
set output_pipe_num 0
set depth           8192
set bus_width    { 1,1,7,1,7,1,1,7,7,1 };
set bus_din_pos  { 0,1,2,9,10,17,18,19,26,33 };
set bus_ctrl_pos { 0,6,12,30,36,54,60,66,84,102 };
set fp [open "cw/test_case//test_case_watcherInst.sv" w+]
puts $fp [eval $parser]
close $fp
