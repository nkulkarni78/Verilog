module fa(sum,cout,a,b,c);
  input a,b,c;
  output sum,cout;
  wire s1,c1,c2;
  
  xor(s1,a,b);
  xor(sum,s1,c);
  and(c1,a,b);
  and(c2,c,s1);
  or(cout,c1,c2);
endmodule
