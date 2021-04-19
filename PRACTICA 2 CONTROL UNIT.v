module control_unit(
	input clk,
	input [3:0] iEntrada,   // Es el resultado que arroja la alu, debemos distinguir si es para el contador o no
	input [4:0] iFlags,		//Banderas que llegan de la alu
	input [3:0] iInputData,//Entrada física
	
	output [3:0] oOpCode,	//Señal que se envía a la alu
	output [3:0] oDato_2, 	//Señal que se envía a la alu
	output [3:0] oDato_1,	//Señal que se envía a la alu
	output oLED,				//Salida a led físico
	output [3:0] oContador	//Salidas físicas LED de contador 4 bits
);

assign oDato_1=rDato_1;
assign oDato_2=rDato_2;
assign oOpCode=rOpCode;
assign oLED=rLED;
assign oContador=rContador;


reg [3:0] rDato_1;	//Van a la alu
reg [3:0] rDato_2;
reg [3:0] rOpCode;

reg [4:0] rFlags;				//Llegan de la alu
reg [3:0] rEntrada;


reg [3:0] rCredencial=4'b1001;	//Entrada física y definidos
reg [3:0] rInputData;

reg [3:0] rContador=4'b0000;		//Registros de salidas del sistema
reg rLED;

reg [2:0] rEstado=3'b000;   

always@*
	begin
		rFlags=iFlags;
			rEntrada=iEntrada;
			rInputData=iInputData;
	end
always@(posedge clk)
		begin
			
			rFlags=iFlags;
			rEntrada=iEntrada;
			rInputData=iInputData;
			
			if(rEstado==3'b000) //Estado 0 Enviar datos a alu (iA y Credencial)
				begin
					rDato_1=rInputData;
					rDato_2=rCredencial;
					rOpCode=4'b0110;
					rEstado<=3'b001;
				end
			else if (rEstado==3'b001) //Estado 1 Esperar datos de alu SUBJETIVA
				begin
					rEstado<=3'b010;
				end
			else if (rEstado==3'b010) //Estado 2 Recibir datos de alu y determinar siguiente estado
				begin
					if (rFlags[0]==1'b1)
						begin
							rEstado<=3'b011;
						end
					else 
						begin
							if (rFlags[4]==1'b1)
								begin
									rEstado<=3'b100;
								end
							else 
								begin
									rEstado<=3'b101;
								end
						end
				end
			else if (rEstado==3'b011) //Estado 3: son iguales
				begin
					rDato_1=rContador;
					rDato_2=4'b0000;
					rOpCode=4'b0101;
					
					rLED=1'b1;
					rEstado<=3'b110;
					
												//rContador=rContador;
				end
			else if (rEstado==3'b100)	//Estado 4: es menor
				begin
					rDato_1=rContador;
					rDato_2=4'b0001;
					rOpCode=4'b0101;       						
					
					rLED=1'b0;
					rEstado<=3'b110;
					
												//rContador=rContador+1'b1;
				end
			else if (rEstado==3'b101) 	//Estado 5: es mayor
				begin
					rDato_1=rContador;
					rDato_2=4'b0001;
					rOpCode=4'b0110; 			
					
					rLED=1'b0;
					rEstado<=3'b110;
					
												//rContador=rContador-1'b1;
				end
			else if (rEstado==3'b110)	//Estado 6, esperar resultado de contador
				begin
					rContador=rEntrada;
					rEstado<=3'b000;
				end			
			else
				begin
					rEstado<=3'b000;			//Mandar a estado cero 
				end
				
			if (rContador==4'b1111)       //Resetear a cero el contador
				begin
					rContador<=4'b0000;
				end

		end
endmodule
