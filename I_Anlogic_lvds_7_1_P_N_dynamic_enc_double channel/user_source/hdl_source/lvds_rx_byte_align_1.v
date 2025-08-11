module lvds_rx_byte_align_1(
    input	wire		I_clk,
    input	wire		I_rst,
    
    input	wire		I_idelay_done		/*synthesis keep = 1*/,
    input	wire[6:0]	I_deserial_data		/*synthesis keep = 1*/,
    
    output	reg			O_align_valid		/*synthesis keep = 1*/,
    output	reg [6:0]	O_align_data		/*synthesis keep = 1*/
);
	
    wire      S_sync_en;      
    reg[3:0]  S_position;    //synthesis keep = 1
    reg[13:0] S_shift_data; 
    reg[13:0] S_shift_data_1d;
    reg[13:0] S_shift_data_2d;
    reg[13:0] S_shift_data_3d;
    reg[4:0]  S_sync_en_cnt;     
    wire      S_position_lock_en; //synthesis keep = 1
    reg[3:0]  S_position_lock;   //synthesis keep = 1 
    reg		  S_position_lock_en_1d;



    always @(posedge I_clk) begin
    	if(I_idelay_done)
        	S_shift_data <= {I_deserial_data,S_shift_data[13:7]};
        else
        	S_shift_data <= 'd0;
    end


//    always @(posedge I_clk) begin
//        S_position = S_shift_data[19:10] == SYNC_WORD ? 'd1  :
//                     S_shift_data[18:9]  == SYNC_WORD ? 'd2  :
//                     S_shift_data[17:8]  == SYNC_WORD ? 'd3  :
//                     S_shift_data[16:7]  == SYNC_WORD ? 'd4  :
//                     S_shift_data[15:6]  == SYNC_WORD ? 'd5  :
//                     S_shift_data[14:5]  == SYNC_WORD ? 'd6  :
//                     S_shift_data[13:4]  == SYNC_WORD ? 'd7  :
//                     S_shift_data[12:3]  == SYNC_WORD ? 'd8  :
//                     S_shift_data[11:2]  == SYNC_WORD ? 'd9  :
//                     S_shift_data[10:1]  == SYNC_WORD ? 'd10 : 'd0;
//    end

    always @(posedge I_clk) begin
        S_position = S_shift_data[13:7] == 7'b0110_1010 || S_shift_data[13:7] == 7'b0000_0111 || S_shift_data[13:7] == 7'b0111_1100 || S_shift_data[13:7] == 7'b0011_0010 ? 'd1  :
                     S_shift_data[12:6] == 7'b0110_1010 || S_shift_data[12:6] == 7'b0000_0111 || S_shift_data[12:6] == 7'b0111_1100 || S_shift_data[12:6] == 7'b0011_0010 ? 'd2  :
                     S_shift_data[11:5] == 7'b0110_1010 || S_shift_data[11:5] == 7'b0000_0111 || S_shift_data[11:5] == 7'b0111_1100 || S_shift_data[11:5] == 7'b0011_0010 ? 'd3  :
                     S_shift_data[10:4] == 7'b0110_1010 || S_shift_data[10:4] == 7'b0000_0111 || S_shift_data[10:4] == 7'b0111_1100 || S_shift_data[10:4] == 7'b0011_0010 ? 'd4  :
                     S_shift_data[9:3]  == 7'b0110_1010 || S_shift_data[9:3]  == 7'b0000_0111 || S_shift_data[9:3]  == 7'b0111_1100 || S_shift_data[9:3]  == 7'b0011_0010 ? 'd5  :
                     S_shift_data[8:2]  == 7'b0110_1010 || S_shift_data[8:2]  == 7'b0000_0111 || S_shift_data[8:2]  == 7'b0111_1100 || S_shift_data[8:2]  == 7'b0011_0010 ? 'd6  :
                     S_shift_data[7:1]  == 7'b0110_1010 || S_shift_data[7:1]  == 7'b0000_0111 || S_shift_data[7:1]  == 7'b0111_1100 || S_shift_data[7:1]  == 7'b0011_0010 ? 'd7  :
                     S_shift_data[6:0]  == 7'b0110_1010 || S_shift_data[6:0]  == 7'b0000_0111 || S_shift_data[6:0]  == 7'b0111_1100 || S_shift_data[6:0]  == 7'b0011_0010 ? 'd8  :'d0;
    end    


    assign S_sync_en = S_position != 0 ? 1'b1 : 1'b0;
    
    always @(posedge I_clk)begin
        	S_shift_data_1d <= S_shift_data;
            S_shift_data_2d <= S_shift_data_1d;
            S_shift_data_3d <= S_shift_data_2d;
    end


    always @(posedge I_clk) begin
        if(S_sync_en)
            S_sync_en_cnt <= S_sync_en_cnt + 'd1;
        else
            S_sync_en_cnt <= 'd0;
    end

    assign S_position_lock_en = S_sync_en && S_sync_en_cnt == 'd10 ? 1'b1 : 1'b0;
    
    
    always@(posedge I_clk)begin
    	S_position_lock_en_1d <= S_position_lock_en;
    end
    

    always @(posedge I_clk or posedge I_rst) begin
        if(I_rst)
            S_position_lock <= 'd0;
        else
            if(S_position_lock_en)
                S_position_lock <= S_position;
            else
                S_position_lock <= S_position_lock;
    end


    always @(posedge I_clk) begin
        O_align_data <=   S_position_lock == 'd1  ? S_shift_data_2d[13:7] : 
                          S_position_lock == 'd2  ? S_shift_data_2d[12:6] :
                          S_position_lock == 'd3  ? S_shift_data_2d[11:5] :
                          S_position_lock == 'd4  ? S_shift_data_2d[10:4] :
                          S_position_lock == 'd5  ? S_shift_data_2d[9:3]  :
                          S_position_lock == 'd6  ? S_shift_data_2d[8:2]  :
                          S_position_lock == 'd7  ? S_shift_data_2d[7:1]  :
                          S_position_lock == 'd8  ? S_shift_data_2d[6:0]  : 'd0;
    end
    
    
    always@(posedge I_clk or posedge I_rst)begin
    	if(I_rst)
        	O_align_valid <= 'd0;
        else if(S_position_lock_en_1d)
        	O_align_valid <= 1'b1;
        else
        	O_align_valid <= O_align_valid;
    end



endmodule
