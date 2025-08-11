module user_data_gen(
    input	wire		I_clk,
    input	wire		I_rst,
    
    input	wire		I_user_valid,
    input	wire[7:0]	I_user_data,
    
    output	wire		O_valid,
    output	wire[7:0]	O_data
);

	wire		S_align_data_valid;
    wire[7:0]	S_align_data_data;
	
    align_data_gen u_align_data_gen( 
    	.I_clk					(	I_clk				),
    	.I_rst					(	I_rst				),
    	
    	.O_align_data_valid		(	S_align_data_valid	),
    	.O_align_data_data		(	S_align_data_data	)
	);
    
    
	assign	O_valid = /*I_user_valid |*/ S_align_data_valid;
    assign	O_data  = /*I_user_data  |*/ S_align_data_data;
    

endmodule
