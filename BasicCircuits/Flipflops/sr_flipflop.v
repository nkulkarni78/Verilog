module srff(q,qbar,s,r,clk);
  input s,r,clk;
  output reg q,qbar;
  always@(posedge clk)
  begin
    if(s==1)
    begin
      q = 1'b1;
      qbar = ~q;
    end
    else if (r==1)
    begin
      q = 1'b0;
      qbar = q;
    end
    else if (s==0 && r==0)
    begin
      q <= q;
      qbar <= qbar;
    end
    else
    begin
      q = 1'bx;
      qbar = 1'bx;
    end
  end
endmodule
