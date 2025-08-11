module rx_pll(    
    input	wire		I_clk, 
    input	wire		I_tx_rst,  
    output	wire		O_rx_rst,
    output	wire		O_clk_1x,
    output	wire		O_clk_3p5x
);
	
    
    wire		S_pll_lock;
    reg [8:0]	S_cnt_rst = 9'd0;
    wire		S_pll_rst;
    
    
    always@(posedge I_clk)begin
		if(S_cnt_rst == 9'd250)
			S_cnt_rst <= S_cnt_rst;
		else
			S_cnt_rst <= S_cnt_rst + 1'b1;
	end
    
    
	assign S_pll_rst = (S_cnt_rst < 9'd200) ? 1'b1:1'b0;

    
	RX_PLL u_rx_pll(
		.refclk		(	I_clk				),
		.clk0_out	(	O_clk_1x			),
		.clk1_out	(	O_clk_3p5x			),
		.lock		(	S_pll_lock			),
		.pllreset	(	S_pll_rst				)
	);
    
    
    assign	O_rx_rst = ~S_pll_lock;   



endmodule
