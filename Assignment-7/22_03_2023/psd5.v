module instruction_decode(
  input [31:0] instruction,
  output reg [2:0] ALUOp,    //for arithmetic
  output reg [2:0] LogOp,   //for logical
  output reg DatOp,   //for data transfer 
  output reg [2:0] ConOp,   //for conditional branch 
  output reg [1:0]UnconOp,    //for unconditional branch
  output reg CompOp     //for comparison
);

 wire [5:0] opcode; // stores from 31 to 26 bits from 32 bits instruction(provided above)
 wire [5:0] func;   // stores from lower 5 to 0 bits from 32 bits instruction(provided above)
 
  assign opcode = instruction[31:26];
  assign func=instruction[5:0];

  always @(*) begin

   if(opcode==6'b000000) begin
   case(func)
   //for Arithmetic(using main mips func code)
   6'b100000:ALUOp = 3'b000;   //add32
   6'b100010:ALUOp = 3'b001;   //sub34
   6'b100001:ALUOp = 3'b010;   //addu33
   6'b100011:ALUOp = 3'b011;  //subu35
   6'b001000:ALUOp = 3'b100;  // addi8
   6'b001001:ALUOp = 3'b110;  //addiu9
   //Now for logical(using main mips func code) 
   6'b100100:LogOp = 3'b000;  //and36
   6'b100101:LogOp = 3'b001;  //or37
   6'b001100:LogOp = 3'b010; //andi12
   6'b001101:LogOp = 3'b011; //ori13
   6'b000000:LogOp = 3'b100; //sll0
   6'b000010:LogOp = 3'b101; //srl2
   // now for comparison(using main mips func code)

   6'b101010:CompOp = 1'b0;   //slt42
   6'b001010:CompOp = 1'b1;   //slti10
   
   endcase
   end

   else begin
case(opcode)
//for unconditional branch(using main mips func code)
6'b000010: UnconOp = 2'b00; //j2
6'b001000: UnconOp = 2'b01;  //jr8
6'b000011: UnconOp = 2'b10; //jal3
//for data transfer(using main mips func code)
6'b100011: DatOp=1'b0;   //lw35
6'b101011: DatOp=1'b1;   //sw43

//for conditional branch(using main mips func code)
6'b000100: ConOp = 3'b000;  //beq4
6'b000101: ConOp = 3'b001;  //bne5
6'b000111: ConOp = 3'b010;  //bgt7
6'b011000: ConOp = 3'b011;  //bgte24
6'b011001: ConOp = 3'b100;  //ble25
6'b010101: ConOp = 3'b101;  //bleq21
endcase
end
end
endmodule