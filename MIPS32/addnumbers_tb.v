//This testbench adds three numbers from r1,r2,r3 registers
//and stores them in r4 register. The assembly language pr-
//ogram is as below which is then converted to machine lan-
//gugage code in our test bench.
//Assembly laguage program
//#########################################################
//ADDI R1,R0,10
//ADDI R2,R0,20
//ADDI R3,R0,25
//ADD R4,R1,R2
//ADD R5,R4,R3
//HLT
//#########################################################

module addertest_mips32;
  reg clk1,clk2;
  integer k;
  pipe_mips32 add(.clk1(clk1),.clk2(clk2));

  //Procedural block to instantiate clocks;
  initial
  begin
    clk1=0;clk2=0;
    repeat(20)
    begin
      #5 clk1=1;#5 clk1=0;
      #5 clk2=1;#5 clk2=0;
    end
  end

  //Machine code for above assembly language
  initial
  begin
    add.HALTED=0;
    add.PC=0;
    add.TAKEN_BRANCH=0;

    for(k=0;k<31;k=k+1)
      add.Reg[k]=k;
    //ADDI R1,R0,10
    add.Mem[0]=32'h2801000a;
    //ADDI R2,R0,20
    add.Mem[1]=32'h28020014;
    //ADDI R3,R0,25
    add.Mem[2]=32'h28030019;
    //dummy OR instruction for pipeline to advance
    add.Mem[3]=32'h0ce77800;
    //dummy OR instruction for pipeline to advance
    add.Mem[4]=32'h0ce77800;
    //ADD R4,R1,R2
    add.Mem[5]=32'h00222000;
    //dummy OR instruction for pipeline to advance
    add.Mem[6]=32'h0ce77800;
    //ADD R5,R4,R3;
    add.Mem[7]=32'h00832800;
    //HLT
    add.Mem[8]=32'hfc000000;

    $display("PC=%d",add.PC);
    #700
    for(k=0;k<6;k=k+1)
      $display("R%1d - %2d",k,add.Reg[k]);    
  end

  //vcd file generation
  initial
  begin
    $dumpfile("adder.vcd");
    $dumpvars(0,addertest_mips32);
    #1000 $finish;
  end
endmodule
