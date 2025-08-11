module lvds_lane(

    input	wire		I_clk_1x,
    input	wire		I_clk_3p5x,    
    input	wire		I_rst,
    
    input	wire		I_dpa_start,    
    
    input	wire		I_lvds_rx_p,
	input	wire		I_lvds_rx_n,
    
    output	wire		O_align_valid,
    output	wire[6:0]	O_align_data,
    
    output	wire		O_lane_dpa_done
);
	
	wire	[6:0]	S_diff_pdata;				
    wire    [6:0]	S_diff_ndata; 				
    wire			S_lane_match;				
    
    wire			S_idelay_ld;	    
    wire            S_idelay_ce;	
    wire            S_idelay_inc;
    
    wire			S_lane_dpa_done;			
    
    wire	[7:0]	S_idelay_num;  				
    
    wire	[6:0]	S_phase_align_pdata; 		
    wire	[6:0]	S_phase_align_ndata;
    wire	[7:0]	S_eye_taps;		
    
    
    assign O_lane_dpa_done = S_lane_dpa_done;             
                    
                    
	lvds_rx_parrall_1_7 u_lvds_rx_parrall_1_7(
    
    	.I_clk_1x				(	I_clk_1x			),
    	.I_clk_3p5x				(	I_clk_3p5x			),    
    	.I_rst					(	I_rst				),
    		
    	.I_din_lvds_rx_p		(	I_lvds_rx_p			),
		.I_din_lvds_rx_n		(	I_lvds_rx_n			),
        
        .I_idelay_num			(	S_idelay_num		),	
    	
    	.O_diff_pdata			(	S_diff_pdata		),
		.O_diff_ndata	        (	S_diff_ndata		)
);

	
    p_n_data_comparison u_p_n_data_comparison( 
    	.I_clk					(	I_clk_1x			),
    	.I_rst					(	I_rst				),
    	                		                    	
    	.I_diff_pdata			(	S_diff_pdata		),
    	.I_diff_ndata			(	S_diff_ndata		),
        
        .O_phase_align_pdata	(	S_phase_align_pdata	),
		.O_phase_align_ndata	(	S_phase_align_ndata	),
    	 
    	.O_lane_match			(	S_lane_match		)
    );
    

	idelay_ctrl u_idelay_ctrl(
    	.I_clk				(	I_clk_1x		),
    	.I_rst				(	I_rst			),
    	
    	.I_dpa_start		(	I_dpa_start		),
    	.I_lane_match		(	S_lane_match	),
    	.O_lane_dpa_done	(	S_lane_dpa_done	),

        .O_idelay_num		(	S_idelay_num	),
        .O_eye_taps			(	S_eye_taps		)   //idelay_taps;  time ≈ idelay_taps * 7ps
	);
    
    
    lvds_rx_byte_align_1 u_lvds_rx_byte_align(   
    	.I_clk				(	I_clk_1x			),
    	.I_rst				(	I_rst				),
    	
        .I_idelay_done		(	S_lane_dpa_done		),
    	.I_deserial_data	(	S_phase_align_pdata	),
    	
    	.O_align_valid		(	O_align_valid		),
    	.O_align_data		(	O_align_data		)
	);
    
    
    error_dect u_error_dect(
    	.I_clk			(	S_rx_clk_1x			),
    	.I_rst			(	I_rst				),
    	
    	.I_lane_dpa_done(	S_lane_dpa_done		),
        
    	.I_diff_pdata	(	S_phase_align_pdata	),
    	.I_diff_ndata	(	S_phase_align_ndata	),    
    	
    	.O_error_flag 	(	S_error_flag		) 
	); 
    
    
    

endmodule
