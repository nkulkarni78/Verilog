//Testbench for 2x1 mux
`timescale 1ns/1ps;

module mux_tb;
  reg [7:0]in;
  reg [2:0]s;
  wire y;

  mux8x1 m4(.y(y),.in(in),.s(s));
  initial
  begin
    s=3'b000; in=8'b00000000;
    #5 s=3'b000; #5 in=8'b00000001;
    #5 s=3'b001; #5 in=8'b00000000;
    #5 s=3'b001; #5 in=8'b00000010;
    #5 s=3'b010; #5 in=8'b00000000;
    #5 s=3'b010; #5 in=8'b00000100;
    #5 s=3'b011; #5 in=8'b00000000;
    #5 s=3'b011; #5 in=8'b00001000;
    #5 s=3'b100; #5 in=8'b00000000;
    #5 s=3'b100; #5 in=8'b00010000;
    #5 s=3'b101; #5 in=8'b00000000;
    #5 s=3'b101; #5 in=8'b00100000;
    #5 s=3'b110; #5 in=8'b00000000;
    #5 s=3'b110; #5 in=8'b01000000;
    #5 s=3'b111; #5 in=8'b00000000;
    #5 s=3'b111; #5 in=8'b10000000;
  end

  initial
  begin
    $monitor("s=%3b  in=%8b  y=%b\n",s,in,y);
    #200 $finish;
  end
endmodule
