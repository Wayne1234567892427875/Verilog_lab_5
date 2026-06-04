
`timescale 1ns / 1ps

module AP4_pip_a(clk, rst, A, B, C, D, AB, ABC, ABCD, EndBuf, OpCode); 
input clk, rst;
input [3:0] A, B, C, D;

output [7:0] AB;
output [11:0] ABC;
output [15:0] ABCD;

output [15:0] EndBuf;

input [2:0] OpCode;

reg [3:0] Ai1, Bi1, Ci1, Di1;
wire [3:0] Ci2, Di2, Di3;

reg [2:0] OPi1;
wire [2:0] OPi2, OPi3;

// input stage
always @(*) begin
	Ai1 = A;
	Bi1 = B;
	Ci1 = C;
	Di1 = D;
	OPi1 = OpCode;
end

// 1st stage
Stage1_AP4 PipSg1(.clk(clk), .rst(rst), 
                  .Ai1(Ai1), .Bi1(Bi1), .Ci1(Ci1), .Di1(Di1), .OPi1(OPi1), 
                  .AB(AB), .Ci2(Ci2), .Di2(Di2), .OPi2(OPi2));

// 2nd stage
Stage2_AP4 PipSg2(.clk(clk), .rst(rst), 
                  .AB(AB), .Ci2(Ci2), .Di2(Di2), .OPi2(OPi2), 
                  .ABC(ABC), .Di3(Di3), .OPi3(OPi3));

// 3rd stage
Stage3_AP4 PipSg3(.clk(clk), .rst(rst), 
                  .ABC(ABC), .Di3(Di3), .OPi3(OPi3), .ABCD(ABCD));

// output stage
assign EndBuf = ABCD;

endmodule


module Stage1_AP4(clk, rst, Ai1, Bi1, Ci1, Di1, OPi1, AB, Ci2, Di2, OPi2);
input clk, rst;
input [3:0] Ai1, Bi1, Ci1, Di1; 
input [2:0] OPi1;
output reg [7:0] AB;
output reg [3:0] Ci2, Di2;
output reg [2:0] OPi2;


always @(posedge clk) begin 
    if( (rst == 1'b1)) begin
		Ci2 <= 4'h0;
		Di2 <= 4'h0;
	end
	else begin
		Ci2 <= Ci1;
		Di2 <= Di1;
	end
end

always @(posedge clk) begin 
    if( (rst == 1'b1)) begin
	    AB <= 8'h00;
	end
	else begin
		if (OPi1[2] == 1'b1) begin 
		    AB <= Ai1*Bi1;
		end
		else begin
		    AB <= Ai1+Bi1;
		end
	end
end

always @(posedge clk) begin 
    if( (rst == 1'b1)) begin
		OPi2 <= 3'b000;
	end
	else begin
		OPi2 <= OPi1;
	end
end

endmodule


module Stage2_AP4(clk, rst, AB, Ci2, Di2, OPi2, ABC, Di3, OPi3);
input clk, rst;
input [7:0] AB;
input [3:0] Ci2, Di2; 
input [2:0] OPi2;
output reg [11:0] ABC;
output reg [3:0] Di3;
output reg [2:0] OPi3;


always @(posedge clk) begin 
    if( (rst == 1'b1)) begin
		Di3 <= 4'h0;
	end
	else begin
		Di3 <= Di2;
	end
end

always @(posedge clk) begin 
    if( (rst == 1'b1)) begin
	    ABC <= 12'h000;
	end
	else begin
		if (OPi2[1] == 1'b1) begin 
		    ABC <= AB*Ci2;
		end
		else begin
		    ABC <= AB+Ci2;
		end
	end
end

always @(posedge clk) begin 
    if( (rst == 1'b1)) begin
		OPi3 <= 3'b000;
	end
	else begin
		//OPi1 <= 3'b000;
		OPi3 <= OPi2;
	end
end

endmodule

module Stage3_AP4(clk, rst, ABC, Di3, OPi3, ABCD);
input clk, rst;
input [11:0] ABC;
input [3:0] Di3; 
input [2:0] OPi3;
output reg [15:0] ABCD;

always @(posedge clk) begin 
    if( (rst == 1'b1)) begin
	    ABCD <= 12'h000;
	end
	else begin
		if (OPi3[0] == 1'b1) begin 
		    ABCD <= ABC*Di3;
		end
		else begin
		    ABCD <= ABC+Di3;
		end
	end
end

endmodule
