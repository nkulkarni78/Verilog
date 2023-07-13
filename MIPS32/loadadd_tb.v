//This example testbench loads words stored in memory loca-
//tion 120, adds 45 to it and stores result in memory loca-
//tion 121. We use R1 to initialize to memory location 121.
//Assembly language program is as below:
//#########################################################
//ADDI R1,R0,120
//LW R2,0(R1)
//ADDI R2,R2,45
//SW R2,1(R1)
//HTL
//#########################################################

module loadtest_tb;
  reg clk1,clk2;
  integer k;

  pipe_mips32 load(.clk1(clk1),.clk2(clk2));

  //procedure block to instantiate clocks
  initial
  begin
    clk1=0;clk2=0;
    repeat(50)
    begin
      #5 clk1=1; #5 clk1=0;
      #5 clk2=1; #5 clk2=0;
    end
  end

  //Stimulus for given program as machine code
  initial
  begin
    for(k=0;k<31;k=k+1)
      load.Reg[k]=k;

    //ADDI R1,R0,120
    load.Mem[0]=32'h28010078;
    //Dummy instruction to process pipeline
    load.Mem[1]=32'h0c631800;
    //LW R2,0(R1)
    load.Mem[2]=32'h20220000;
    //Dummy instruction to process pipeline
    load.Mem[3]=32'h0c631800;
    //ADDI R2,R2,45
    load.Mem[4]=32'h2842002d;
    //Dummy instruction to process pipeline
    load.Mem[5]=32'h0c631800;
    //SW R2,1(R1)
    load.Mem[6]=32'h24220001;
    //HLT
    load.Mem[7]=32'hfc000000;

    //Initializing 120th memory location
    load.Mem[120]=85;

    //Initializing program counter and other flags
    load.PC=0;
    load.HALTED=0;
    load.TAKEN_BRANCH=0;

    #500 $display("Mem[120]: %4d\nMem[121]: %4d",
                   load.Mem[120],load.Mem[121]);
  end

  initial
  begin
    $dumpfile("LoadandAdd.vcd");
    $dumpvars(0,loadtest_tb);
    #600 $finish;
  end
endmodule
