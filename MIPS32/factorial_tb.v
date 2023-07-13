//This testbench computes factorial of given number  in 200
//memory location and stores result in 198 memory location.
//Testbench illustrates branch instruction function and how
//negative numbers are stored in registers of processor.2's
//complement form is used to store negative numbers.
//Assembly language code for given test bench is as below:
//#########################################################
//ADDI R10,R0,200
//ADDI R2,R0,1
//LW R3,0(R10)
//Loop: MUL R2,R2,R3
//SUBI R3,R3,1
//BNEQZ R3,Loop
//SW R2, -2(R10)
//HLT
//#########################################################

module facttest_tb;
  reg clk1,clk2;
  integer k;

  pipe_mips32 fact(.clk1(clk1),.clk2(clk2));

  //procedural block to initialize clocks
  initial
  begin
    clk1=0;clk2=0;
    repeat(50)
    begin
      #5 clk1=1; #5 clk1=0;
      #5 clk2=1; #5 clk2=0; 
    end
  end

  //Stimuli for given assembly code
  initial
  begin
    for(k=0;k<31;k=k+1)
      fact.Reg[k]=k;

    //ADDI R10,R0,200
    fact.Mem[0]=32'h280a00c8;
    //ADDI R2,R0,1
    fact.Mem[1]=32'h28020001;
    //Dummy instruction to process pipeline
    fact.Mem[2]=32'h0e94a000;
    //LW R3,0(R10)
    fact.Mem[3]=32'h21430000;
    //Dummy instruction to process pipeline
    fact.Mem[4]=32'h0e94a000;
    //Loop: MUL R2,R2,R3
    fact.Mem[5]=32'h14431000;
    //SUBI R3,R3,1
    fact.Mem[6]=32'h2c630001;
    //Dummy instruction to process pipeline
    fact.Mem[7]=32'h0e94a000;
    //BNEQZ R3,Loop
    fact.Mem[8]=32'h3460fffc;
    //SW R2, -2(R10)
    fact.Mem[9]=32'h2542fffe;
    //HLT
    fact.Mem[10]=32'hfc000000;

   //Initializing 200th memory location
   fact.Mem[200]=7;

    //Initializing program counter and flags
    fact.PC=0;
    fact.TAKEN_BRANCH=0;
    fact.HALTED=0;

    #2000 $display("Mem[200]: %2d, Mem[198]: %6d",
                    fact.Mem[200],fact.Mem[198]);
  end

  initial
  begin
    $dumpfile("Factorial.vcd");
    $dumpvars(0,facttest_tb);
    $monitor("R2: %4d",fact.Reg[2]);
    #3000 $finish;
  end
endmodule
