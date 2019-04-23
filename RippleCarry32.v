`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:33:44 03/30/2019 
// Design Name: 
// Module Name:    RippleCarry32 
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
module RippleCarry32(sum,cout,a, b,cin);
  output [31:0] sum; 
  output cout;
  input [31:0] a, b;
  input cin;
  wire [31:1] c;
  FA fa0(sum[0], c[1], a[0], b[0], cin);
  FA fa[30:1](sum[30:1], c[31:2], a[30:1], b[30:1], c[30:1]);
  FA fa31(sum[31], cout, a[31], b[31], c[31]);
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
