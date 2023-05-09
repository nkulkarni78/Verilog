module multiply8x8_tb;
  reg [7:0]A;
  reg [7:0]B;
  wire [15:0]Y;
  hw1 mul(.Y(Y),.A(A),.B(B));
  
  initial begin
    //$monitor("A=%b, B=%b, Y=%b",A,B,Y);
    $monitor("A=%d, B=%d, Y=%d",A,B,Y);
    A=8'd13; B=8'd12;
    #10 A=8'b00011001; B=8'b00011100;
    #10 A=8'b00111100; B=8'b00011110;
    #10 A=8'b10001100; B=8'b00011111;
    #10 A=8'b11011100; B=8'b10011100;
    #10 A=8'b11011100; B=8'b11011100;
    #10 A=8'b11111111; B=8'b11111111;
  end
  
  /*initial begin
    $monitor("A=%d, B=%d, Y=%d",A,B,Y);
    //$monitor("A=%b, B=%b, Y=%b",A,B,Y);
  end*/
  
endmodule
