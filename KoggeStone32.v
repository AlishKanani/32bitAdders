`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:38:22 04/07/2019 
// Design Name: 
// Module Name:    KoggeStone32 
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
module KoggeStone32(sum,cout,a, b,cin);
  output [31:0] sum; 
  output cout;
  input [31:0] a, b;
  input cin;
  wire [31:0] c;
  wire [31:0] g, p;
  wire [31:1] g2, p2;
  wire [31:3] g3, p3;
  wire [31:7] g4, p4;
  wire [31:15] g5, p5;
  wire [31:31] g6, p6;
  
  PGgen pggen[31:0](g, p, a, b);

  buf bu0(c[0], g[0]);
  PGnewgen pgnewgen0[31:1](g2[31:1], p2[31:1], g[31:1], p[31:1], g[30:0], p[30:0]);

  buf bu1[2:1](c[2:1], g2[2:1]);
  PGnewgen pgnewgen1[31:3](g3[31:3], p3[31:3], g2[31:3], p2[31:3], g2[29:1], p2[29:1]);

  buf bu2[6:3](c[6:3], g3[6:3]);
  PGnewgen pgnewgen2[31:7](g4[31:7], p4[31:7], g3[31:7], p3[31:7], g3[27:3], p3[27:3]);

  buf bu3[14:7](c[14:7], g4[14:7]);
  PGnewgen pgnewgen3[31:15](g5[31:15], p5[31:15], g4[31:15], p4[31:15], g4[23:7], p4[23:7]);
        
  buf bu4[30:15](c[30:15], g5[30:15]);
  PGnewgen pgnewgen4_31(g6[31], p6[31], g5[31], p5[31], g5[15], p5[15]);
  
  buf bu5_31(cout, g6[31]);
  
  xor x0(sum[0],p[0],cin);
  xor x[31:1](sum[31:1],p[31:1],c[30:0]);
endmodule

module PGnewgen(G, P, Gi, Pi, GiPrev, PiPrev);
  output G, P;
  input Gi, Pi, GiPrev, PiPrev;
  wire e;
  
  and (e, Pi, GiPrev);
  or  (G, e, Gi);
  and  (P, Pi, PiPrev);
endmodule

module PGgen(g,p,a,b);
  output g, p;
  input a, b;
  
  and (g, a, b);
  xor (p, a, b);
endmodule
