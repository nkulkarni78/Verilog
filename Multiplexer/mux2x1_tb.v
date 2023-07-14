//Testbench for 2x1 mux
`timescale 1ns/1ps;

module mux_tb;
  reg [1:0]in;
  reg s;
  wire y;

  mux2x1 m1(.y(y),.in(in),.s(s));
  initial
  begin
    s=1'b0; in=2'b00;
    #5 s=1'b1; #5 in=2'b01;
    #5 s=1'b0; #5 in=2'b10;
    #5 s=1'b1; #5 in=2'b11;
    #5 s=1'b0; #5 in=2'b00;
  end

  initial
  begin
    $monitor("s=%b  in[0]=%b  in[1]=%b  y=%b\n",s,in[0],in[1],
              y);

    #100 $finish;
  end
endmodule
