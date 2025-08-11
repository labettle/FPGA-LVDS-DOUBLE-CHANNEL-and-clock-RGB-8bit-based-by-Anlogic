module cwc
(
  input   [0:0]                 probe0,
  input   [7:0]                 probe1,
  input   [7:0]                 probe2,
  input   [0:0]                 probe3,
  input                         clk
);

  ChipWatcher_ec6f84f3536a  ChipWatcher_ec6f84f3536a_Inst
  (
      .probe0(probe0),
      .probe1(probe1),
      .probe2(probe2),
      .probe3(probe3),
      .clk(clk)
  );
endmodule
