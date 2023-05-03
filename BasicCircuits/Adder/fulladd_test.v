module fulladd_test;
  reg a,b,c;
  wire sum,carry;
  fulladder fa(.sum(sum),
               .carry(carry),
               .in1(a),
               .in2(b),
               .cin(c)
               );
  initial 
  begin
    {a,b,c}=000;
    #5 {a,b,c}=001;
    #5 {a,b,c}=010;
    #5 {a,b,c}=011;
    #5 {a,b,c}=100;
    #5 {a,b,c}=101;
    #5 {a,b,c}=110;
    #5 {a,b,c}=111;
  end
  initial
  begin
    $dumpfile("fulladd.vcd");
    $dumpvars(0,fulladd_test);
    $monitor($time," a=%b, b=%b, c=%b, sum=%b, carry=%b ",a,b,c,sum,carry);
  #100 $finish;
  end
endmodule
