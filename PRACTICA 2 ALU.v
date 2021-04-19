module ALU(
	input [3:0] iA,
	input [3:0] iB,
	input [3:0] iOpCode,
	input clk,
	output [3:0] oResultado,
	output [4:0] oFlags
);

// Asignación contínua
assign oResultado=rResultado;
assign oFlags=rFlags;


// Wires y registros
reg [4:0] rResultado;       
reg [3:0] rA;
reg [3:0] rB;
reg [4:0] rFlags;


// Secuencial


// Combinacional

always@(posedge clk)
	begin
		rA<=iA;
		rB<=iB;
		
		case(iOpCode)
			4'b0000:rResultado <= {rA[3],rA[3:1]}; 			//Corrimiento aritmético dra    
			4'b0001:rResultado <= rA<<1;  						//Corrimiento lógico izq         
			4'b0010:rResultado <= rA>>1;  						//Corrimiento lógico dra           
			4'b0011:rResultado <= {rA[2:0],rA[3]};        //Rotación izq
			4'b0100:rResultado <= {rA[0],rA[3:1]};		   //Rotación dra
			4'b0101:rResultado <= rA+rB;	               //Suma
			4'b0110:rResultado <= rA-rB;   					//Resta
			4'b0111:rResultado <= rA&rB;   					//AND
			4'b1000:rResultado <= rA|rB;   					//OR
			4'b1001:  begin
						  rResultado[0] <= ~rA[0];
						  rResultado[1] <= ~rA[1];
						  rResultado[2] <= ~rA[2];
						  rResultado[3] <= ~rA[3];   			  
						end     										//NOT
			4'b1010:rResultado <= rA^rB;   					//XOR			   		
			4'b1011: begin
						  rResultado[0] <= ~rA[0];
						  rResultado[1] <= ~rA[1];
						  rResultado[2] <= ~rA[2];
						  rResultado[3] <= ~rA[3];   			//Complemento a 1   
						end
			4'b1100:rResultado <= {rA[2:0],1'b0};						//Corrimiento aritmético izq
			default: rResultado <= 4'b0000;
		endcase
		
		if(rResultado==4'b0000) 								//Bandera resultado cero [0]
			rFlags[0]<=1'b1;
		else rFlags[0]<=1'b0;
		
		if(rResultado[4]==1'b1) 								//Bandera carry [1]
			rFlags[1]<=1'b1;
		else rFlags[1]<=1'b0;
		
		if(rA[3]^rB[3]==0 && rA[3]^rResultado[3])										//Bandera overflow [2]
			rFlags[2]<=1'b1;
		else 
			rFlags[2]<=1'b0;										
			
		rFlags[3]<=(rResultado[0]^rResultado[1]^rResultado[2]^rResultado[3]);  		//Bandera parity [3]
		
		rFlags[4]<=rResultado[3];             				//Bandera signo [4]
		
	end
endmodule
