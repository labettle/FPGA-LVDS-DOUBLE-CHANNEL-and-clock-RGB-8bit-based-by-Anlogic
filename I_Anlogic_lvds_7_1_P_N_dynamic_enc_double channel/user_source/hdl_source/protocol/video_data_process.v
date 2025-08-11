module video_data_process#(
    parameter PROTOCOL = "VESA" // 协议：JEIDA、VESA
)(    
    input	wire			I_rst,
    input	wire			I_clk_1x,

    input   wire        	I_align_valid0,
    input   wire	[6:0]   I_align_data0,     
    input   wire        	I_align_valid1,         
    input   wire	[6:0]   I_align_data1,          
    input   wire        	I_align_valid2,         
	input   wire	[6:0]   I_align_data2,  
    input	wire        	I_align_valid3, 
    input	wire	[6:0]   I_align_data3,   

    output  wire			O_DE,
    output  wire			O_VS,
    output  wire			O_HS,
    output  wire	    [23:0]  O_RGB
);
	
    wire [23:0] rgb_odd;
    wire [23:0] rgb_even;  
    wire			NA;
    wire	[7:0]	S_R_data;
    wire	[7:0]	S_G_data;
    wire	[7:0]	S_B_data;
    
    	// 协议处理
	generate      
		if(PROTOCOL == "VESA") 
    		begin
		    	assign	{S_G_data[0],S_R_data[5:0]} = I_align_data0;
		    	assign	{S_B_data[1:0],S_G_data[5:1]} = I_align_data1;
		    	assign	{O_DE,O_VS,O_HS,S_B_data[5:2]} = I_align_data2;
		    	assign	{NA,S_B_data[7:6],S_G_data[7:6],S_R_data[7:6]} = I_align_data3;
			end
    	else if(PROTOCOL == "JEIDA") 
    		begin
		    	assign {S_G_data[2],S_R_data[7:2]} = I_align_data0;
		    	assign {S_B_data[3:2],S_G_data[7:3]} = I_align_data1;
		    	assign {O_DE,O_VS,O_HS,S_B_data[7:4]} = I_align_data2;
		    	assign {NA,S_B_data[1:0],S_G_data[1:0],S_R_data[1:0]} = I_align_data3;
			end    
    	
	endgenerate
    
    assign	O_RGB = {S_R_data,S_G_data,S_B_data};

endmodule
