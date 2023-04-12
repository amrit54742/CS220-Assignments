`include "branch_operation.v"
`include "ALU.v"
`include "instruction_fetch.v"
`include "Decode.v"
`include "Store_Load.v"

module Main_Controller(
  input clk, reset
);
    reg [31:0] Register [31:0]; // this my register memory to store the value of registers
  wire [31:0] Instruction; //32 bits instruction after performing fetching
  reg [9:0] PC;     //10 bits program counter (0 to 1023) 
  wire [9:0] Next_PC, ra;       //will store our next instruction program counter 
  



  wire [3:0] Opcode_ALU;        // opcode for ALU operation
  wire [3:0] Opcode_Branch;     //opcode for Branching operations
  wire Opcode_Data;     //opcode for data (lw, sw)

  wire [31:0] Result, Dataout;
  wire [2:0] Mode_Type;

//   instruction_fetch IF(
//     .clk(clk), 
//     .rst(rst), 
//     .pc(pc), 
//     .instruction(instruction)
//   );
    Instruction_Fetch I1(
    .clk(clk), 
    .reset(reset), 
    .PC(PC), 
    .Instruction(Instruction)
  );


  Decode I2(
    .Instruction(Instruction), 
    .Opcode_ALU(Opcode_ALU), 
    .Opcode_Branch(Opcode_Branch), 
    .Opcode_Data(Opcode_Data),
    .Mode(Mode_Type)
  );
// always@(*)begin
//   $display("%d ---- %d ---- %d ----",Opcode_ALU, Opcode_Branch, Opcode_Data);
// end
// wire [31:0] Data1, Data2;
// assign Data1= Register[Instruction[25:21]];
// assign Data2= Register[Instruction[20:16]];



  ALU I3(
    .Data1(Register[Instruction[25:21]]), 
    .Data2(Register[Instruction[20:16]]), 
    .Immediate_Branch(Instruction[15:0]),
    .Opcode_ALU(Opcode_ALU), 
    .Result(Result)
  );

  Branching I4(
    .Data1(Register[Instruction[25:21]]),
    .Data2(Register[Instruction[20:16]]),
    .Immediate_Jump(Instruction[25:0]), 
    .PC(PC), 
    .Opcode_Branch(Opcode_Branch), 
    .Next_PC(Next_PC), 
    .ra(ra)
  );
//   wire [15:0] Offset;
//   assign Offset= Instruction[15:0];

  Store_Load I5( 
    .reset(reset), 
    .PC(PC),
    .Data_Value(Register[Instruction[20:16]]), 
    .Address(Register[Instruction[25:21]]),
    .Offset(Instruction[15:0]),
    .Opcode_Data(Opcode_Data),
    .Dataout(Dataout)
  );

  initial begin
    Register[0]=32'd0;
    PC=9'd0;
  end

  always @(negedge clk) begin
    case(Mode_Type)
      3'b000: begin
        PC = Next_PC + 1;
      end
      3'b001: begin
        PC = PC + 1;
        Register[Instruction[15:11]] = Result;
      end
      3'b010: begin
        PC = PC + 1;
        Register[Instruction[20:16]] = Result;
      end
      3'b011: begin
        PC = PC + 1;
      end
      3'b100: begin
        PC = PC + 1;
        Register[Instruction[20:16]] = Dataout;
      end
    endcase
    $display("Register[%d]: %d Register[%d]: %d Register[%d]: %d Instruction %d PC: %d", Instruction[25:21], Register[Instruction[25:21]], Instruction[20:16], Register[Instruction[20:16]], Instruction[15:11], Register[Instruction[15:11]], Instruction,PC);
  end
endmodule