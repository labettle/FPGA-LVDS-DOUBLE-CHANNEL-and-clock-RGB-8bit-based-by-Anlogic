module rgb_error_dect(
    input	wire		I_clk,
    input	wire		I_rst,
    
    input	wire[23:0]	I_RGB_data	/*synthesis keep = 1*/,	
    
    output	wire		O_RGB_true_flag  	/*synthesis keep = 1*/ 
);
	
    reg	[7:0]	S_r_data;	//synthesis keep
    reg	[7:0]	S_g_data;		//synthesis keep
    reg	[7:0]	S_b_data;		//synthesis keep
    
    
    always @(posedge I_clk or posedge I_rst) begin
        if (I_rst) begin
            {S_r_data} <= 32'd0;
            {S_g_data} <= 32'd0;
            {S_b_data} <= 32'd0;
        end else begin
            S_r_data <= I_RGB_data[23:16]; 
            S_g_data <= I_RGB_data[15:8];  
            S_b_data <= I_RGB_data[7:0];   
        end    
     end
    
   // 双路并行灰度校验（R=G=B时为灰度）
    wire grayscale  = (S_r_data == S_g_data) && (S_r_data == S_b_data);
    // 输出标志：仅当双路均为灰度时有效
    assign O_RGB_true_flag = grayscale;

endmodule
