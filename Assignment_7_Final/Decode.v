// module Decode(
//   input [5:0] opcode,func,
//   output reg [3:0] Opcode_ALU, Opcode_Branch,   //stores opcode for alu and branch 
//   output reg Opcode_Data,       //stores opcode for data
//   output reg [2:0]Mode_    // will detect what type or mode instruction (R, I type)
  
// );



// //Mode_Type is 0 for Jr and 1 for all R-type ALU and 2 for all I-type ALU 



// //  wire [5:0] opcode; // stores from 31 to 26 bits from 32 bits instruction(provided above)
// //  wire [5:0] func;   // stores from lower 5 to 0 bits from 32 bits instruction(provided above)
 
//   // assign opcode = Instruction[31:26];
//   // assign func=Instruction[5:0];

// //   always @(opcode or func) begin
// //     Mode_Type=3'b000;
// //     Opcode_Data=0;
// //    if(opcode==6'b000000) begin
// //      Mode_Type=3'b001;   // i.e, its a R-type      1--for R-type 
// //     case(func)
// //     //for Arithmetic(add, sub, addu, subu-----using main mips func code)
// //     6'b100000:Opcode_ALU = 4'b0000;   //add32    0
// //     6'b100010:Opcode_ALU = 4'b0001;   //sub34    1 
// //     6'b100001:Opcode_ALU = 4'b0010;   //addu33   2
// //     6'b100011:Opcode_ALU = 4'b0011;  //subu35    3
// //     //Now for logical(and, or, sll, srl-----using main mips func code) 
// //     6'b100100:Opcode_ALU = 4'b0110;  //and36   6   
// //     6'b100101:Opcode_ALU = 4'b0111;  //or37    7
// //     6'b000000:Opcode_ALU = 4'b1010; //sll0     10 
// //     6'b000010:Opcode_ALU = 4'b1011; //srl2     11
// //     // now for comparison(slt------using main mips func code)
// //     6'b101010:Opcode_ALU = 4'b1100;   //slt42     12
// //     // 6'b001000: begin Opcode_Branch=4'b0111; Mode_Type=3'b000; end   //jr
   
// //     endcase
// //    end
// //     //Top 3 down else if cases are for the unconditional branches
// //     else if(opcode==6'b000010)begin
// //       Opcode_Branch=4'b0110;    // this is for j2    6
// //     end

// //     else if(opcode==6'b001000)begin
// //       Mode_Type=3'b000;       //this is for jr8(Jump back to caller) operation    7
// //       Opcode_Branch=4'b0111;
// //     end
  
// //     else if(opcode==6'b000011)begin
// //       Opcode_Branch=4'b1000;    //this is for jal3 operation    8
// //     end

// //   else begin
// //     case(opcode)
    
// //       //for data and alu(using main mips func code)
// //       6'b001100:
// //       begin Opcode_ALU = 4'b1000;             //andi12      8
// //             Mode_Type=3'b010;   
// //       end       
// //       6'b001001:
// //       begin
// //         Opcode_ALU = 4'b0101;         //addiu9      5
// //         Mode_Type=3'b010;
// //       end
// //       6'b001010:
// //       begin 
// //         Opcode_ALU = 4'b1101;         //slti10      13
// //         Mode_Type=3'b010;
// //       end
// //       6'b001000:
// //       begin 
// //         Opcode_ALU = 4'b0100;         // addi8      4
// //         Mode_Type=3'b010; 
// //       end
// //       6'b100011:
// //       begin 
// //         Opcode_Data=1'b0;              //lw35       0
// //         Mode_Type=3'b100;
// //       end
// //       6'b101011:
// //       begin 
// //         Opcode_Data=1'b1;            //sw43         1
// //         Mode_Type=3'b011; 
// //       end 
// //       6'b001101:
// //       begin 
// //         Opcode_ALU = 4'b1001;         //ori13       9
// //         Mode_Type=3'b010;
// //       end
// //       //for ONLY conditional branch(using main mips func code)
// //       6'b000100: Opcode_Branch = 4'b0000;  //beq4           0
// //       6'b000101: Opcode_Branch = 4'b0001;  //bne5           1
// //       6'b000111: Opcode_Branch = 4'b0010;  //bgt7           2
// //       6'b011000: Opcode_Branch = 4'b0011;  //bgte24         3
// //       6'b011001: Opcode_Branch = 4'b0100;  //ble25          4
// //       6'b010101: Opcode_Branch = 4'b0101;  //bleq21         5

// // endcase
// // end
// // end
// // $display(" %d", Opcode_ALU);




