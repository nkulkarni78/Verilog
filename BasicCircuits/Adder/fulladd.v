module fulladder(sum,carry,in1,in2,cin);
  input in1,in2,cin;
  output reg sum,carry;
  always@(in1 or in2 or cin)
  begin
    sum = in1^in2^cin;
    carry = (in1&in2)|(in2&cin)|(cin&in1);
  end
endmodule
