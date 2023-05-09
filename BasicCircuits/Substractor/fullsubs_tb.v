module fullsubs_tb;
  reg a,b,c;
  wire s,cout;
  fullsub fs(.diff(s),.borrow(cout),.a(a),.b(b),.cin(c));
  initial begin
    a=1'b0;
    b=1'b0;
    c=1'b0;
    
    #5 {a,b,c}={1'b1,1'b1,1'b1};
    #5 {a,b,c}={1'b0,1'b0,1'b1};
    #5 {a,b,c}={1'b0,1'b1,1'b0};
    #5 {a,b,c}={1'b0,1'b1,1'b1};
    #5 {a,b,c}={1'b1,1'b0,1'b0};
    #5 {a,b,c}={1'b1,1'b0,1'b1};
    #5 {a,b,c}={1'b1,1'b1,1'b0};
    #5 {a,b,c}={1'b1,1'b1,1'b1};
  end
  initial begin
    $dumpfile("fullsubs.vcd");
    $dumpvars(0,fullsubs_tb);
    $monitor($time," a=%b, b=%b, c=%b, difference=%b, borrow=%b ",a,b,c,s,cout);
  end
  initial
  #100 $finish;
endmodule
