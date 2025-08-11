module lvds_rx_wrapper#(
    parameter PROTOCOL = "VESA" // 协议：JEIDA、VESA
)(
    input	wire		I_clk_1x_o,
    input	wire		I_clk_3p5x_o,
    input	wire		I_clk_1x_e,
    input	wire		I_clk_3p5x_e,    
    input	wire		I_rst, 
    
    input	wire		I_lvds_rxo_d0_p,
	input	wire		I_lvds_rxo_d0_n,
	input	wire		I_lvds_rxo_d1_p,
	input	wire		I_lvds_rxo_d1_n,
	input	wire		I_lvds_rxo_d2_p,
	input	wire		I_lvds_rxo_d2_n,
	input	wire		I_lvds_rxo_d3_p,
	input	wire		I_lvds_rxo_d3_n,
    
    input	wire		I_lvds_rxe_d0_p,
	input	wire		I_lvds_rxe_d0_n,
	input	wire		I_lvds_rxe_d1_p,
	input	wire		I_lvds_rxe_d1_n,
	input	wire		I_lvds_rxe_d2_p,
	input	wire		I_lvds_rxe_d2_n,
	input	wire		I_lvds_rxe_d3_p,
	input	wire		I_lvds_rxe_d3_n,       
     






    output  wire[23:0]  O_RGB_o,
    output  wire[23:0]  O_RGB_e
);
    wire		O_DE_o;
    wire		O_VS_o;
    wire		O_HS_o;
    wire		O_DE_e;
    wire		O_VS_e;
    wire		O_HS_e;
	wire O_lane0_dpa_done;
    wire O_lane1_dpa_done;
    wire O_lane2_dpa_done;
    wire O_lane3_dpa_done;
    wire O_lane4_dpa_done;
    wire O_lane5_dpa_done;
    wire O_lane6_dpa_done;
    wire O_lane7_dpa_done;
    
	wire		S_align_valid0;		
    wire[6:0]	S_align_data0;		
	wire		S_align_valid1;
    wire[6:0]	S_align_data1;
    wire		S_align_valid2;
    wire[6:0]	S_align_data2;    	           
	wire		S_align_valid3;
    wire[6:0]	S_align_data3; 
    
    wire		S_align_valid4;		
    wire[6:0]	S_align_data4;		
	wire		S_align_valid5;
    wire[6:0]	S_align_data5;
    wire		S_align_valid6;
    wire[6:0]	S_align_data6;    	           
	wire		S_align_valid7;
    wire[6:0]	S_align_data7; 
    
    wire		S_RGB_true_flag_0;
    wire		S_RGB_true_flag_e;		//synthesis keep	
    reg	[21:0]	S_gen_num_o;
    reg	[21:0]	S_gen_num_e;
    reg			S_dpa_start_o;
    reg			S_dpa_start_e;
    
    
    always@(posedge I_clk_1x_o or posedge I_rst)begin
    	if(I_rst)
        	S_gen_num_o <= 'd0;
        else if(S_gen_num_o == 30'd2000_000)
        	S_gen_num_o <= S_gen_num_o;
        else
        	S_gen_num_o <= S_gen_num_o + 1'b1;	
    end
    
    
    always@(posedge I_clk_1x_o or posedge I_rst)begin
    	if(I_rst)
        	S_dpa_start_o <= 'd0;
        else if(S_gen_num_o == 30'd2000_000)
        	S_dpa_start_o <= 1'b1;
        else
        	S_dpa_start_o <= S_dpa_start_o;	
    end
                       
   always@(posedge I_clk_1x_e or posedge I_rst)begin
    	if(I_rst)
        	S_gen_num_e <= 'd0;
        else if(S_gen_num_e == 30'd2000_000)
        	S_gen_num_e <= S_gen_num_e;
        else
        	S_gen_num_e <= S_gen_num_e + 1'b1;	
    end
    
    
    always@(posedge I_clk_1x_e or posedge I_rst)begin
    	if(I_rst)
        	S_dpa_start_e <= 'd0;
        else if(S_gen_num_e == 30'd2000_000)
        	S_dpa_start_e <= 1'b1;
        else
        	S_dpa_start_e <= S_dpa_start_e;	
    end
                    
	lvds_lane u0_lvds_lane(
		.I_clk_1x				(	I_clk_1x_o				),
		.I_clk_3p5x				(	I_clk_3p5x_o				),    
		.I_rst					(	I_rst					),
		                		                			
		.I_dpa_start			(	S_dpa_start_o				),    
		                		                    		
		.I_lvds_rx_p			(	I_lvds_rxo_d0_p			),
		.I_lvds_rx_n			(	I_lvds_rxo_d0_n			),
		                	                    	
		.O_align_valid			(	S_align_valid0			),
		.O_align_data			(	S_align_data0			),
		
		.O_lane_dpa_done		(	O_lane0_dpa_done		)
	);
    
    
	lvds_lane u1_lvds_lane(
		.I_clk_1x				(	I_clk_1x_o				),
		.I_clk_3p5x				(	I_clk_3p5x_o			),    
		.I_rst					(	I_rst					),
		                		                			
		.I_dpa_start			(	S_dpa_start_o				),    
		                		                    		
		.I_lvds_rx_p			(	I_lvds_rxo_d1_p			),
		.I_lvds_rx_n			(	I_lvds_rxo_d1_n			),
		                	                    	
		.O_align_valid			(	S_align_valid1			),
		.O_align_data			(	S_align_data1			),
		
		.O_lane_dpa_done		(	O_lane1_dpa_done		)
	);
    
    
	lvds_lane u2_lvds_lane(
		.I_clk_1x				(	I_clk_1x_o				),
		.I_clk_3p5x				(	I_clk_3p5x_o			),    
		.I_rst					(	I_rst					),
		                		                			
		.I_dpa_start			(	S_dpa_start_o				),    
		                		                    		
		.I_lvds_rx_p			(	I_lvds_rxo_d2_p			),
		.I_lvds_rx_n			(	I_lvds_rxo_d2_n			),
		                	                    	
		.O_align_valid			(	S_align_valid2			),
		.O_align_data			(	S_align_data2			),
		
		.O_lane_dpa_done		(	O_lane2_dpa_done		)
	);
    
    
    
	lvds_lane u3_lvds_lane(
		.I_clk_1x				(	I_clk_1x_o				),
		.I_clk_3p5x				(	I_clk_3p5x_o			),    
		.I_rst					(	I_rst					),
		                		                			
		.I_dpa_start			(	S_dpa_start_o				),    
		                		                    		
		.I_lvds_rx_p			(	I_lvds_rxo_d3_p			),
		.I_lvds_rx_n			(	I_lvds_rxo_d3_n			),
		                	                    	
		.O_align_valid			(	S_align_valid3			),
		.O_align_data			(	S_align_data3			),
		
		.O_lane_dpa_done		(	O_lane3_dpa_done		)
	);
    
    lvds_lane u4_lvds_lane(
		.I_clk_1x				(	I_clk_1x_e				),
		.I_clk_3p5x				(	I_clk_3p5x_e			),    
		.I_rst					(	I_rst					),
		                		                			
		.I_dpa_start			(	S_dpa_start_e				),    
		                		                    		
		.I_lvds_rx_p			(	I_lvds_rxe_d0_p			),
		.I_lvds_rx_n			(	I_lvds_rxe_d0_n			),
		                	                    	
		.O_align_valid			(	S_align_valid4			),
		.O_align_data			(	S_align_data4			),
		
		.O_lane_dpa_done		(	O_lane4_dpa_done		)
	);
    
    lvds_lane u5_lvds_lane(
		.I_clk_1x				(	I_clk_1x_e				),
		.I_clk_3p5x				(	I_clk_3p5x_e			),    
		.I_rst					(	I_rst					),
		                		                			
		.I_dpa_start			(	S_dpa_start_e				),    
		                		                    		
		.I_lvds_rx_p			(	I_lvds_rxe_d1_p			),
		.I_lvds_rx_n			(	I_lvds_rxe_d1_n			),
		                	                    	
		.O_align_valid			(	S_align_valid5			),
		.O_align_data			(	S_align_data5			),
		
		.O_lane_dpa_done		(	O_lane5_dpa_done		)
	);
    
    lvds_lane u6_lvds_lane(
		.I_clk_1x				(	I_clk_1x_e				),
		.I_clk_3p5x				(	I_clk_3p5x_e			),    
		.I_rst					(	I_rst					),
		                		                			
		.I_dpa_start			(	S_dpa_start_e				),    
		                		                    		
		.I_lvds_rx_p			(	I_lvds_rxe_d2_p			),
		.I_lvds_rx_n			(	I_lvds_rxe_d2_n			),
		                	                    	
		.O_align_valid			(	S_align_valid6			),
		.O_align_data			(	S_align_data6			),
		
		.O_lane_dpa_done		(	O_lane6_dpa_done		)
	);
    
    lvds_lane u7_lvds_lane(
		.I_clk_1x				(	I_clk_1x_e				),
		.I_clk_3p5x				(	I_clk_3p5x_e			),    
		.I_rst					(	I_rst					),
		                		                			
		.I_dpa_start			(	S_dpa_start_e   		),    
		                		                    		
		.I_lvds_rx_p			(	I_lvds_rxe_d3_p			),
		.I_lvds_rx_n			(	I_lvds_rxe_d3_n			),
		                	                    	
		.O_align_valid			(	S_align_valid7			),
		.O_align_data			(	S_align_data7			),
		
		.O_lane_dpa_done		(	O_lane7_dpa_done		)
	);
    
	video_data_process#(
	    .PROTOCOL 			(	"VESA"			)
	)u_video_data_process_o(                                      	
	    .I_rst				(	I_rst			),
	    .I_clk_1x			(	I_clk_1x_o		),
	    .I_align_valid0		(	S_align_valid0	),
	    .I_align_data0		(	S_align_data0	),     
	    .I_align_valid1		(	S_align_valid1	),         
	    .I_align_data1		(	S_align_data1	),          
	    .I_align_valid2		(	S_align_valid2	),         
		.I_align_data2		(	S_align_data2	),  
	    .I_align_valid3		(	S_align_valid3	), 
	    .I_align_data3		(	S_align_data3	),            
	    .O_DE				(	O_DE_o			),
	    .O_VS				(	O_VS_o			),
	    .O_HS				(	O_HS_o			),
	    .O_RGB              (	O_RGB_o			)
	);
    
    video_data_process#(
	    .PROTOCOL 			(	"VESA"			)
	)u_video_data_process_e(                                      	
	    .I_rst				(	I_rst			),
	    .I_clk_1x			(	I_clk_1x_e		),   
        .I_align_valid0     (	S_align_valid4	),
	    .I_align_data0		(	S_align_data4	),     
	    .I_align_valid1		(	S_align_valid5	),         
	    .I_align_data1		(	S_align_data5	),          
	    .I_align_valid2		(	S_align_valid6	),         
		.I_align_data2		(	S_align_data6	),  
	    .I_align_valid3		(	S_align_valid7	), 
	    .I_align_data3		(	S_align_data7	),    
        
	    .O_DE				(	O_DE_e			),
	    .O_VS				(	O_VS_e			),
	    .O_HS				(	O_HS_e			),
	    .O_RGB              (	O_RGB_e			)
	);
    
    
    
    rgb_error_dect u_rgb_error_dect_o(
    	.I_clk					(	I_clk_1x_o			),
    	.I_rst					(	I_rst				),
    	                                        		
    	.I_RGB_data				(	O_RGB_o				),	
    	
    	.O_RGB_true_flag  		(	S_RGB_true_flag_o		) 
	);
    
    rgb_error_dect u_rgb_error_dect_e(
    	.I_clk					(	I_clk_1x_e			),
    	.I_rst					(	I_rst				),
    	                                        		
    	.I_RGB_data				(	O_RGB_e				),	
    	
    	.O_RGB_true_flag  		(	S_RGB_true_flag_e		) 
	);
    
    
    
    
endmodule    