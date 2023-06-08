module comparator(a,b,eq,lt,gt);
  input [3:0]a,b;
  output reg eq,lt,gt;
  always@(*)
    begin
      eq=(a==b)?1:0;
      lt=(a<b)?1:0;
      gt=(a>b)?1:0;
    end
endmodule
