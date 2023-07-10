//This module contains behavioral description verilog code
//for 5-stage pipelined MIPS32 RISC processor. 1-Bit regis-
//ster is used to halt processor(HALTD). 1-Bit register is
//used to evaluate branch conditions(TAKEN_BRANCH) and pre-
//vent any state changes.

module pipe_mips32(clk1,clk2);
  //Port declartion for module. Two-phased clock
  input clk1,clk2;

  //Registers for each stage  in pipeline process
  reg [31:0]PC,IF_ID_IR,IF_ID_NPC;
  reg [31:0]ID_EX_IR,ID_EX_NPC,ID_EX_A,ID_EX_B,ID_EX_Mem;
  reg [2:0]ID_EX_Type,EX_Mem_Type,Mem_WB_Type;
  reg [31:0]EX_Mem_IR,EX_Mem_ALUOut,EX_Mem_B;
  reg       EX_Mem_cond;
  reg [31:0]Mem_WB_IR,Mem_WB_ALUOut,Mem_WB_LMD;

  //Register bank(32x32) and 1024x32 memory
  reg [31:0]Reg[0:31];
  reg [31:0]Mem[0:1023];

  //ALU Instructions as parameters
  parameter ADD=6'b000000,SUB=6'b000001,AND=6'b000010,
            OR=6'b000011,SLT=6'b000100,MUL=6'b000101,
            HLT=6'b111111,LW=6'b001000,SW=6'b001001,
            ADDI=6'b001010,SUBI=6'b001011,SLTI=6'b001100,
            BNEQZ=6'b001101,BEQZ=6'b001110;
  //Special instructions as parameters
  parameter RR_ALU=3'b000,RM_ALU=3'b001,LOAD=3'b001,
            STORE=3'b011,BRANCH=3'b100,HALT=3'b101;

  //1-Bit flag for halting instructions
  reg HALTED;

  //1-Bit flag for branch instructions
  reg TAKEN_BRANCH;

  //Instruction Fetch Stage
  always@(posedge clk1)
  if(HALTED==0)
  begin
    if(((EX_Mem_IR[31:26]==BEQZ) && (EX_Mem_cond==1)) ||
        ((EX_Mem_IR[31:26]==BNEQZ) && (EX_Mem_cond==0)))
    begin
      IF_ID_IR <= #2 Mem[EX_Mem_ALUOut];
      TAKEN_BRANCH <= #2 1'b1;
      IF_ID_NPC <= #2 EX_Mem_ALUOut+1;
      PC <= #2 EX_Mem_ALUOut+1;
    end
    else
    begin
      IF_ID_IR <= #2 Mem[PC];
      IF_ID_NPC <= #2 PC+1;
      PC <= #2 PC+1;
    end
  end

  //Instruction Decode stage
  always@(posedge clk2)
  if(HALTED==0)
  begin
    //rs value from instruction
    if(IF_ID_IR[25:21]==5'b00000)
      ID_EX_A <= 0;
    else
      ID_EX_A <= #2 Reg[IF_ID_IR[25:21]];

    //rt value from instruction
    if(IF_ID_IR[20:16]==5'b00000)
      ID_EX_B <=0;
    else
      ID_EX_B <= #2 Reg[IF_ID_IR[20:16]];

    //forwarding remaining instructions
    ID_EX_NPC <= #2 IF_ID_NPC;
    ID_EX_IR <= #2 IF_ID_IR;
    ID_EX_Mem <= #2 {{16{IF_ID_IR[15]}},{IF_ID_IR[15:0]}};

    //Setting the execution command type
    case(IF_ID_IR[31:26])
      ADD,SUB,AND,OR,SLT,MUL: ID_EX_Type <= #2 RR_ALU;
      ADDI,SUBI,SLTI:         ID_EX_Type <= #2 RM_ALU;
      LW:                     ID_EX_Type <= #2 LOAD;
      SW:                     ID_EX_Type <= #2 STORE;
      BNEQZ,BEQZ:             ID_EX_Type <= #2 BRANCH;
      HLT:                    ID_EX_Type <= #2 HALT;
      default:                ID_EX_Type <= #2 HALT;
    endcase
  end

  //Execution stage
  always@(posedge clk1)
  if(HALTED==0)
  begin
    EX_Mem_Type <= #2 ID_EX_Type;
    EX_Mem_IR <= #2 ID_EX_IR;
    TAKEN_BRANCH <= #2 0;

    case(ID_EX_Type)
      //Register to Register type of instruction
      RR_ALU: begin
                case(ID_EX_IR[31:26])
                  ADD: EX_Mem_ALUOut <= #2 ID_EX_A + ID_EX_B;
                  SUB: EX_Mem_ALUOut <= #2 ID_EX_A - ID_EX_B;
                  MUL: EX_Mem_ALUOut <= #2 ID_EX_A * ID_EX_B;
                  AND: EX_Mem_ALUOut <= #2 ID_EX_A & ID_EX_B;
                  OR:  EX_Mem_ALUOut <= #2 ID_EX_A | ID_EX_B;
                  SLT: EX_Mem_ALUOut <= #2 ID_EX_A < ID_EX_B;
                  default: EX_Mem_ALUOut <= #2 32'hxxxxxxxx;
                endcase
              end

      //Register to Memory type of instruction
      RM_ALU: begin
                case(ID_EX_IR[31:26])
                  ADDI: EX_Mem_ALUOut <= #2 ID_EX_A + ID_EX_Mem;
                  SUBI: EX_Mem_ALUOut <= #2 ID_EX_A - ID_EX_Mem;
                  SLTI: EX_Mem_ALUOut <= #2 ID_EX_A < ID_EX_Mem;
                  default: EX_Mem_ALUOut <= #2 32'hxxxxxxxx;
                endcase
              end

      LOAD,STORE:
              begin
                EX_Mem_ALUOut <= #2 ID_EX_A + ID_EX_Mem;
                EX_Mem_B <= #2 ID_EX_B;
              end

      BRANCH: begin
                EX_Mem_ALUOut <= #2 ID_EX_NPC + ID_EX_Mem;
                EX_Mem_cond <= #2 (ID_EX_A==0);
              end
    endcase
  end  

  //Memory Access stage
  always@(posedge clk2)
  if(HALTED==0)
  begin
    Mem_WB_Type <= #2 EX_Mem_Type;
    Mem_WB_IR <= #2 EX_Mem_IR;

    //Memory access based on type of instruction
    case(EX_Mem_Type)
      RR_ALU,RM_ALU: Mem_WB_ALUOut <= #2 EX_Mem_ALUOut;
      LOAD: Mem_WB_ALUOut <= #2 Mem[EX_Mem_ALUOut];
      STORE: if(TAKEN_BRANCH==0)
               Mem[EX_Mem_ALUOut] <= #2 EX_Mem_B;
    endcase
  end

  //Write Back stage
  always@(posedge clk1)
  begin
    if(TAKEN_BRANCH==0)
    case(Mem_WB_Type)
      RR_ALU: Reg[Mem_WB_IR[15:11]] <= #2 Mem_WB_ALUOut;
      RM_ALU: Reg[Mem_WB_IR[20:16]] <= #2 Mem_WB_ALUOut;
      LOAD: Reg[Mem_WB_IR[20:16]] <= #2 Mem_WB_LMD;
      HALT: HALTED <= #2 1'b1;
    endcase
  end
endmodule
