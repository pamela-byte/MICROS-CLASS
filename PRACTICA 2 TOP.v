module top(
	input clk,
	input [3:0] iA,
	output [3:0] oContador, 
	output oLED,
	output oReloj_5,
	output oReloj_1
);
assign oReloj_5=w7;
assign oReloj_1=w1;

wire w1;
wire [3:0] w2;
wire [3:0] w3;
wire [3:0] w4;
wire [3:0] w5;
wire [4:0] w6;
wire w7;

testmicro Divisor(
	.clk(clk),
	.oclk(w1),
	.oclk2(w7)
);


control_unit Unidad_de_control(
	.clk(w1),
	.iEntrada(w5),
	.iFlags(w6),
	.iInputData(iA),
	.oOpCode(w2),
	.oDato_2(w3), 
	.oDato_1(w4),
	.oLED(oLED),
	.oContador(oContador)
);


ALU ALU(
	.clk(w7),
	.iA(w4),
	.iB(w3),
	.iOpCode(w2),
	.oResultado(w5), 
	.oFlags(w6)
);



endmodule
