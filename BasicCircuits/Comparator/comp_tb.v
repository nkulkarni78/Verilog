module comp_tb;
  reg [3:0]a,b;
  wire eq,lt,gt;
  comparator cp(.a(a),.b(b),.eq(eq),.lt(lt),.gt(gt));
  initial 
  begin
    a=4'd0;b=4'd0;
    #5 a=4'd1;b=4'd2;
    #5 a=4'd5;b=4'd5;
    repeat(5)
    begin
      #5 a=$random;b=$random;
    end
  end
  initial
  begin
    $monitor($time," a=%d, b=%d, eq=%b, lt=%b, gt=%b", a,b,eq,lt,gt);
    #75 $finish;
  end
endmodule
