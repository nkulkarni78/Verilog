//This module contains definition of 8x1 multiplexer built 
//from 4x1 multiplexer which is inturn built from 2x1 mux. 
//2-4x1 mux & 1-2x1 mux are instantiated for 8x1 multiplexer.

`include "mux4x1.v";
`timescale 1ns/1ps;
module mux8x1(y,in,s);
  input [7:0]in;
  input [2:0]s;
  output y;
  wire [1:0]w;

  mux4x1 m1(w[0],in[3:0],s[1:0]);
  mux4x1 m2(w[1],in[7:4],s[1:0]);
  mux2x1 m(y,w,s[2]);
endmodule
