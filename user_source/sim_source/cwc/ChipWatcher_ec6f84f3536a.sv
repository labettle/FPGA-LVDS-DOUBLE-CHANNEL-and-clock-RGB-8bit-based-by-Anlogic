     
module ChipWatcher_ec6f84f3536a ( 
    input [0:0] probe0, 
    input [7:0] probe1, 
    input [7:0] probe2, 
    input [0:0] probe3, 
    input       clk  
); 
    localparam CWC_BUS_NUM = 4;
    localparam CWC_BUS_DIN_NUM = 18;
    localparam INPUT_PIPE_NUM = 0;
    localparam OUTPUT_PIPE_NUM = 0;
    localparam RAM_LEN = 18;
    localparam RAM_DATA_DEPTH = 1024;

    
    localparam integer CWC_BUS_WIDTH[0:CWC_BUS_NUM-1] = {1,8,8,1};
    localparam integer CWC_BUS_DIN_POS[0:CWC_BUS_NUM-1] = {0,1,9,17};    
    localparam integer CWC_BUS_CTRL_POS[0:CWC_BUS_NUM-1] = {0,6,26,46};    

    parameter STAT_REG_LEN = 24;
    parameter BUS_CTRL_NUM = CWC_BUS_NUM*4 + CWC_BUS_DIN_NUM*2 + 36;

    wire                     cwc_rst;
    wire [BUS_CTRL_NUM-1:0]  cwc_control;
    wire [STAT_REG_LEN-1:0]  cwc_status;  

	top_cwc_hub #(
		.CWC_BUS_NUM(CWC_BUS_NUM),
		.CWC_BUS_DIN_NUM(CWC_BUS_DIN_NUM),
		.CWC_BUS_WIDTH(CWC_BUS_WIDTH),
		.CWC_BUS_DIN_POS(CWC_BUS_DIN_POS),
		.CWC_BUS_CTRL_POS(CWC_BUS_CTRL_POS),
		.RAM_DATA_DEPTH(RAM_DATA_DEPTH),
		.RAM_LEN(RAM_LEN),
		.INPUT_PIPE_NUM(INPUT_PIPE_NUM),
		.OUTPUT_PIPE_NUM(OUTPUT_PIPE_NUM)
	)

	 wrapper_cwc_top(
		.cwc_trig_clk(clk),
		.cwc_control(cwc_control),
		.cwc_status(cwc_status),
		.cwc_rst(cwc_rst),
		.cwc_bus_din({probe0,probe1,probe2,probe3}),
		.ram_data_din({probe0,probe1,probe2,probe3})
	);

    AL_LOGIC_DEBUGHUB #(
		.CTRL_LEN(BUS_CTRL_NUM),
		.STAT_LEN(STAT_REG_LEN)
	) wrapper_debughub(
		.clk(clk),
		.control(cwc_control),
		.status(cwc_status),
		.rst(cwc_rst)
	);

endmodule


