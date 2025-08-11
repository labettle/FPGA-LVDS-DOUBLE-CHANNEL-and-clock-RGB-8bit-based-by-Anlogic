module error_dect(
    input	wire		I_clk,
    input	wire		I_rst,
    
    input	wire		I_lane_dpa_done	/*synthesis keep = 1*/,
    input	wire[6:0]	I_diff_pdata	/*synthesis keep = 1*/,	
    input	wire[6:0]	I_diff_ndata	 /*synthesis keep = 1*/ ,  
    
    output	wire		O_error_flag  	/*synthesis keep = 1*/ 
);
    
    
    assign	O_error_flag = ((I_lane_dpa_done) & (I_diff_pdata != I_diff_ndata)) ? 1'b1:1'b0;
    
    

endmodule