//  always @(opcode or func) begin
//     Mode = 3'b000;
//     Opcode_Data = 0;
//     if(opcode == 6'b000000) begin
//       Mode=2'b01;
//       case(func)
//         6'b100000: Opcode_ALU = 4'b0000; //add
//         6'b100010: Opcode_ALU = 4'b0001; //sub
//         6'b100001: Opcode_ALU = 4'b0010; //addu
//         6'b100011: Opcode_ALU = 4'b0011; //subu
//         6'b100100: Opcode_ALU = 4'b0110; //and
//         6'b100010: Opcode_ALU = 4'b0111; //or
//         6'b000000: Opcode_ALU = 4'b1010; //sll
//         6'b000010: Opcode_ALU = 4'b1011; //srl
//         6'b101010: Opcode_ALU = 4'b1100; //slt
//         6'b001000: begin Opcode_Branch = 4'b0111; Mode=3'b000; end//jr
//       endcase
//     end

//     else if(opcode == 6'b000010)
//       Opcode_Branch = 4'b0110; //j

//     else if(opcode == 6'b000011)
//       Opcode_Branch= 4'b1000; //jal

//     // I type instructions
//     else begin
//       case(opcode)
//         6'b001000: begin Opcode_ALU = 4'b0100; Mode = 3'b010; end //addi
//         6'b001001: begin Opcode_ALU = 4'b0101; Mode = 3'b010; end //addiu
//         6'b001100: begin Opcode_ALU = 4'b1000; Mode = 3'b010; end  //andi
//         6'b001101: begin Opcode_ALU = 4'b1001; Mode = 3'b010; end  //ori
//         6'b100011: begin Opcode_Data = 1'b0; Mode = 3'b100; end  //lw
//         6'b101011: begin Opcode_Data = 1'b1; Mode = 3'b011; end //sw
//         6'b000100: Opcode_Branch = 4'b0000;  //beq
//         6'b000101: Opcode_Branch = 4'b0001;  //bne
//         6'b000111: Opcode_Branch = 4'b0010;  //bgt
//         6'b011000: Opcode_Branch = 4'b0011;  //bgte/bge
//         6'b011001: Opcode_Branch = 4'b0100;  //ble/blt
//         6'b010101: Opcode_Branch = 4'b0101;  //bleq
//         6'b001010: begin Opcode_ALU = 4'b1101; Mode = 3'b010; end//slti
//       endcase
//     end
//   end
// endmodule

module Decode(
  input [31:0] Instruction,
  output reg [3:0] Opcode_ALU, Opcode_Branch,
  output reg Opcode_Data,
  output reg[2:0] Mode
);
wire [5:0] opcode, func;
assign opcode= Instruction[31:26];
assign func= Instruction[5:0];

  always @(opcode or func) begin
    Mode = 3'b000;
    Opcode_Data = 0;
    if(opcode == 6'b000000) begin
      Mode=2'b01;
      case(func)
        6'b100000: Opcode_ALU = 4'b0000; //add
        6'b100010: Opcode_ALU = 4'b0001; //sub
        6'b100001: Opcode_ALU = 4'b0010; //addu
        6'b100011: Opcode_ALU = 4'b0011; //subu
        6'b100100: Opcode_ALU = 4'b0110; //and
        6'b100010: Opcode_ALU = 4'b0111; //or
        6'b000000: Opcode_ALU = 4'b1010; //sll
        6'b000010: Opcode_ALU = 4'b1011; //srl
        6'b101010: Opcode_ALU = 4'b1100; //slt
        6'b001000: begin Opcode_Branch = 4'b0111; Mode=3'b000; end//jr
      endcase
    end

    else if(opcode == 6'b000010)
      Opcode_Branch = 4'b0110; //j

    else if(opcode == 6'b000011)
      Opcode_Branch= 4'b1000; //jal

    // I type instructions
    else begin
      case(opcode)
        6'b001000: begin Opcode_ALU = 4'b0100; Mode = 3'b010; end //addi
        6'b001001: begin Opcode_ALU = 4'b0101; Mode = 3'b010; end //addiu
        6'b001100: begin Opcode_ALU = 4'b1000; Mode = 3'b010; end  //andi
        6'b001101: begin Opcode_ALU = 4'b1001; Mode = 3'b010; end  //ori
        6'b100011: begin Opcode_Data = 1'b0; Mode = 3'b100; end  //lw
        6'b101011: begin Opcode_Data = 1'b1; Mode = 3'b011; end //sw
        6'b000100: Opcode_Branch = 4'b0000;  //beq
        6'b000101: Opcode_Branch = 4'b0001;  //bne
        6'b000111: Opcode_Branch = 4'b0010;  //bgt
        6'b011000: Opcode_Branch = 4'b0011;  //bgte/bge
        6'b011001: Opcode_Branch = 4'b0100;  //ble/blt
        6'b010101: Opcode_Branch = 4'b0101;  //bleq
        6'b001010: begin Opcode_ALU = 4'b1101; Mode = 3'b010; end//slti
      endcase
    end
  end
  
endmodule