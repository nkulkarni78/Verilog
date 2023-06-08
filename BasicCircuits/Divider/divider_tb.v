module divider_tb;
  reg [7:0]a,b;
  wire [7:0]q,r;
  divider dv(.a(a),.b(b),.q(q),.r(r));
  initial
  begin
    a=8'd1;b=8'd1;
    #5 a=8'd10;b=8'd2;
    #5 a=8'd10;b=8'd3;
    #5 a=8'd5;b=8'd6;
  end
  initial begin
    $monitor($time," a=%d, b=%d, q=%d, r=%d ",a,b,q,r);
    #50 $finish;
  end
endmodule
