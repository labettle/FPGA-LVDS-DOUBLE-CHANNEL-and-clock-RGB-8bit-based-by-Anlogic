/************************************************************\
**	Copyright (c) 2012-2025 Anlogic Inc.
**	All Right Reserved.
\************************************************************/
/************************************************************\
**	Build time: Aug 08 2025 15:54:51
**	TD version	:	6.1.154205
************************************************************/
///////////////////////////////////////////////////////////////////////////////
//	Input frequency:                25.000000000 MHz
//	Clock multiplication factor: 50
//	Clock division factor:       1
//	Clock information:
//		Clock name	| Frequency 	| Phase shift 
//		C0        	| 178.571429   MHz	    |  0.0000 DEG 
//		C2        	| 178.571429   MHz		|  0.0000 DEG 
///////////////////////////////////////////////////////////////////////////////
`timescale 1 ns / 100 fs 

module TX_PLL
(
  input                         refclk,
  input                         reset,
  output                        clk0_out,
  output                        clk2_out,
  output                        lock
);
  wire							  clk0_buf;
PH1P_LOGIC_BUFG bufg_c0 (
 .i(clk0_buf), 
 .o(clk0_out) 
 ); 


 





  ph1p_phy_pll_wrapper_d8cf02616d56
  #(
      .FBKCLK("VCO_PHASE0"),
      .FBKCLK_INT("VCO_PHASE0"),
      .FIN("25.000000000"),
      .REFCLK_DIV(1),
      .FBCLK_DIV(50),
      .CLKC0_ENABLE("ENABLE"),
      .CLKC0_DIV(7),
      .CLKC0_CPHASE(6),
      .CLKC0_FPHASE(0),
      .CLKC0_FPHASE_RSTSEL(0),
      .CLKC0_DUTY50("ENABLE"),
      .CLKC0_DUTY_INT(4),
      .CLKC2_ENABLE("ENABLE"),
      .CLKC2_DIV(7),
      .CLKC2_CPHASE(6),
      .CLKC2_FPHASE(0),
      .CLKC2_FPHASE_RSTSEL(0),
      .CLKC2_DUTY50("ENABLE"),
      .CLKC2_DUTY_INT(4),
      .PLL_USR_RST("ENABLE"),
      .PLL_FEED_TYPE("EXTERNAL"),
      .PLL_FASTLOOP("ENABLE"),
      .LPF_RES(0),
      .LPF_CAP(25),
      .ICP_CUR(29),
      .PHASE_PATH_SEL(0),
      .DYN_PHASE_PATH_SEL("DISABLE"),
      .DYN_FPHASE_EN("DISABLE"),
      .PI_OUT_SEL("NORMAL"),
      .PI_FRAC_EN("DISABLE"),
      .CLKC0_PI_SHIFT_EN("DISABLE"),
      .FEEDBK_MODE("NOCOMP"),
      .DYN_CPHASE_EN("DISABLE")
  )ph1p_phy_pll_wrapper_d8cf02616d56_Inst
  (
      .clk1_en(1'b0),
      .clk1_out(),
      .clkb1_out(),
      .clk3_en(1'b0),
      .clk3_out(),
      .clkb3_out(),
      .clk4_en(1'b0),
      .clk4_out(),
      .clkb4_out(),
      .clk5_en(1'b0),
      .clk5_out(),
      .clkb5_out(),
      .clk6_en(1'b0),
      .clk6_out(),
      .clkb6_out(),
      .refclk(refclk),
      .drp_clk(1'b0),
      .drp_rstn(1'b1),
      .drp_sel(1'b0),
      .drp_rd(1'b0),
      .drp_wr(1'b0),
      .drp_addr(8'b00000000),
      .drp_wdata(8'b00000000),
      .drp_err(),
      .drp_rdy(),
      .drp_rdata(),
      .psclk(1'b0),
      .psclksel(3'b000),
      .psstep(1'b0),
      .psdown(1'b0),
      .cps_step(1'b0),
      .psdone(),
      .ssc_reset(1'b0),
	  .clkc_rst(2'b00),
      .pllpd(1'b0),
      .fbclk(1'b0),
      .wakeup(1'b1),
      .refclk_rst(1'b0),
      .clk0_en(1'b1),
      .clkb0_out(),
      .clk0_out(clk0_buf),
      .clk2_en(1'b1),
      .clkb2_out(),
      .clk2_out(clk2_out),
      .lock(lock),
      .reset(reset)
  );
endmodule
