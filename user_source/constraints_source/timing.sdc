create_clock -name {I_clk} -period 40.000 -waveform {0.000 20.000} [get_ports {I_clk}]
#create_clock -name {rx_refclk} -period 10.000 -waveform {0.000 5.000} [get_ports {I_lvds_rx_clk}]

derive_clocks
rename_clock -name {rx_clkout0} [get_clocks {u_rx_pll/u_rx_pll/PH1P_PHY_PLL_WRAPPER_393d45aa68c4_Inst/u_PH1P_PHY_PLL.clkc[0]}]
rename_clock -name {rx_clkout1} [get_clocks {u_rx_pll/u_rx_pll/PH1P_PHY_PLL_WRAPPER_393d45aa68c4_Inst/u_PH1P_PHY_PLL.clkc[1]}]
rename_clock -name {tx_clkout0} [get_clocks {u_tx_pll/u_tpll/PH1P_PHY_PLL_WRAPPER_d8cf02616d56_Inst/u_PH1P_PHY_PLL.clkc[0]}]
rename_clock -name {tx_clkout1} [get_clocks {u_tx_pll/u_tpll/PH1P_PHY_PLL_WRAPPER_d8cf02616d56_Inst/u_PH1P_PHY_PLL.clkc[1]}]
set_clock_groups -exclusive -group [get_clocks {tx_clkout0}] -group [get_clocks {tx_clkout1}]
set_clock_groups -exclusive -group [get_clocks {rx_clkout0}] -group [get_clocks {rx_clkout1}]
set_clock_groups -exclusive -group [get_clocks {tx_clkout0}] -group [get_clocks {rx_clkout1}]
set_clock_groups -exclusive -group [get_clocks {tx_clkout0}] -group [get_clocks {rx_clkout0}]
set_clock_groups -exclusive -group [get_clocks {rx_clkout0}] -group [get_clocks {tx_clkout1}]
#set_clock_groups -exclusive -group [get_clocks {rx_clkout0}] -group [get_clocks {tx_clkout0}]
##set_clock_groups -exclusive -group [get_clocks {tx_clkout0}] -group [get_clocks {rx_clkout2}]


