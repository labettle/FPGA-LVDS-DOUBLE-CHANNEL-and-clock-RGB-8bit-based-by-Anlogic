module design_top_wrapper(
    input  wire        I_clk,          // 主时钟输入
    
    // 奇路LVDS输出 (通道0-3)
    output wire        O_lvds_tx_clk_o, // 奇路差分时钟
    output wire        O_lvds_tx_d0,   // 奇路通道0
    output wire        O_lvds_tx_d1,   // 奇路通道1
    output wire        O_lvds_tx_d2,   // 奇路通道2
    output wire        O_lvds_tx_d3,   // 奇路通道3
    
    // 偶路LVDS输出 (通道4-7)
    output wire        O_lvds_tx_clk_e, // 偶路差分时钟
    output wire        O_lvds_tx_d4,   // 偶路通道4 
    output wire        O_lvds_tx_d5,   // 偶路通道5 
    output wire        O_lvds_tx_d6,   // 偶路通道6 
    output wire        O_lvds_tx_d7,   // 偶路通道7 
    
    // 奇路LVDS输入
    input  wire        I_lvds_rx_clk_o, // 奇路接收时钟
    input  wire        I_lvds_rxo_d0_p,  //奇路通道0差分
    input  wire        I_lvds_rxo_d0_n,
    input  wire        I_lvds_rxo_d1_p,  //奇路通道1差分
    input  wire        I_lvds_rxo_d1_n,
    input  wire        I_lvds_rxo_d2_p,  //奇路通道2差分
    input  wire        I_lvds_rxo_d2_n,
    input  wire        I_lvds_rxo_d3_p,  //奇路通道3差分
    input  wire        I_lvds_rxo_d3_n,
    
    // 偶路LVDS输入
    input  wire        I_lvds_rx_clk_e, // 偶路接收时钟
    input  wire        I_lvds_rxe_d0_p,  //偶路通道4差分 
    input  wire        I_lvds_rxe_d0_n,
    input  wire        I_lvds_rxe_d1_p,  //偶路通道5差分
    input  wire        I_lvds_rxe_d1_n,
    input  wire        I_lvds_rxe_d2_p,  //偶路通道6差分
    input  wire        I_lvds_rxe_d2_n,
    input  wire        I_lvds_rxe_d3_p,  //偶路通道7差分
    input  wire        I_lvds_rxe_d3_n,
    
    output wire        O_true_flag_led
);


    wire        S_tx_rst_o;
    wire        S_rx_rst_o;
    wire        S_tx_rst_e;
    wire        S_rx_rst_e;
    wire        S_all_R_data_o;
    wire        S_all_G_data_o;
    wire        S_all_B_data_o;
    wire        S_all_R_data_e;
    wire        S_all_G_data_e;
    wire        S_all_B_data_e;
      
    
    // 双路时钟域定义
    wire        S_tx_clk_1x_odd, S_tx_clk_1x_even;  // 发送端像素时钟
    wire        S_tx_clk_3p5x;                      // 发送端串行时钟(共享)
    
    wire        S_rx_clk_1x_odd, S_rx_clk_1x_even;  // 接收端像素时钟
    wire        S_rx_clk_3p5x_odd, S_rx_clk_3p5x_even; // 接收端串行时钟
    
    // 双路RGB数据 (各24位)
    wire [23:0] S_all_RGB_data_odd = {S_all_R_data_o, S_all_G_data_o, S_all_B_data_o};
    wire [23:0] S_all_RGB_data_even = {S_all_R_data_e, S_all_G_data_e, S_all_B_data_e};
    
    // 控制信号
    wire        S_all_DE_o, S_all_VS_o, S_all_HS_o;
    wire        S_all_DE_e, S_all_VS_e, S_all_HS_e;
    wire        S_tx_ready;

    // ===== 发送端PLL (双路独立) =====
    tx_pll u_tx_pll_odd(
        .I_clk      (I_clk),
        .O_rst      (S_tx_rst_o),
        .O_clk_1x   (S_tx_clk_1x_odd),    // 奇路像素时钟
        .O_clk_3p5x (S_tx_clk_3p5x)       // 串行时钟共享
    );
    
    tx_pll u_tx_pll_even(
        .I_clk      (I_clk),
        .O_rst      (S_tx_rst_e),
        .O_clk_1x   (S_tx_clk_1x_even),   // 偶路像素时钟
        .O_clk_3p5x ()                    // 无需二次输出
    );

    // ===== LVDS发送模块 (双路8通道) =====
    lvds_tx_wrapper #(
        .PROTOCOL("VESA") 
    ) u_lvds_tx_wrapper( 
        // 双路时钟
        .I_clk_1x_o   (S_tx_clk_1x_odd),
        .I_clk_1x_e   (S_tx_clk_1x_even),
        .I_clk_3p5x     (S_tx_clk_3p5x),
        
        .I_rst          (S_tx_rst),
        
        // 双路RGB数据输入 (各8bit/颜色)
        .I_R_data_o   (S_all_R_data_o),
        .I_G_data_o   (S_all_G_data_o),
        .I_B_data_o   (S_all_B_data_o),
        .I_R_data_e  (S_all_R_data_e),
        .I_G_data_e  (S_all_G_data_e),
        .I_B_data_e  (S_all_B_data_e),
        
        .I_DE           (S_all_DE),
        .I_VS           (S_all_VS),
        .I_HS           (S_all_HS),
        
        // 奇路输出 (通道0-3)
        .O_lvds_tx_clk_o  (O_lvds_tx_clk_o),
        .O_lvds_tx_d0       (O_lvds_tx_d0),
        .O_lvds_tx_d1       (O_lvds_tx_d1),
        .O_lvds_tx_d2       (O_lvds_tx_d2),
        .O_lvds_tx_d3       (O_lvds_tx_d3),
        
        // 偶路输出 (通道4-7)
        .O_lvds_tx_clk_e (O_lvds_tx_clk_e),
        .O_lvds_tx_d4       (O_lvds_tx_d4),  // 通道4
        .O_lvds_tx_d5       (O_lvds_tx_d5),  // 通道5
        .O_lvds_tx_d6       (O_lvds_tx_d6),  // 通道6
        .O_lvds_tx_d7       (O_lvds_tx_d7)   // 通道7
    );

    // ===== 接收端PLL (双路独立) =====
    rx_pll u_rx_pll_odd(
        .I_clk        (I_lvds_rx_clk_o),   // 奇路输入时钟
        .I_tx_rst     (S_tx_rst_o),
        .O_rx_rst     (S_rx_rst_o),
        .O_clk_1x     (S_rx_clk_1x_odd),   // 奇路像素时钟
        .O_clk_3p5x   (S_rx_clk_3p5x_odd)  // 奇路串行时钟
    );
    
    rx_pll u_rx_pll_even(
        .I_clk        (I_lvds_rx_clk_e),   // 偶路输入时钟
        .I_tx_rst     (S_tx_rst_e),
        .O_rx_rst     (),                 // 复位信号共享
        .O_clk_1x     (S_rx_clk_1x_even), // 偶路像素时钟
        .O_clk_3p5x   (S_rx_clk_3p5x_even)
    );

    // ===== LVDS接收模块 (双路8通道) =====
    lvds_rx_wrapper #(
        .PROTOCOL("VESA")
    ) u_lvds_rx_wrapper(
        // 双路时钟
        .I_clk_1x_o    (S_rx_clk_1x_odd),
        .I_clk_1x_e   (S_rx_clk_1x_even),
        .I_clk_3p5x_o  (S_rx_clk_3p5x_odd),
        .I_clk_3p5x_e (S_rx_clk_3p5x_even),
        
        .I_rst      (S_rx_rst),
        
        // 奇路差分输入
        .I_lvds_rxo_d0_p(I_lvds_rxo_d0_p), 
        .I_lvds_rxo_d0_n(I_lvds_rxo_d0_n),
        .I_lvds_rxo_d1_p(I_lvds_rxo_d1_p), 
        .I_lvds_rxo_d1_n(I_lvds_rxo_d1_n),
        .I_lvds_rxo_d2_p(I_lvds_rxo_d2_p), 
        .I_lvds_rxo_d2_n(I_lvds_rxo_d2_n),
        .I_lvds_rxo_d3_p(I_lvds_rxo_d3_p), 
        .I_lvds_rxo_d3_n(I_lvds_rxo_d3_n),
        
        // 偶路差分输入
        .I_lvds_rxe_d0_p(I_lvds_rxe_d0_p), 
        .I_lvds_rxe_d0_n(I_lvds_rxe_d0_n),
        .I_lvds_rxe_d1_p(I_lvds_rxe_d1_p), 
        .I_lvds_rxe_d1_n(I_lvds_rxe_d1_n),
        .I_lvds_rxe_d2_p(I_lvds_rxe_d2_p), 
        .I_lvds_rxe_d2_n(I_lvds_rxe_d2_n),
        .I_lvds_rxe_d3_p(I_lvds_rxe_d3_p), 
        .I_lvds_rxe_d3_n(I_lvds_rxe_d3_n),
  
        // 双路RGB输出
        .O_RGB_o  ({S_all_R_data_o, S_all_G_data_o, S_all_B_data_o}), // 奇路24位
        .O_RGB_e ({S_all_R_data_e, S_all_G_data_e, S_all_B_data_e})  // 偶路24位
    );

    // ===== 错误检测模块 (双路独立校验) =====
    rgb_error_dect u_error_dect_odd(
        .I_clk          (S_tx_clk_1x_odd),
        .I_rst          (S_tx_rst),
        .I_RGB_data     (S_all_RGB_data_odd),  // 奇路24位RGB
        .O_RGB_true_flag(O_true_flag_odd)
    );
    
    rgb_error_dect u_error_dect_even(
        .I_clk          (S_tx_clk_1x_even),
        .I_rst          (S_tx_rst),
        .I_RGB_data     (S_all_RGB_data_even), // 偶路24位RGB
        .O_RGB_true_flag(O_true_flag_even)
    );
    
    assign O_true_flag_led = O_true_flag_odd && O_true_flag_even;

endmodule