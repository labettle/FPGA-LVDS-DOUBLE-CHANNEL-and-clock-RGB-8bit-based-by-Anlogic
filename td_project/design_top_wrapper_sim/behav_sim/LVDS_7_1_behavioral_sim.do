#
cd "D:/APP/Anlogic/fpga_project/I_Anlogic_lvds_7_1_P_N_dynamic_enc_double channel/td_project/design_top_wrapper_sim/behav_sim"
#
#
# Create work library
#
vlib work
#
# compiled simulation library
#
#
# sim_release file path
#
vlog D:/APP/Anlogic/sim_release/common/*.*v
vlog D:/APP/Anlogic/sim_release/common/apm/*.*v
vlog D:/APP/Anlogic/sim_release/ph1p/*.*v
#
# Compile sources
#
vlog  -work work ../../../user_source/hdl_source/design_top_wrapper.v
vlog  -work work ../../../user_source/hdl_source/tx_pll.v
vlog  -work work ../../../user_source/ip_source/TX_PLL/TX_PLL.v
vlog  -work work ../../../user_source/ip_source/TX_PLL/RTL/ph1p_phy_pll_wrapper_d8cf02616d56.v
vlog  -work work ../../../user_source/hdl_source/lvds_tx_wrapper.v
vlog  -work work ../../../user_source/hdl_source/lvds_tx_clk.v
vlog  -work work ../../../user_source/hdl_source/protocol/lcd_to_lvds.v
vlog  -work work ../../../user_source/hdl_source/lvds_tx_parrall_7_1.v
vlog  -work work ../../../user_source/hdl_source/rx_pll.v
vlog  -work work ../../../user_source/ip_source/RX_PLL/RX_PLL.v
vlog  -work work ../../../user_source/ip_source/RX_PLL/PH1P_PHY_PLL_WRAPPER_393d45aa68c4.v
vlog  -work work ../../../user_source/hdl_source/lvds_rx_wrapper.v
vlog  -work work ../../../user_source/hdl_source/lvds_lane.v
vlog  -work work ../../../user_source/hdl_source/lvds_rx_parrall_1_7.v
vlog  -work work ../../../user_source/hdl_source/p_n_data_comparison.v
vlog  -work work ../../../user_source/hdl_source/enc_file/idelay_ctrl.enc.v
vlog  -work work ../../../user_source/hdl_source/lvds_rx_byte_align_1.v
vlog  -work work ../../../user_source/hdl_source/test/error_dect.v
vlog  -work work ../../../user_source/hdl_source/protocol/video_data_process.v
vlog  -work work ../../../user_source/hdl_source/test/rgb_error_dect.v
vlog  -work work design_top_wrapper_tb.v
#
# Call vsim to invoke simulator
#
vsim -t ps -voptargs="+acc" work.design_top_wrapper_tb work.PH1P_PHY_GSR
view vave signals
#
# Add waves
#
add wave *
#
# Run simulation
#
run 1us
stop
#
# End