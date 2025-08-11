module lvds_rx_parrall_1_7(
    
    input	wire		I_clk_1x,
    input	wire		I_clk_3p5x,    
    input	wire		I_rst,
 
 	input	wire[7:0]	I_idelay_num,
    
    input	wire		I_din_lvds_rx_p,
    input	wire		I_din_lvds_rx_n,
    
    output	reg[6:0]	O_diff_pdata,
    output	reg[6:0]	O_diff_ndata
);
	
    wire		S_diff_p;
    wire		S_diff_n;
    wire		S_rever_diff_n;
    
    wire		S_diff_delay_p;
    wire		S_diff_delay_n;
    
    wire [6:0]	S_diff_pdata;
    wire [6:0]	S_diff_ndata;
    
    reg	 [7:0]	S_p_idelay_num;
	reg	 [7:0]	S_n_idelay_num;
    
    
    assign	S_rever_diff_n = ~S_diff_n;


	always@(posedge I_clk_1x or posedge I_rst)begin
    	if(I_rst)
        	S_p_idelay_num  <= 'd0;
        else
        	S_p_idelay_num  <= I_idelay_num;
    end    
  
  
	always@(posedge I_clk_1x or posedge I_rst)begin
    	if(I_rst)
        	S_n_idelay_num  <= 'd0;
        else
        	S_n_idelay_num  <= I_idelay_num + 8'd2;
    end     		
    

	PH1P_LOGIC_IBUF_DIFF #(
  		.DIFF_TERM    		( "FALSE"    )  //  "FALSE", "TRUE".            
	)u_PH1P_LOGIC_IBUF_DIFF(
  		.i_p          		( I_din_lvds_rx_p       ), //  1-Bit input.                                
  		.i_n          		( I_din_lvds_rx_n       ), //  1-Bit input.                                
  		.interm_disable 	( 1'b0			 		), //  1-Bit input.                                
  		.o            		(           			), //  1-Bit output.                                
  		.o_p          		( S_diff_p        		), //  1-Bit output.                                
  		.o_n          		( S_diff_n        		)  //  1-Bit output.                                
	);
    
    
    PH1P_LOGIC_DYNAMIC_HR_IDELAY #(
  		.CAS_MODE     ( "NONE"     ), //  NONE, MASTER,MIDDLE, END.    
  		.DEVICE       ( "PH1P35"   )  //  "PH1P100", "PH1X100", "PH1P35", "PH1S35", "PH1P50".  Device selection.  
	)u_PH1P_LOGIC_DYNAMIC_HR_IDELAY_1(
  		.i            ( S_diff_p            ), //  1-Bit input. Idelay Input.                  
  		.dly          ( S_p_idelay_num	    ), //  8-Bit input. Idelay Code.                   
  		.cas_rtn_i    ( 			   		), //  1-Bit input. Cascade delay from pre DELAY.  
  		.o            ( S_diff_delay_p   	), //  1-Bit output. Idelay Output.                 
  		.cas_i        ( 		       		), //  1-Bit input. Idelay Cascade Input.          
  		.cas_o        ( 		       		)  //  1-Bit output. Idelay Cascade Output.         
	);
    
    
    PH1P_LOGIC_DYNAMIC_HR_IDELAY #(
  		.CAS_MODE     ( "NONE"     ), //  NONE, MASTER,MIDDLE, END.    
  		.DEVICE       ( "PH1P35"   )  //  "PH1P100", "PH1X100", "PH1P35", "PH1S35", "PH1P50".  Device selection.  
	)u_PH1P_LOGIC_DYNAMIC_HR_IDELAY_2(
  		.i            ( S_diff_n       ), //  1-Bit input. Idelay Input.                  
  		.dly          ( S_n_idelay_num	), //  8-Bit input. Idelay Code.                   
  		.cas_rtn_i    ( 			   	), //  1-Bit input. Cascade delay from pre DELAY.  
  		.o            ( S_diff_delay_n  ), //  1-Bit output. Idelay Output.                 
  		.cas_i        ( 		       	), //  1-Bit input. Idelay Cascade Input.          
  		.cas_o        ( 		       	)  //  1-Bit output. Idelay Cascade Output.         
	);
    
    

	PH1P_LOGIC_HR_ISERDES #(
  		.IDDRMODE     ( "DDRX3P5"    )/*, //  "DDRX1", "DDRX1_PIPE", "DDRX2", "DDRX3P5", "DDRX4", "DDRX5".  IDDR mode select.  
  		.DEVICE       ( "PH1P35"   )  //  "PH1P100", "PH1X100", "PH1P35", "PH1S35", "PH1P50".  Device selection.*/  
	)u_PH1P_LOGIC_HR_ISERDES(
  		.sclk         ( I_clk_3p5x       ), //  1-Bit input. Clock input of sclk.           
  		.pclk         ( I_clk_1x		 ), //  1-Bit input. Clock input of pclk.           
  		.rst          ( I_rst        	 ), //  1-Bit input. Reset signal,high active.      
  		.idata        ( S_diff_delay_p   ), //  1-Bit input. Serial data input.             
  		.odata        ( S_diff_pdata   	 )  //  10-Bit output. Parallel data output.          
	);
	
    
    PH1P_LOGIC_HR_ISERDES #(
  		.IDDRMODE     ( "DDRX3P5"    )/*, //  "DDRX1", "DDRX1_PIPE", "DDRX2", "DDRX3P5", "DDRX4", "DDRX5".  IDDR mode select.  
  		.DEVICE       ( "PH1P35"   )  //  "PH1P100", "PH1X100", "PH1P35", "PH1S35", "PH1P50".  Device selection. */ 
	)u_PH1P_LOGIC_HR_ISERDES_2(
  		.sclk         ( I_clk_3p5x      ), //  1-Bit input. Clock input of sclk.           
  		.pclk         ( I_clk_1x	    ), //  1-Bit input. Clock input of pclk.           
  		.rst          ( I_rst        	), //  1-Bit input. Reset signal,high active.      
  		.idata        ( S_diff_delay_n  ), //  1-Bit input. Serial data input.             
  		.odata        ( S_diff_ndata	)  //  10-Bit output. Parallel data output.          
	);
	
    
    always@(posedge I_clk_1x)begin
    	O_diff_pdata <= S_diff_pdata;
        O_diff_ndata <= S_diff_ndata;
    end
    

endmodule

