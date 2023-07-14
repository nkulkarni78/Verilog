//Testbench for 2x1 mux
`timescale 1ns/1ps;

module mux_tb;
  reg [3:0]in;
  reg [1:0]s;
  wire y;

  mux4x1 m4(.y(y),.in(in),.s(s));
  initial
  begin
    s=2'b00; in=4'b0000;
    #5 s=2'b01; #5 in=4'b0001;
    #5 s=2'b10; #5 in=4'b0010;
    #5 s=2'b11; #5 in=4'b0011;
    #5 s=2'b00; #5 in=4'b0100;
    #5 s=2'b01; #5 in=4'b0101;
    #5 s=2'b10; #5 in=4'b0111;
    #5 s=2'b11; #5 in=4'b1100;
    #5 s=2'b00; #5 in=4'b0101;
  end

  initial
  begin
    $monitor("s=%2b  in=%4b  y=%b\n",s,in,y);
    #100 $finish;
  end
endmodule
