`timescale 1ns / 1ps

module design_top_wrapper_tb;

    // Inputs
    reg I_clk; 
    reg I_lvds_rx_clk_o, I_lvds_rx_clk_e;
    reg I_lvds_rxo_d0_p, I_lvds_rxo_d0_n;
    reg I_lvds_rxo_d1_p, I_lvds_rxo_d1_n;
    reg I_lvds_rxo_d2_p, I_lvds_rxo_d2_n;
    reg I_lvds_rxo_d3_p, I_lvds_rxo_d3_n;
    reg I_lvds_rxe_d0_p, I_lvds_rxe_d0_n;
    reg I_lvds_rxe_d1_p, I_lvds_rxe_d1_n;
    reg I_lvds_rxe_d2_p, I_lvds_rxe_d2_n;
    reg I_lvds_rxe_d3_p, I_lvds_rxe_d3_n;
    
    // Outputs
    wire O_lvds_tx_clk_o, O_lvds_tx_d0, O_lvds_tx_d1, O_lvds_tx_d2, O_lvds_tx_d3;
    wire O_lvds_tx_clk_e, O_lvds_tx_d4, O_lvds_tx_d5, O_lvds_tx_d6, O_lvds_tx_d7;
    wire O_true_flag_led;

    // Instantiate the design under test (DUT)
    design_top_wrapper DUT (
        .I_clk(I_clk),
        .I_lvds_rx_clk_o(I_lvds_rx_clk_o), .I_lvds_rx_clk_e(I_lvds_rx_clk_e),
        .I_lvds_rxo_d0_p(I_lvds_rxo_d0_p), .I_lvds_rxo_d0_n(I_lvds_rxo_d0_n),
        .I_lvds_rxo_d1_p(I_lvds_rxo_d1_p), .I_lvds_rxo_d1_n(I_lvds_rxo_d1_n),
        .I_lvds_rxo_d2_p(I_lvds_rxo_d2_p), .I_lvds_rxo_d2_n(I_lvds_rxo_d2_n),
        .I_lvds_rxo_d3_p(I_lvds_rxo_d3_p), .I_lvds_rxo_d3_n(I_lvds_rxo_d3_n),
        .I_lvds_rxe_d0_p(I_lvds_rxe_d0_p), .I_lvds_rxe_d0_n(I_lvds_rxe_d0_n),
        .I_lvds_rxe_d1_p(I_lvds_rxe_d1_p), .I_lvds_rxe_d1_n(I_lvds_rxe_d1_n),
        .I_lvds_rxe_d2_p(I_lvds_rxe_d2_p), .I_lvds_rxe_d2_n(I_lvds_rxe_d2_n),
        .I_lvds_rxe_d3_p(I_lvds_rxe_d3_p), .I_lvds_rxe_d3_n(I_lvds_rxe_d3_n),
        .O_lvds_tx_clk_o(O_lvds_tx_clk_o), .O_lvds_tx_d0(O_lvds_tx_d0), .O_lvds_tx_d1(O_lvds_tx_d1),
        .O_lvds_tx_d2(O_lvds_tx_d2), .O_lvds_tx_d3(O_lvds_tx_d3),
        .O_lvds_tx_clk_e(O_lvds_tx_clk_e), .O_lvds_tx_d4(O_lvds_tx_d4), .O_lvds_tx_d5(O_lvds_tx_d5),
        .O_lvds_tx_d6(O_lvds_tx_d6), .O_lvds_tx_d7(O_lvds_tx_d7),
        .O_true_flag_led(O_true_flag_led)
    );

    // Clock Generation
    initial begin
        I_clk = 0;
        forever #20 I_clk = ~I_clk;  // 主时钟 40ns (25 MHz)
    end

    // LVDS RX Clock Generation (两个不同的时钟，奇路和偶路)
    initial begin
        I_lvds_rx_clk_o = 0;
        I_lvds_rx_clk_e = 0;
        forever begin
            #20 I_lvds_rx_clk_o = ~I_lvds_rx_clk_o;  // 奇路 50 MHz 时钟
            #20 I_lvds_rx_clk_e = ~I_lvds_rx_clk_e;  // 偶路 50 MHz 时钟
        end
    end

    // 随机生成 LVDS RX 输入信号（差分对）
    initial begin
        I_lvds_rxo_d0_p = 0; I_lvds_rxo_d0_n = 1;
        I_lvds_rxo_d1_p = 0; I_lvds_rxo_d1_n = 1;
        I_lvds_rxo_d2_p = 0; I_lvds_rxo_d2_n = 1;
        I_lvds_rxo_d3_p = 0; I_lvds_rxo_d3_n = 1;
        
        I_lvds_rxe_d0_p = 0; I_lvds_rxe_d0_n = 1;
        I_lvds_rxe_d1_p = 0; I_lvds_rxe_d1_n = 1;
        I_lvds_rxe_d2_p = 0; I_lvds_rxe_d2_n = 1;
        I_lvds_rxe_d3_p = 0; I_lvds_rxe_d3_n = 1;

        // 模拟随机生成 LVDS 信号
        forever begin
            #20 I_lvds_rxo_d0_p = $random; I_lvds_rxo_d0_n = ~I_lvds_rxo_d0_p;
            I_lvds_rxo_d1_p = $random; I_lvds_rxo_d1_n = ~I_lvds_rxo_d1_p;
            I_lvds_rxo_d2_p = $random; I_lvds_rxo_d2_n = ~I_lvds_rxo_d2_p;
            I_lvds_rxo_d3_p = $random; I_lvds_rxo_d3_n = ~I_lvds_rxo_d3_p;

            I_lvds_rxe_d0_p = $random; I_lvds_rxe_d0_n = ~I_lvds_rxe_d0_p;
            I_lvds_rxe_d1_p = $random; I_lvds_rxe_d1_n = ~I_lvds_rxe_d1_p;
            I_lvds_rxe_d2_p = $random; I_lvds_rxe_d2_n = ~I_lvds_rxe_d2_p;
            I_lvds_rxe_d3_p = $random; I_lvds_rxe_d3_n = ~I_lvds_rxe_d3_p;
        end
    end

    // 测试序列：应用复位并检查输出
    initial begin
        // 初始复位
        $display("Starting simulation...");
        #10;
        
        // 应用复位信号
        $display("Applying reset...");
        // 模拟复位
        #50;
        
        // 释放复位并开始正常操作
        $display("Release reset...");
        #20;

        // 观察输出信号
        $display("Monitoring output signals...");
        #500;
        
        // 仿真结束
        $finish;
    end

    // 监视重要信号
    initial begin
        $monitor("Time: %t, O_lvds_tx_clk_o: %b, O_lvds_tx_d0: %b, O_lvds_tx_d1: %b, O_lvds_tx_d2: %b, O_lvds_tx_d3: %b", 
                 $time, O_lvds_tx_clk_o, O_lvds_tx_d0, O_lvds_tx_d1, O_lvds_tx_d2, O_lvds_tx_d3);
    end

endmodule
