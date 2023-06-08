module srff_tb;
  reg clk,s,r;
  wire q,qbar;
  srff ff1(.q(q),.qbar(qbar),.s(s),.r(r),.clk(clk));
  initial clk=0;
  always #5 clk=~clk;
  initial 
  begin
    s=0;r=0;
    #5 s=0; r=1;
    #5 s=1; r=0;
    #5 s=1; r=1;
    #5 s=1; r=0;
    #5 s=0; r=1;
  end
  initial
  begin
    $monitor($time,"s=%b, r= %b, q=%b, qbar=%b",s,r,q,qbar);
    #50 $finish;
  end
endmodule
