//This module contains testbench for alu design(alu.v).
module pipe_test;
  //Port declarations
  wire [15:0]z;
  reg [3:0]rs1,rs2,rd,func;
  reg clk1,clk2;
  reg [7:0]addr;
  integer k;

  //DUT Instantiation
  pipe_ex2 alu1(.Zout(z),
		.rs1(rs1),
		.rs2(rs2),
		.rd(rd),
		.func(func),
		.addr(addr),
		.clk1(clk1),
		.clk2(clk2));

  //Clock setup for testbench
  initial
  begin
    clk1=0;clk2=0;
    repeat(20)
    begin
      #5 clk1=1;#5 clk1=0;
      #5 clk2=1;#5 clk2=0;
    end
  end

  //Register bank instantiation
  initial
  for(k=0;k<16;k=k+1)
    alu1.regbank[k]=k;

  //Stimuli of testbench
  initial
  begin
    //Addition
    #5 rs1=3;rs2=5;rd=10;func=0;addr=125;
    //Multiplication
    #20 rs1=3;rs2=8;rd=12;func=2;addr=127;
    //Substraction
    #20 rs1=10;rs2=5;rd=14;func=1;addr=128;
    //shift left A
    #20 rs1=7;rs2=3;rd=13;func=11;addr=126;
    //Substraction
    #20 rs1=10;rs2=5;rd=15;func=1;addr=129;
    //Addition
    #20 rs1=12;rs2=13;rd=16;func=0;addr=130;

    #60 for(k=125;k<131;k=k+1)
          $display("Mem[%3d]=%3d",k,alu1.mem[k]);
  end

  //Vcd file generation
  initial
  begin
    $dumpfile("pipe2.vcd");
    $dumpvars(0,pipe_test);
    $monitor("At time ",$time, ": F=%3d",z);
    #300 $finish;
  end
endmodule
