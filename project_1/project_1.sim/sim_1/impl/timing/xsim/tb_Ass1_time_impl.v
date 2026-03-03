// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sun Mar  1 09:35:23 2026
// Host        : Matej running 64-bit major release  (build 9200)
// Command     : write_verilog -mode timesim -nolib -sdf_anno true -force -file
//               C:/Users/marti/Documents/DDSP/project_1/project_1.sim/sim_1/impl/timing/xsim/tb_Ass1_time_impl.v
// Design      : ALU
// Purpose     : This verilog netlist is a timing simulation representation of the design and should not be modified or
//               synthesized. Please ensure that this netlist is used with the corresponding SDF file.
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps
`define XIL_TIMING

(* ECO_CHECKSUM = "25b18c6c" *) 
(* NotValidForBitStream *)
module ALU
   (number1,
    number2,
    Cin,
    Operator,
    result,
    Cout);
  input [7:0]number1;
  input [7:0]number2;
  input Cin;
  input [1:0]Operator;
  output [7:0]result;
  output Cout;

  wire Cin;
  wire Cin_IBUF;
  wire Cout;
  wire Cout_OBUF;
  wire [1:0]Operator;
  wire [1:0]Operator_IBUF;
  wire [7:0]number1;
  wire [7:0]number1_IBUF;
  wire [7:0]number2;
  wire [7:0]number2_IBUF;
  wire [7:0]result;
  wire [7:0]result_OBUF;
  wire \result_OBUF[1]_inst_i_2_n_0 ;
  wire \result_OBUF[2]_inst_i_2_n_0 ;
  wire \result_OBUF[3]_inst_i_2_n_0 ;
  wire \result_OBUF[4]_inst_i_2_n_0 ;
  wire \result_OBUF[5]_inst_i_2_n_0 ;
  wire \result_OBUF[6]_inst_i_2_n_0 ;
  wire \result_OBUF[7]_inst_i_2_n_0 ;

initial begin
 $sdf_annotate("tb_Ass1_time_impl.sdf",,,,"tool_control");
end
  IBUF Cin_IBUF_inst
       (.I(Cin),
        .O(Cin_IBUF));
  OBUF Cout_OBUF_inst
       (.I(Cout_OBUF),
        .O(Cout));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'hFEEAA880)) 
    Cout_OBUF_inst_i_1
       (.I0(number2_IBUF[7]),
        .I1(number1_IBUF[6]),
        .I2(\result_OBUF[6]_inst_i_2_n_0 ),
        .I3(number2_IBUF[6]),
        .I4(number1_IBUF[7]),
        .O(Cout_OBUF));
  IBUF \Operator_IBUF[0]_inst 
       (.I(Operator[0]),
        .O(Operator_IBUF[0]));
  IBUF \Operator_IBUF[1]_inst 
       (.I(Operator[1]),
        .O(Operator_IBUF[1]));
  IBUF \number1_IBUF[0]_inst 
       (.I(number1[0]),
        .O(number1_IBUF[0]));
  IBUF \number1_IBUF[1]_inst 
       (.I(number1[1]),
        .O(number1_IBUF[1]));
  IBUF \number1_IBUF[2]_inst 
       (.I(number1[2]),
        .O(number1_IBUF[2]));
  IBUF \number1_IBUF[3]_inst 
       (.I(number1[3]),
        .O(number1_IBUF[3]));
  IBUF \number1_IBUF[4]_inst 
       (.I(number1[4]),
        .O(number1_IBUF[4]));
  IBUF \number1_IBUF[5]_inst 
       (.I(number1[5]),
        .O(number1_IBUF[5]));
  IBUF \number1_IBUF[6]_inst 
       (.I(number1[6]),
        .O(number1_IBUF[6]));
  IBUF \number1_IBUF[7]_inst 
       (.I(number1[7]),
        .O(number1_IBUF[7]));
  IBUF \number2_IBUF[0]_inst 
       (.I(number2[0]),
        .O(number2_IBUF[0]));
  IBUF \number2_IBUF[1]_inst 
       (.I(number2[1]),
        .O(number2_IBUF[1]));
  IBUF \number2_IBUF[2]_inst 
       (.I(number2[2]),
        .O(number2_IBUF[2]));
  IBUF \number2_IBUF[3]_inst 
       (.I(number2[3]),
        .O(number2_IBUF[3]));
  IBUF \number2_IBUF[4]_inst 
       (.I(number2[4]),
        .O(number2_IBUF[4]));
  IBUF \number2_IBUF[5]_inst 
       (.I(number2[5]),
        .O(number2_IBUF[5]));
  IBUF \number2_IBUF[6]_inst 
       (.I(number2[6]),
        .O(number2_IBUF[6]));
  IBUF \number2_IBUF[7]_inst 
       (.I(number2[7]),
        .O(number2_IBUF[7]));
  OBUF \result_OBUF[0]_inst 
       (.I(result_OBUF[0]),
        .O(result[0]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'hBC4C4F83)) 
    \result_OBUF[0]_inst_i_1 
       (.I0(Cin_IBUF),
        .I1(Operator_IBUF[1]),
        .I2(Operator_IBUF[0]),
        .I3(number2_IBUF[0]),
        .I4(number1_IBUF[0]),
        .O(result_OBUF[0]));
  OBUF \result_OBUF[1]_inst 
       (.I(result_OBUF[1]),
        .O(result[1]));
  LUT5 #(
    .INIT(32'hBC4C4F83)) 
    \result_OBUF[1]_inst_i_1 
       (.I0(\result_OBUF[1]_inst_i_2_n_0 ),
        .I1(Operator_IBUF[1]),
        .I2(Operator_IBUF[0]),
        .I3(number2_IBUF[1]),
        .I4(number1_IBUF[1]),
        .O(result_OBUF[1]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hE8)) 
    \result_OBUF[1]_inst_i_2 
       (.I0(number2_IBUF[0]),
        .I1(Cin_IBUF),
        .I2(number1_IBUF[0]),
        .O(\result_OBUF[1]_inst_i_2_n_0 ));
  OBUF \result_OBUF[2]_inst 
       (.I(result_OBUF[2]),
        .O(result[2]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'hBC4C4F83)) 
    \result_OBUF[2]_inst_i_1 
       (.I0(\result_OBUF[2]_inst_i_2_n_0 ),
        .I1(Operator_IBUF[1]),
        .I2(Operator_IBUF[0]),
        .I3(number2_IBUF[2]),
        .I4(number1_IBUF[2]),
        .O(result_OBUF[2]));
  LUT5 #(
    .INIT(32'hFEEAA880)) 
    \result_OBUF[2]_inst_i_2 
       (.I0(number2_IBUF[1]),
        .I1(number1_IBUF[0]),
        .I2(Cin_IBUF),
        .I3(number2_IBUF[0]),
        .I4(number1_IBUF[1]),
        .O(\result_OBUF[2]_inst_i_2_n_0 ));
  OBUF \result_OBUF[3]_inst 
       (.I(result_OBUF[3]),
        .O(result[3]));
  LUT5 #(
    .INIT(32'hBC4C4F83)) 
    \result_OBUF[3]_inst_i_1 
       (.I0(\result_OBUF[3]_inst_i_2_n_0 ),
        .I1(Operator_IBUF[1]),
        .I2(Operator_IBUF[0]),
        .I3(number2_IBUF[3]),
        .I4(number1_IBUF[3]),
        .O(result_OBUF[3]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hE8)) 
    \result_OBUF[3]_inst_i_2 
       (.I0(number2_IBUF[2]),
        .I1(\result_OBUF[2]_inst_i_2_n_0 ),
        .I2(number1_IBUF[2]),
        .O(\result_OBUF[3]_inst_i_2_n_0 ));
  OBUF \result_OBUF[4]_inst 
       (.I(result_OBUF[4]),
        .O(result[4]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'hBC4C4F83)) 
    \result_OBUF[4]_inst_i_1 
       (.I0(\result_OBUF[4]_inst_i_2_n_0 ),
        .I1(Operator_IBUF[1]),
        .I2(Operator_IBUF[0]),
        .I3(number2_IBUF[4]),
        .I4(number1_IBUF[4]),
        .O(result_OBUF[4]));
  LUT5 #(
    .INIT(32'hFEEAA880)) 
    \result_OBUF[4]_inst_i_2 
       (.I0(number2_IBUF[3]),
        .I1(number1_IBUF[2]),
        .I2(\result_OBUF[2]_inst_i_2_n_0 ),
        .I3(number2_IBUF[2]),
        .I4(number1_IBUF[3]),
        .O(\result_OBUF[4]_inst_i_2_n_0 ));
  OBUF \result_OBUF[5]_inst 
       (.I(result_OBUF[5]),
        .O(result[5]));
  LUT5 #(
    .INIT(32'hBC4C4F83)) 
    \result_OBUF[5]_inst_i_1 
       (.I0(\result_OBUF[5]_inst_i_2_n_0 ),
        .I1(Operator_IBUF[1]),
        .I2(Operator_IBUF[0]),
        .I3(number2_IBUF[5]),
        .I4(number1_IBUF[5]),
        .O(result_OBUF[5]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hE8)) 
    \result_OBUF[5]_inst_i_2 
       (.I0(number2_IBUF[4]),
        .I1(\result_OBUF[4]_inst_i_2_n_0 ),
        .I2(number1_IBUF[4]),
        .O(\result_OBUF[5]_inst_i_2_n_0 ));
  OBUF \result_OBUF[6]_inst 
       (.I(result_OBUF[6]),
        .O(result[6]));
  LUT5 #(
    .INIT(32'hBC4C4F83)) 
    \result_OBUF[6]_inst_i_1 
       (.I0(\result_OBUF[6]_inst_i_2_n_0 ),
        .I1(Operator_IBUF[1]),
        .I2(Operator_IBUF[0]),
        .I3(number2_IBUF[6]),
        .I4(number1_IBUF[6]),
        .O(result_OBUF[6]));
  LUT5 #(
    .INIT(32'hFEEAA880)) 
    \result_OBUF[6]_inst_i_2 
       (.I0(number2_IBUF[5]),
        .I1(number1_IBUF[4]),
        .I2(\result_OBUF[4]_inst_i_2_n_0 ),
        .I3(number2_IBUF[4]),
        .I4(number1_IBUF[5]),
        .O(\result_OBUF[6]_inst_i_2_n_0 ));
  OBUF \result_OBUF[7]_inst 
       (.I(result_OBUF[7]),
        .O(result[7]));
  LUT5 #(
    .INIT(32'hBC4C4F83)) 
    \result_OBUF[7]_inst_i_1 
       (.I0(\result_OBUF[7]_inst_i_2_n_0 ),
        .I1(Operator_IBUF[1]),
        .I2(Operator_IBUF[0]),
        .I3(number2_IBUF[7]),
        .I4(number1_IBUF[7]),
        .O(result_OBUF[7]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'hE8)) 
    \result_OBUF[7]_inst_i_2 
       (.I0(number2_IBUF[6]),
        .I1(\result_OBUF[6]_inst_i_2_n_0 ),
        .I2(number1_IBUF[6]),
        .O(\result_OBUF[7]_inst_i_2_n_0 ));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
