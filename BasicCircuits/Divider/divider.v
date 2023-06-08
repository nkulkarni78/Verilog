module divider(a,b,q,r);
  input [7:0]a,b;
  output reg [7:0]q,r;
  reg [7:0]temp;
  always@(*)
  begin
    r=a;
    temp=a;
    q=8'd0;
    while(r>=b)
    begin
      r=temp-b;
      q=q+1;
      temp=r;
    end
  end
endmodule
