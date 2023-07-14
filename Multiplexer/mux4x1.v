//This module contains 4x1 mux behavioral model built from
//2x1 mux. Three 2x1 multiplexers are instantiated for one
//4x1 multiplexer. Module definition is as follows:

`include "mux2x1.v"
`timescale 1ns/1ps;
module mux4x1(y,in,s);
  input [3:0]in;
  input [1:0]s;
  output y;
  //To connect the outputs of 2 level 1 multiplexers.
  wire [1:0]w;

  mux2x1 m1(w[0],in[1:0],s[0]);
  mux2x1 m2(w[1],in[3:2],s[0]);
  mux2x1 m3(y,w,s[1]);
endmodule
