import_device ph1_35p.db -package PH1P35MDG324
set_param flow ooc_flow on
read_verilog -file "test_case_watcherInst.sv"
optimize_rtl
map_macro
map
pack
report_area -file test_case_gate.area
export_db -mode ooc "test_case_ooc.db"
