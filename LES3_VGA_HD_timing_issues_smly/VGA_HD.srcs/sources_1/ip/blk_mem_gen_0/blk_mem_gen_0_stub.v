// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Mon Jan 21 16:22:58 2019
// Host        : NB170210 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {C:/Users/jlgheuve/Documents/Werkmap/2018-2019/Periode
//               3/PROGH2/Opdrachten/Uiterkingen opdrachten/Vivado
//               projecten/VGA_HD_timing_issues_smly/VGA_HD.srcs/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0_stub.v}
// Design      : blk_mem_gen_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_1,Vivado 2017.4" *)
module blk_mem_gen_0(clka, rsta, addra, douta, rsta_busy)
/* synthesis syn_black_box black_box_pad_pin="clka,rsta,addra[13:0],douta[11:0],rsta_busy" */;
  input clka;
  input rsta;
  input [13:0]addra;
  output [11:0]douta;
  output rsta_busy;
endmodule
