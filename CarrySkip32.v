`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:47:13 03/31/2019 
// Design Name: 
// Module Name:    CarrySkip32 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module CarrySkip32(sum,cout,a, b,cin);
  output [31:0] sum; 
  output cout;
  input [31:0] a, b;
  input cin;
  wire [31:1] c; 
  wire [6:0] couts;
  wire [6:0] e;
  
  RippleCarry4 rca0(sum[3:0], couts[0], a[3:0], b[3:0], cin);
  SkipLogic skip0(e[0], a[3:0], b[3:0], cin, couts[0]);
  RippleCarry4 rca11(sum[7:4], couts[1], a[7:4], b[7:4], e[0]);
    SkipLogic skip1(e[1], a[7:4], b[7:4], e[0], couts[1]);
  RippleCarry4 rca12(sum[11:8], couts[2], a[11:8], b[11:8], e[1]);
    SkipLogic skip2(e[2], a[11:8], b[11:8], e[1], couts[1]);
  RippleCarry4 rca13(sum[15:12], couts[3], a[15:12], b[15:12], e[2]);
    SkipLogic skip3(e[3], a[15:12], b[15:12], e[2], couts[2]);
  RippleCarry4 rca14(sum[19:16], couts[4], a[19:16], b[19:16], e[3]);
    SkipLogic skip4(e[4], a[19:16], b[19:16], e[3], couts[3]);
  RippleCarry4 rca15(sum[23:20], couts[5], a[23:20], b[23:20], e[4]);
    SkipLogic skip5(e[5], a[23:20], b[23:20], e[4], couts[4]);
  RippleCarry4 rca16(sum[27:24], couts[6], a[27:24], b[27:24], e[5]);
    SkipLogic skip6(e[6], a[27:24], b[27:24], e[5], couts[5]);
  RippleCarry4 rca17(sum[31:28], cout, a[31:28], b[31:28], e[6]);
endmodule

module SkipLogic(y,a, b,cin, cout);
  output y;
  input [3:0] a, b;
  input cin, cout;
  wire p0, p1, p2, p3, P, Pn, e0, e1; 
  
  xor (p0, a[0], b[0]);
  xor (p1, a[1], b[1]);
  xor (p2, a[2], b[2]);
  xor (p3, a[3], b[3]);
  and (P, p0, p1, p2, p3);
  not (Pn, P);
  and (e0, cout, Pn);
  and (e1, cin, P);
  or (y, e0, e1);
endmodule

module RippleCarry4(sum,cout,a, b,cin);
  output [3:0] sum; 
  output cout;
  input [3:0] a, b;
  input cin;
  wire [3:1] c;
  
  FA fa0(sum[0], c[1], a[0], b[0], cin);
  FA fa[2:1](sum[2:1], c[3:2], a[2:1], b[2:1], c[2:1]);
  FA fa3(sum[3], cout, a[3], b[3], c[3]);
endmodule

module FA(sum,cout,a, b,cin);
  output sum, cout;
  input a, b, cin;
  wire w0, w1, w2;
  xor  (w0, a, b);
  xor  (sum, w0, cin);
  and  (w1, w0, cin);
  and  (w2, a, b);
  or  (cout, w1, w2);
endmodule