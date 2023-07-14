//A 2x1 multiplexer is defined in this module.

`timescale 1ns/1ps;
module mux2x1(y,in,s);
  input [1:0]in;
  input s;
  output reg y;
  always@(*)
    y=(~s)&in[0] | (s)&in[1];
endmodule
