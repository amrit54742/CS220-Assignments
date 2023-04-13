`include "Branch.v"
`include "ALU.v"
`include "Fetch.v"
`include "Decode.v"
`include "Store_Load.v"

module Main_Controller(
  input clk, reset
);
    reg [31:0] Register_Data [31:0]; // this my register memory to store the value of registers
  wire [31:0] Instruction; //32 bits instruction after performing fetching
  reg [9:0] PC;     //10 bits program counter (0 to 1023) 
  wire [9:0] Next_PC;       //will store our next instruction program counter 
  wire [9:0] ra;

    Instruction_Fetch I1(
    .clk(clk), 
    .reset(reset), 
    .PC(PC), 
    .Instruction(Instruction)
  );

  wire [3:0] Opcode_ALU;        // opcode for ALU operation
  wire [3:0] Opcode_Branch;     //opcode for Branching operations
  wire Opcode_Data;     //opcode for data (lw, sw)

  wire [31:0] Result, Dataout;
  wire [2:0] Mode_Type;


wire [5:0] Opcode;
wire [5:0] func;



assign Opcode= Instruction[31:25];
assign func= Instruction[5:0];

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
wire [31:0] Data1, Data2;
assign Data1= Register_Data[Instruction[25:21]];
assign Data2= Register_Data[Instruction[20:16]];


//Now lets check what opcode value we get from fetch and according to that we will either ALU, branch, Stor_Load 
// if opcode 0--alu

// if(Opcode==32 || Opcode==34 || Opcode==33 || Opcode==35 || Opcode==36 || Opcode==37 || Opcode==0 || Opcode==2 || Opcode==42 || Opcode==8 || Opcode==9 || Opcode==12 || Opcode==13 ||Opcode==10)begin
//   ALU I3(
//     .Data1(Register[Instruction[25:21]]), 
//     .Data2(Register[Instruction[20:16]]), 
//     .Immediate_Branch(Instruction[15:0]),
//     .Opcode_ALU(Opcode_ALU), 
//     .Result(Result)
//   );
// end
// else if(Opcode==2 || Opcode==8 || Opcode==3 || Opcode==4 || Opcode==5 || Opcode==7 || Opcode==24 || Opcode==25 || Opcode==21)begin
//   Branching I4(
//     .Data1(Register[Instruction[25:21]]),
//     .Data2(Register[Instruction[20:16]]),
//     .Instruction(Instruction), 
//     .PC(PC), 
//     .Opcode_Branch(Opcode_Branch), 
//     .Next_PC(Next_PC), 
//     .ra(ra)
//   );
// end
// else if(Opcode==2 || Opcode==2)


  ALU I3(
    .Data1(Data1), 
    .Data2(Data2), 
    .Instruction(Instruction),
    .Opcode_ALU(Opcode_ALU), 
    .Result(Result)
  );

  Branching I4(
    .Data1(Data1),
    .Data2(Data2),
    .Instruction(Instruction), 
    .PC(PC), 
    .Opcode_Branch(Opcode_Branch), 
    .Next_PC(Next_PC), 
    .ra(ra)
  );
  wire [15:0] Offset;
  assign Offset= Instruction[15:0];

  Store_Load I5( 
    .reset(reset), 
    .PC(PC),
    .Data_Value(Data2), 
    .Address(Data1),
    .Instruction(Instruction),
    .Opcode_Data(Opcode_Data),
    .Dataout(Dataout)
  );

  initial begin
    Register_Data[0]=32'd0;
    PC=9'd0;
  end


  always @(negedge clk) begin
    if(Mode_Type==3'b000)begin
      PC = Next_PC + 1;                       // this is for Jr
    end

    else if(Mode_Type==3'b001)begin
      PC = PC + 1;
      Register_Data[Instruction[15:11]] = Result;    // this is for  R-type
    end

    else if(Mode_Type==3'b010)begin
      PC = PC + 1;                              // this is for I-type
      Register_Data[Instruction[20:16]] = Result;
    end

    else if(Mode_Type==3'b011)begin
      PC = PC + 1;                               // this is for sw (store)
    end

    else if(Mode_Type==3'b100)begin
      PC = PC + 1;
      Register_Data[Instruction[20:16]] = Dataout;         // this is for lw (load)
    end
    // $display("Below are values of register and PC");
    $display("Register_Data[%d] value is: %d -- Register_Data[%d] value is: %d -- Register_Data[%d] value is: %d -- Current_PC value is: %d", Instruction[25:21], Register_Data[Instruction[25:21]], Instruction[20:16], Register_Data[Instruction[20:16]], Instruction[15:11], Register_Data[Instruction[15:11]],PC);
    // $display("Datamemory %d",Data_Memory[3]);
  end
endmodule