module lvds_tx_wrapper#(
    parameter PROTOCOL = "VESA" // 协议：JEIDA、VESA
)(
    
    input	wire		I_clk_1x_o,
    input	wire		I_clk_1x_e,
    input	wire		I_clk_3p5x,    
    input	wire		I_rst,
    
    input   wire[7:0]   I_R_data_o,
    input   wire[7:0]   I_G_data_o,
    input   wire[7:0]   I_B_data_o,
    
    input   wire[7:0]   I_R_data_e,
    input   wire[7:0]   I_G_data_e,
    input   wire[7:0]   I_B_data_e,
    input   wire        I_DE,
    input   wire        I_VS,
    input   wire        I_HS,
    
    output	wire		O_lvds_tx_clk_o,
    output  wire	    O_lvds_tx_d0,
    output  wire	    O_lvds_tx_d1,
    output  wire	    O_lvds_tx_d2,
    output  wire	    O_lvds_tx_d3,
    
    output	wire		O_lvds_tx_clk_e,
    output  wire	    O_lvds_tx_d4,
    output  wire	    O_lvds_tx_d5,
    output  wire	    O_lvds_tx_d6,
    output  wire	    O_lvds_tx_d7
  
);
	
    
    wire	[6:0]   S_lvds_d0;		
    wire	[6:0]   S_lvds_d1;		
    wire	[6:0]   S_lvds_d2;		
    wire	[6:0]   S_lvds_d3;
    
    wire	[6:0]   S_lvds_d4;		
    wire	[6:0]   S_lvds_d5;		
    wire	[6:0]   S_lvds_d6;		
    wire	[6:0]   S_lvds_d7;		
    
    
    
    lvds_tx_clk u_lvds_tx_clk_odd(
    	.I_clk_1x		(	I_clk_1x_o		),
    	.I_rst			(	I_rst			),
    	
    	.O_lvds_tx_clk	(	O_lvds_tx_clk_o	)
	);  
    
    lvds_tx_clk u_lvds_tx_clk_even(
    	.I_clk_1x		(	I_clk_1x_e	),
    	.I_rst			(	I_rst			),
    	
    	.O_lvds_tx_clk	(	O_lvds_tx_clk_e	)
	);  
    
    lcd_to_lvds#(
    	.PROTOCOL		(	"VESA" 			)// 协议：JEIDA、VESA
	)u_lcd_to_lvds_odd(                     	
    	.I_rst			(	I_rst			),
    	.I_clk_1x		(	I_clk_1x_o  	), 
    	                                	
    	.I_R_data		(	I_R_data_o		),
    	.I_G_data		(	I_G_data_o		),
    	.I_B_data		(	I_B_data_o		),
    	.I_DE			(	I_DE			),
    	.I_VS			(	I_VS			),
    	.I_HS			(	I_HS			),
    	
    	.O_lvds_d0		(	S_lvds_d0		),
    	.O_lvds_d1		(	S_lvds_d1		),
    	.O_lvds_d2		(	S_lvds_d2		),
    	.O_lvds_d3		(	S_lvds_d3		)
);

lcd_to_lvds#(
    	.PROTOCOL		(	"VESA" 			)// 协议：JEIDA、VESA
	)u_lcd_to_lvds_even(                     	
    	.I_rst			(	I_rst			),
    	.I_clk_1x		(	I_clk_1x_e		), 
    	                                	
    	.I_R_data		(	I_R_data_e		),
    	.I_G_data		(	I_G_data_e  	),
    	.I_B_data		(	I_B_data_e		),
    	.I_DE			(	I_DE			),
    	.I_VS			(	I_VS			),
    	.I_HS			(	I_HS			),
    	
    	.O_lvds_d0		(	S_lvds_d5		),
    	.O_lvds_d1		(	S_lvds_d6		),
    	.O_lvds_d2		(	S_lvds_d7 		),
    	.O_lvds_d3		(	S_lvds_d8		)
);
   
    
    
    lvds_tx_parrall_7_1 u0_lvds_tx_parrall_7_1(
		.I_clk_1x		(	I_clk_1x_o			),		
		.I_clk_3p5x		(	I_clk_3p5x			),	
		.I_rst			(	I_rst	  			),		
    		
		.I_data			(	S_lvds_d0			),				         		
    	
		.O_lvds_tx_p	(	O_lvds_tx_d0		)
	);
    
    
    lvds_tx_parrall_7_1 u1_lvds_tx_parrall_7_1(
		.I_clk_1x		(	I_clk_1x_o			),		
		.I_clk_3p5x		(	I_clk_3p5x			),	
		.I_rst			(	I_rst	  			),		
    		
		.I_data			(	S_lvds_d1			),				         		
    	
		.O_lvds_tx_p	(	O_lvds_tx_d1		)
	);
    
    
    
    lvds_tx_parrall_7_1 u2_lvds_tx_parrall_7_1(
		.I_clk_1x		(	I_clk_1x_o		),		
		.I_clk_3p5x		(	I_clk_3p5x			),	
		.I_rst			(	I_rst	  			),		
    		
		.I_data			(	S_lvds_d2			),				         		
    	
		.O_lvds_tx_p	(	O_lvds_tx_d2		)
	);
    
    
    
    lvds_tx_parrall_7_1 u3_lvds_tx_parrall_7_1(
		.I_clk_1x		(	I_clk_1x_o			),		
		.I_clk_3p5x		(	I_clk_3p5x			),	
		.I_rst			(	I_rst	  			),		
    		
		.I_data			(	S_lvds_d3			),				         		
    	
		.O_lvds_tx_p	(	O_lvds_tx_d3		)
	);
    
lvds_tx_parrall_7_1 u4_lvds_tx_parrall_7_1(
		.I_clk_1x		(	I_clk_1x_e			),		
		.I_clk_3p5x		(	I_clk_3p5x			),	
		.I_rst			(	I_rst	  			),		
    		
		.I_data			(	S_lvds_d4			),				         		
    	
		.O_lvds_tx_p	(	O_lvds_tx_d4		)
	);
    
lvds_tx_parrall_7_1 u5_lvds_tx_parrall_7_1(
		.I_clk_1x		(	I_clk_1x_e			),		
		.I_clk_3p5x		(	I_clk_3p5x			),	
		.I_rst			(	I_rst	  			),		
    		
		.I_data			(	S_lvds_d5			),				         		
    	
		.O_lvds_tx_p	(	O_lvds_tx_d5		)
	);
    
lvds_tx_parrall_7_1 u6_lvds_tx_parrall_7_1(
		.I_clk_1x		(	I_clk_1x_e			),		
		.I_clk_3p5x		(	I_clk_3p5x			),	
		.I_rst			(	I_rst	  			),		
    		
		.I_data			(	S_lvds_d6			),				         		
    	
		.O_lvds_tx_p	(	O_lvds_tx_d6		)
	);
    
lvds_tx_parrall_7_1 u7_lvds_tx_parrall_7_1(
		.I_clk_1x		(	I_clk_1x_e			),		
		.I_clk_3p5x		(	I_clk_3p5x			),	
		.I_rst			(	I_rst	  			),		
    		
		.I_data			(	S_lvds_d7			),				         		
    	
		.O_lvds_tx_p	(	O_lvds_tx_d7		)
	);

endmodule
