module fullsub(diff,borrow,a,b,cin);
  input a,b,cin;
  output reg diff,borrow;
  always@(a or b or cin)
    {borrow,diff} = a-b-cin;
endmodule
