//This module contains behavioral description verilog code
//for 4-stage pipelined design of an alu with memory & reg
//banks.
module pipe_ex2(Zout,rs1,rs2,rd,func,addr,clk1,clk2);
  //Port declartion for module
  input [3:0] rs1,rs2,rd,func;
  input [7:0]addr;
  input clk1,clk2;
  output [15:0]Zout;

  //Intermediate registers in pipeline  
  reg [15:0]l12a,l12b,l23z,l34z;
  reg [3:0]l12rd,l23rd,l12func;
  reg [7:0]l12addr,l23addr,l34addr;

  //registers for Register bank
  reg [15:0] regbank[0:15];

  //256x16 memory
  reg [15:0] mem[0:255];

  assign Zout = l34z;

  //Stage 1 of pipeline using clock 1
  always@(posedge clk1)
  begin
    l12a <= #2 regbank[rs1];
    l12b <= #2 regbank[rs2];
    l12rd <= #2 rd;
    l12func <= #2 func;
    l12addr <= #2 addr;
  end

  //Stage 2 of pipeline using clock 2
  always@(negedge clk2)
  begin
    case(func)
      0:l23z <= #2 l12a+l12b;
      1:l23z <= #2 l12a-l12b;
      2:l23z <= #2 l12a*l12b;
      3:l23z <= #2 l12a;
      4:l23z <= #2 l12b;
      5:l23z <= #2 l12a&l12b;
      6:l23z <= #2 l12a|l12b;
      7:l23z <= #2 l12a^l12b;
      8:l23z <= #2 ~l12a;
      9:l23z <= #2 ~l12b;
     10:l23z <= #2 l12a>>1;
     11:l23z <= #2 l12a<<1;
     default:l23z <= #2 16'hxxxx;
    endcase
    l23rd <= #2 l12rd;
    l23addr <= #2 l12addr;
  end

  //Stage 3 of pipeline using clock 1
  always@(posedge clk1)
  begin
    regbank[l23rd] <= #2 l23z;
    l34z <= #2 l23z;
    l34addr <= #2 l23addr;
  end

  //Stage 4 of pipeline using clock 2
  always@(negedge clk2)
  begin
    mem[l34addr] <= #2 l34z;
  end
endmodule
