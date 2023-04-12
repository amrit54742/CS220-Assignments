module Store_Load(
  input  reset,
  input [9:0] PC, 
  input [31:0] Data_Value,
  input [31:0] Address,
  input [15:0] Offset,
  input Opcode_Data,
  output reg [31:0] Dataout
);

  // wire [15:0] Offset;
  // assign Offset= Instruction[15:0];

// wire [31:0] Data1, Data2;
// assign Data1= Register[Instruction[25:21]];
// assign Data2= Register[Instruction[20:16]];

  reg [31:0] Data_Memory [0:1023];

	integer i;
	initial begin
		for (i=0; i < 1024; i++) begin
      Data_Memory[i] = 0;
		end
    Data_Memory[0] = 32'd10;
    Data_Memory[1] = 32'd5;
    Data_Memory[2] = 32'd2;
    Data_Memory[3] = 32'd7;
    Data_Memory[4] = 32'd11;
    Data_Memory[5] = 32'd9;
    Data_Memory[6] = 32'd4;
    Data_Memory[7] = 32'd15;
    Data_Memory[8] = 32'd0;
    Data_Memory[9] = 32'd12;
    Data_Memory[10] = 32'd3;
	end


	always @(reset or Data_Value or Address or Offset or Opcode_Data) begin
    if (reset == 1) begin
      for (i = 0; i < 1024; i = i + 1)
        Data_Memory[i] = 0;
    end
    else begin
      if (Opcode_Data) begin
        Data_Memory[Address[9:0] + Offset[9:0]] = Data_Value;
        $display("Data_Memory[%d] %d", Address[9:0] + Offset[9:0], Data_Memory[Address[9:0] + Offset[9:0]] );
      end
      else if (Opcode_Data == 1'b0) begin
        Dataout = Data_Memory[Address[9:0] + Offset[9:0]];
      end
	  end

    if(PC == 32'd24) begin
      for(i=1; i<=Data_Memory[0]; i++) begin
        $display("Data_Memory[%d] %d", i, Data_Memory[i]);
      end
    end
  end

endmodule