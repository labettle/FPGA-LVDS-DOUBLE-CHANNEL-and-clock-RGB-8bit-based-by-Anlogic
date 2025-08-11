module lvds_tx_parrall_7_1( 
	input	wire		I_clk_1x,		
	input	wire		I_clk_3p5x,	
	input	wire		I_rst,		
           	
	input	wire[6:0]	I_data,				         		
           
	output	wire		O_lvds_tx_p
);



	PH1P_LOGIC_HR_OSERDES #(
	  .ODDRMODE     ( "DDRX3P5"    )/*, //  DDRX1, DDRX2, DDRX3P5, DDRX4, DDRX5.  IDDR mode select.  
	  .DEVICE       ( "PH1P35"  )  //  "PH1P100", "PH1X100", "PH1P35", "PH1S35", "PH1P50".  Device selection.*/  
	)u_PH1P_LOGIC_HR_OSERDES(
	  .sclk         ( I_clk_3p5x    ), //  1-Bit input.                                
	  .pclk         ( I_clk_1x      ), //  1-Bit input.                                
	  .rst          ( I_rst        	), //  1-Bit input.                                
	  .idata        ( I_data      	), //  8-Bit input.                                
	  .odata        ( O_lvds_tx_p   )  //  1-Bit output.                                
	);
      
      
       
      
      
endmodule

