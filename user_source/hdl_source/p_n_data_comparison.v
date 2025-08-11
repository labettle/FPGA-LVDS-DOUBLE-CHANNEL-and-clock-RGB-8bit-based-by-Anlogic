module p_n_data_comparison( 
	input 	wire    I_clk,
    input 	wire    I_rst,
    
    input	wire	[6:0]	I_diff_pdata,
    input	wire	[6:0]	I_diff_ndata,
    
    output	reg		[6:0]	O_phase_align_pdata,
    output	reg		[6:0]	O_phase_align_ndata,
    
    output	reg				O_lane_match
);
	
    
    reg	[6:0]	S_positive_pdata;
    reg	[6:0]	S_rever_ndata;
    
    
    always@(posedge I_clk)begin
    	S_positive_pdata <= I_diff_pdata;
    	S_rever_ndata <= (~I_diff_ndata);
    end
    
    
    always@(posedge I_clk)begin
    	O_phase_align_pdata <= S_positive_pdata;
    	O_phase_align_ndata <= S_rever_ndata;
    end
    
    
	always@(posedge I_clk or posedge I_rst)begin
    	if(I_rst)
        	O_lane_match <= 'd0;
        else if(S_positive_pdata == S_rever_ndata)
        	O_lane_match <= 'd1;
        else
        	O_lane_match <= 'd0;   
    end
	


endmodule
