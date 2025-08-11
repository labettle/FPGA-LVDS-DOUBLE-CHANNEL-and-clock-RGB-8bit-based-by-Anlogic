module tx_pll( 

    input	wire		I_clk,
    
    output	wire		O_rst,
    output	wire		O_clk_1x,
    output	wire		O_clk_3p5x
);

    
    wire		S_pll_lock;
    reg [3:0]	S_cnt_rst = 4'd0;
    wire		S_pll_rst;
    
    
    always@(posedge I_clk)begin
		if(S_cnt_rst == 4'd15)
			S_cnt_rst <= S_cnt_rst;
		else
			S_cnt_rst <= S_cnt_rst + 1'b1;
	end
    
    
	assign S_pll_rst = (S_cnt_rst < 4'd10) ? 1'b1:1'b0;
    
    
	TX_PLL u_tpll(
  		.refclk			(	I_clk		),
  		.clk0_out		(	O_clk_1x	),
        //.clk2_out		(	O_clk_1x_e	), 
  		.clk2_out		(	O_clk_3p5x	),
  		.lock			(	S_pll_lock	),
  		.reset		(	S_pll_rst	)
	);
    
    
    assign	O_rst = ~S_pll_lock;


endmodule
