module test_case (  
    cwc_rst, cwc_control, cwc_status, cwc_trig_clk, cwc_bus_din, ram_data_din
);

    localparam CWC_BUS_NUM = 10;
    localparam CWC_BUS_DIN_NUM = 34;
    localparam RAM_LEN = 34;
    localparam INPUT_PIPE_NUM = 0;
    localparam OUTPUT_PIPE_NUM = 0;
    localparam RAM_DATA_DEPTH = 8192;
    localparam integer CWC_BUS_WIDTH[0:9] = {1,1,7,1,7,1,1,7,7,1};
    localparam integer CWC_BUS_DIN_POS[0:9] = {0,1,2,9,10,17,18,19,26,33};    
    localparam integer CWC_BUS_CTRL_POS[0:9] = {0,6,12,30,36,54,60,66,84,102};    

    input                                            cwc_rst;       
    input  [CWC_BUS_NUM*4+CWC_BUS_DIN_NUM*2+36-1:0]  cwc_control;   
    output [23:0]                                    cwc_status;    //cwc status register 
    input                                            cwc_trig_clk;  //cwc trigger clock
    input  [CWC_BUS_DIN_NUM-1:0]                     cwc_bus_din;   //cwc trigger bus input
    input  [RAM_LEN-1:0]                             ram_data_din;

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
		.cwc_trig_clk(cwc_trig_clk),
		.cwc_control(cwc_control),
		.cwc_status(cwc_status),
		.cwc_rst(cwc_rst),
		.cwc_bus_din(cwc_bus_din),
		.ram_data_din(ram_data_din)
	);

endmodule


