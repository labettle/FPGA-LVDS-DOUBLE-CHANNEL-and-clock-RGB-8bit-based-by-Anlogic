module lcd_to_lvds#(
    parameter PROTOCOL = "VESA" // 协议：JEIDA、VESA
)(    
    input                     I_rst,
    input                     I_clk_1x,

    input           [7:0]     I_R_data,
    input           [7:0]     I_G_data,
    input           [7:0]     I_B_data,
    input                     I_DE,
    input                     I_VS,
    input                     I_HS,

    output    reg	 [6:0]    O_lvds_d0,
    output    reg	 [6:0]    O_lvds_d1,
    output    reg	 [6:0]    O_lvds_d2,
    output    reg	 [6:0]    O_lvds_d3
);

  
    localparam NA = 0;    

    	// 协议处理
	generate    
    
		always @(posedge I_clk_1x or posedge I_rst) begin
		    if (I_rst) 
            	begin
		        	O_lvds_d0 <= 'b0;
		        	O_lvds_d1 <= 'b0;
		        	O_lvds_d2 <= 'b0;
		        	O_lvds_d3 <= 'b0;
		    	end 
            else if(PROTOCOL == "VESA") 
            	begin
		        	O_lvds_d0 <= {I_G_data[0],I_R_data[5:0]};
		        	O_lvds_d1 <= {I_B_data[1],I_B_data[0],I_G_data[5],I_G_data[4],I_G_data[3],I_G_data[2],I_G_data[1]};
		        	O_lvds_d2 <= {I_DE,I_VS,I_HS,I_B_data[5],I_B_data[4],I_B_data[3],I_B_data[2]};
		        	O_lvds_d3 <= {NA,I_B_data[7],I_B_data[6],I_G_data[7],I_G_data[6],I_R_data[7],I_R_data[6]};
		    	end
            else if(PROTOCOL == "JEIDA") 
            	begin
		        	O_lvds_d0 <= {I_G_data[2],I_R_data[7:2]};
		        	O_lvds_d1 <= {I_B_data[3:2],I_G_data[7:3]};
		        	O_lvds_d2 <= {I_DE,I_VS,I_HS,I_B_data[7:4]};
		        	O_lvds_d3 <= {NA,I_B_data[1:0],I_G_data[1:0],I_R_data[1:0]};
		    	end    
               
		end
    
	endgenerate    


endmodule
