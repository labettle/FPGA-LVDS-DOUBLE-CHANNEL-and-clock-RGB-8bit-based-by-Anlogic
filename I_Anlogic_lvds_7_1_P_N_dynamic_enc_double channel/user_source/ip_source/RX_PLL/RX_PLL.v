/************************************************************\
**	Copyright (c) 2012-2024 Anlogic Inc.
**	All Right Reserved.\
\************************************************************/
/************************************************************\
**	Build time: May 24 2024 10:31:19
**	TD version	:	6.1.112585
///////////////////////////////////////////////////////////////////////////////
//	Input frequency:                178.571429000 MHz
//	Clock multiplication factor: 14
//	Clock division factor:       2
//	Clock information:
//		Clock name	| Frequency 	| Phase shift 
//		C0        	| 178.571429   MHz	    |  0.0000 DEG 
//		C1        	| 625.000001   MHz	    |  0.0000 DEG 
///////////////////////////////////////////////////////////////////////////////
`timescale 1 ns / 100 fs 

\************************************************************/
module RX_PLL
(
  input                         refclk,
  output                        clk0_out,
  output                        clk1_out,
  output                        lock,
  input                         pllreset
);
  wire							  clk0_buf;
PH1P_LOGIC_BUFG bufg_c0 (
 .i(clk0_buf), 
 .o(clk0_out) 
 ); 

 






  PH1P_PHY_PLL_WRAPPER_393d45aa68c4
  #(
      .FBKCLK("VCO_PHASE0"),
      .FBKCLK_INT("VCO_PHASE0"),
      .FIN("178.571429000"),
      .REFCLK_DIV(2),
      .FBCLK_DIV(14),
      .CLKC0_ENABLE("ENABLE"),
      .CLKC0_DIV(7),
      .CLKC0_CPHASE(6),
      .CLKC0_FPHASE(0),
      .CLKC0_FPHASE_RSTSEL(0),
      .CLKC0_DUTY50("ENABLE"),
      .CLKC0_DUTY_INT(4),
      .CLKC1_ENABLE("ENABLE"),
      .CLKC1_DIV(2),
      .CLKC1_CPHASE(1),
      .CLKC1_FPHASE(0),
      .CLKC1_FPHASE_RSTSEL(0),
      .CLKC1_DUTY50("ENABLE"),
      .CLKC1_DUTY_INT(1),
      .PLL_USR_RST("ENABLE"),
      .PLL_FEED_TYPE("EXTERNAL"),
      .PLL_FASTLOOP("ENABLE"),
      .LPF_RES(0),
      .LPF_CAP(3),
      .ICP_CUR(15),
      .PHASE_PATH_SEL(0),
      .DYN_PHASE_PATH_SEL("DISABLE"),
      .DYN_FPHASE_EN("DISABLE"),
      .PI_OUT_SEL("NORMAL"),
      .PI_FRAC_EN("DISABLE"),
      .CLKC0_PI_SHIFT_EN("DISABLE"),
      .FEEDBK_MODE("NOCOMP"),
      .DYN_CPHASE_EN("DISABLE")
  )PH1P_PHY_PLL_WRAPPER_393d45aa68c4_Inst
  (
      .clk2_en(1'b0),
      .clk2_out(),
      .clkb2_out(),
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
      .ssc_reset(1'b1),
	  .clkc_rst(2'b00),
      .pllpd(1'b0),
      .fbclk(1'b0),
      .wakeup(1'b0),
      .refclk_rst(1'b0),
      .clk0_en(1'b1),
      .clkb0_out(),
      .clk0_out(clk0_buf),
      .clk1_en(1'b1),
      .clkb1_out(),
      .clk1_out(clk1_out),
      .lock(lock),
      .pllreset(pllreset)
  );
endmodule
