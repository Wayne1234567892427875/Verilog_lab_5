
`timescale 1ns / 1ps

`define halfT 20

module TB_AP4_pip;

reg rst, clk;
reg [3:0] A, B, C, D;
wire [7:0] AB;
wire [11:0] ABC; 
wire [15:0] ABCD, EndBuf;

wire [4:0] ROM_Addr;
wire [18:0] RomData;

reg [2:0] OP_code;

AP4_pip_a U_test(.clk(clk), .rst(rst), .A(A), .B(B), .C(C), .D(D), .AB(AB), .ABC(ABC), .ABCD(ABCD), 
                 .EndBuf(EndBuf), .OpCode(OP_code));

ProgCounter PC(.rst(rst), .clk(clk), .CounterOut(ROM_Addr));
ProgROM     ROM(.Addr(ROM_Addr), .DataOut(RomData));

always @(*)begin
    OP_code = RomData[18:16];
    A = RomData[15:12];
    B = RomData[11:8];
    C = RomData[7:4];
    D = RomData[3:0];
end

always begin
# `halfT
clk=~clk;
end

initial begin
    rst= 1'b0;
	clk= 1'b0;

	#`halfT
	#`halfT
	#`halfT  rst=1'b1;
	#`halfT
	#`halfT
	#`halfT  rst=1'b0;
	#`halfT
	#`halfT
	#`halfT
	#`halfT
	#`halfT
	#`halfT
	#`halfT
	#`halfT  
	#`halfT
	#`halfT  
	#`halfT
	#`halfT  
	#`halfT
	#`halfT
	#`halfT
	#`halfT
	#`halfT
	#`halfT  
	#`halfT
	#`halfT  
	#`halfT
	#`halfT  
	#`halfT
	#`halfT
	#`halfT
	#`halfT  $stop;
end
endmodule


module ProgCounter(rst, clk, CounterOut);
input rst, clk;
output reg [4:0] CounterOut;
always @(posedge clk)begin
    if(rst == 1'b1) begin
        CounterOut <= 5'b11111;
    end
    else begin
        CounterOut <= CounterOut +1'b1;
    end    
end
endmodule

module ProgROM(Addr, DataOut);
input [4:0] Addr;
output reg [18:0] DataOut;
always @(*)begin
    case ( Addr )
		5'b11100: DataOut = #1 19'b000_0000_0000_0000_0000;
        5'b11101: DataOut = #1 19'b000_0000_0000_0000_0000;
        5'b11110: DataOut = #1 19'b000_0000_0000_0000_0000;
        5'b11111: DataOut = #1 19'b000_0000_0000_0000_0000;	
        5'b00000: DataOut = #1 19'b000_0000_0001_0011_0101;
        5'b00001: DataOut = #1 19'b000_0001_0011_0101_0011;
        5'b00010: DataOut = #1 19'b000_0011_0101_0011_0000;
        5'b00011: DataOut = #1 19'b000_0101_0011_0000_0010;
		5'b00100: DataOut = #1 19'b000_0011_0000_0010_0001;
        default: DataOut = 19'bxxx_xxxx_xxxx_xxxx_xxxx;
    endcase
end
endmodule
