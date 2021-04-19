.text
.global practica4
.type practica4 function


practica4:
//encendiendo los clocks para los leds PORTA PORTD PORTB
LDR R0, =0x40048038			  	//r0=&pointer2clock (&: dirección de la memoria)
LDR R1, =0x1780			 	 	//0x1780
STR R1, [R0] 		   		 	//*pointer2Clock=0x1580

/*Configurando la alternativa del pin B18 (LED ROJO)*/
LDR R2, =0x4004A048				//r1=&pointer2PCR_PORTB18
LDR R3, =0x100					//r3=0x100
STR R3, [R2]					//*pointer2PCR_PORTB18=0x100

//PDDR Input/Output
LDR R4, =0x400FF054				//r2=&pointer2PDDR_PORTB18
LDR R5, =0x40000				//r4=0x4000
STR R5, [R4]					//*pointer2PDDR_PORTB18=0x40000                 <-- aqui enceinde el rojo

/*Configurando la alternativa del pin B19 (LED VERDE)*/
//PCR B19
LDR R3, =0x4004A04C				//r1=&pointer2PCR_PORTB19
LDR R4, =0x100					//r3=0x100
STR R4, [R3]					//*pointer2PCR_PORTB19=0x100

//B19
LDR R4, =0x400FF054				//r2=&pointer2PDDR_PORTB19
LDR R5, =0x80000				//b19
STR R5, [R4]					//b19                                          <-- aqui enciende el verde

/*Configurando la alternativa del pin D1 (LED AZUL)*/
//PCR D1
LDR R1, =0x4004C004				//r1=&pointer2PCR_PORTD1
LDR R3, =0x100					//r3=0x100
STR R3, [R1]					//*pointer2PCR_PORTD1=0x100

//D1
LDR R2, =0x400FF0D4				//r2=&pointer2PDDR_PORTD1
LDR R4, =0x2					//D1
STR R4, [R2]					//D1                                          <-- enciende el azul(pero no se apago el verde)

/*	LED ROJO Y VERDE	*/
//PDDR
LDR R3, =0x400FF054
LDR R5, =0xC0000
STR R5, [R3]           //                                                     <-- aqui encienden todos(rojo, azul, verde)

/*Configuración del push button*/
/*Pin Control Register*/
LDR R1, =0x40049004
LDR R3, =0x100
STR R3, [R1]

/*Port Data Direction Register*/
LDR R2, =0xF80FF014
LDR R4, =0x0
STR R4, [R2]

/*Configurar el puerto A1*/
LDR R3, =0x400FF050
LDR R4, [R3]
LDR R5, =0x2

onehot:
//Configurar el PDOR para mandar un 0 al pin
//APAGAR AZUL
LDR R0, = 0x400FF0C0
LDR R1, = 0x2
STR R1, [R0]            //                                            <-- se apaga el azul
//APAGAR ROJO Y VERDE
LDR R3, =0xF80FF040
LDR R5, =0xC0000
STR R5, [R3]            //                                            <-- se apagan verde y rojo (todos apagados)

//Q0 -> LED ROJO
//encender led rojo
LDR R3, =0x400FF040				//r3=&pointer2PDOR
LDR R5, =0x80000				//r5=0
STR R5, [R3]					//*pointer2PDOR=0                     <-- enciende el rojo

//APAGAR AZUL
LDR R3, =0x400FF0C0				//r3=&pointer2PDOR_PORTD1
LDR R5, =0x2					//r5=1
STR R5, [R3]					//*pointer2PDOR_PORTD1=1
//APAGAR ROJO Y VERDE
LDR R3, =0x400FF04C				//r3=&pointer2PDOR
LDR R5, =0x40000				//r5=0
STR R5, [R3]					//*pointer2PDOR=0                      <---- apaga rojo y verde

//Q1 -> LED VERDE
//encender led verde
LDR R3, =0x400FF040				//r3=&pointer2PDOR
LDR R5, =0x40000 				//r5=0
STR R5, [R3]					//*pointer2PDOR=0                        <-- enciende verde

//Configurar el PDOR para mandar un 0 a los pines
LDR R4, =0x400FF040
LDR R6, =0xC0000
STR R6, [R4]           //                                                  <-- apaga verde

//Q2 -> LED AZUL
//encender led azul
LDR R3, =0x400FF0C0				//r3=&pointer2PDOR_PORTD1
LDR R5, =0x0					//r5=0
STR R5, [R3]					//*pointer2PDOR_PORTD1=0                   <-- enciende azul

//Q3 -> redplusgreen
//PDOR
//apagar led azul
LDR R3, =0x400FF0C0				//r3=&pointer2PDOR_PORTD1
LDR R5, =0x2					//r5=1
STR R5, [R3]					//*pointer2PDOR_PORTD1=1                   <-- apaga el azul

//Q3 -> LED ROJO Y VERDE
//Configurar el PDOR para mandar un 0 a los pines
LDR R4, =0x400FF040
LDR R6, =0x0
STR R6, [R4] //                                                           <-- enciende amarilo

//Configurar el PDOR para mandar un 0 al pin
//APAGAR AZUL
LDR R0, = 0x400FF0C0
LDR R1, = 0x2
STR R1, [R0]            //                                            <-- se apaga el azul
//APAGAR ROJO Y VERDE
LDR R3, =0xF80FF040
LDR R5, =0xC0000
STR R5, [R3]            //                                            <-- se apagan verde y rojo (todos apagados)

//Q0 -> LED ROJO
//encender led rojo
LDR R3, =0x400FF040				//r3=&pointer2PDOR
LDR R5, =0x80000				//r5=0
STR R5, [R3]					//*pointer2PDOR=0                     <-- enciende el rojo

//APAGAR AZUL
LDR R3, =0x400FF0C0				//r3=&pointer2PDOR_PORTD1
LDR R5, =0x2					//r5=1
STR R5, [R3]					//*pointer2PDOR_PORTD1=1
//APAGAR ROJO Y VERDE
LDR R3, =0x400FF04C				//r3=&pointer2PDOR
LDR R5, =0x40000				//r5=0
STR R5, [R3]					//*pointer2PDOR=0                      <---- apaga rojo y verde

//Q1 -> LED VERDE
//encender led verde
LDR R3, =0x400FF040				//r3=&pointer2PDOR
LDR R5, =0x40000 				//r5=0
STR R5, [R3]					//*pointer2PDOR=0                        <-- enciende verde

//Configurar el PDOR para mandar un 0 a los pines
LDR R4, =0x400FF040
LDR R6, =0xC0000
STR R6, [R4]           //                                                  <-- apaga verde

//Q2 -> LED AZUL
//encender led azul
LDR R3, =0x400FF0C0				//r3=&pointer2PDOR_PORTD1
LDR R5, =0x0					//r5=0
STR R5, [R3]					//*pointer2PDOR_PORTD1=0                   <-- enciende azul

//Q3 -> redplusgreen
//PDOR
//apagar led azul
LDR R3, =0x400FF0C0				//r3=&pointer2PDOR_PORTD1
LDR R5, =0x2					//r5=1
STR R5, [R3]					//*pointer2PDOR_PORTD1=1                   <-- apaga el azul

//Q3 -> LED ROJO Y VERDE
//Configurar el PDOR para mandar un 0 a los pines
LDR R4, =0x400FF040
LDR R6, =0x0
STR R6, [R4] //                                                           <-- enciende amarilo

Johnson:
// Q0 -> APAGADOS TODOS
//LED ROJO Y VERDE//
//Configurar el PDOR para mandar un 0 a los pines
LDR R4, =0x400FF040
LDR R6, =0x0
STR R6, [R4] //<-- enciende amarilo

//Configurar el PDOR para mandar un 1 al pin
LDR R3, =0x400FF040				//r3=&pointer2PDOR
LDR R5, =0xC0000 				//r5=1
STR R5, [R3]					//*pointer2PDOR=1                  <-- apaga verde y rojo
//LUZ AZUL//
//Configurar el PDOR para mandar un 0 al pin
LDR R3, =0x400FF0C0				//r3=&pointer2PDOR_PORTD1
LDR R5, =0x2					//r5=0
STR R5, [R3]					//*pointer2PDOR_PORTD1=0          <----- apaga azul

//Q1 -> LED ROJO
LDR R3, =0x400FF040				//r3=&pointer2PDOR
LDR R5, =0x80000				//r5=0
STR R5, [R3]					//*pointer2PDOR=0                <--enceinde rojo

// Q2 ->AMARILLO
//Configurar el PDOR para mandar un 0 a los pines
LDR R4, =0x400FF040
LDR R6, =0x0
STR R6, [R4]                                                            //<-- enciende amarilo

// Q3 -> BLANCO
//led azul
LDR R0, = 0x400FF0C0
LDR R1, = 0x0
STR R1, [R0]                    //                          <--    enciende BLANCO: azul (sin apagar verde ni rojo)

//Q4 -> MAGENTA
//encender led rojo
LDR R3, =0x400FF040				//r3=&pointer2PDOR
LDR R5, =0x80000				//r5=0
STR R5, [R3]					//*pointer2PDOR=0               <-- enciende magenta (azul y rojo)

//Q5-> AQUA
//encender led verde
LDR R3, =0x400FF040				//r3=&pointer2PDOR
LDR R5, =0x40000 				//r5=0
STR R5, [R3]					//*pointer2PDOR=0            <--  enciende aqua (verde y azul)

//Q6 -> BLANCO
//verde
LDR R4, =0x400FF040
LDR R6, =0x0
STR R6, [R4] //                                              <--- enciende blanco(rojo,verdey azul)

//Q7 -> AMARILLO
//apagar azul
LDR R0, = 0x400FF0C0
LDR R1, = 0x2
STR R1, [R0]  //                                                <-- enciende amarillo (rojo y verde)

Bounce:
//Q1--> AMARILLO
//apagar azul
LDR R3, =0x400FF0C0
LDR R5, =0x2
STR R5, [R3]
//encender rojo y verde
LDR R4, =0x400FF040
LDR R6, =0x0
STR R6, [R4] //                                                  <------- enciende amarillo

//Q2 -->AZUL
//Apagar rojo y verde
LDR R4, =0x400FF040
LDR R6, =0xC0000
STR R6, [R4]     //                                              <-------- apaga amarillo
//encender azul
LDR R3, =0x400FF0C0				//r3=&pointer2PDOR_PORTD1
LDR R5, =0x0					//r5=0
STR R5, [R3]  //                                                 <-------- enciende azul

//Q3 -->VERDE
//apagar azul
LDR R3, =0x400FF0C0
LDR R5, =0x2
STR R5, [R3]	//                                                <------- apaga azul
//Encender LED VERDE//
LDR R4, =0x400FF040
LDR R6, =0x40000
STR R6, [R4]       //                                             <------- enciende verde

// Q4 --> ROJO
//Apagar LED AZUL
LDR R3, =0x400FF0C0
LDR R5, =0x2
STR R5, [R3]	//                                                <----- apaga azul
//encender rojo
LDR R4, =0x400FF040
LDR R6, =0x80000
STR R6, [R4]   //                                                 <------- enciende rojo

//Q5--> VERDE
//mantener agagado azul
LDR R3, =0x400FF0C0
LDR R5, =0x2
STR R5, [R3]
//encender verde
LDR R4, =0x400FF040
LDR R6, =0x40000
STR R6, [R4]     //                                               <-------- enciende verde

// Q6--> AZUL
//Apagar verde y rojo
LDR R4, =0x400FF040
LDR R6, =0xC0000
STR R6, [R4]
//prender azul
LDR R3, =0x400FF0C0
LDR R5, =0x0
STR R5, [R3]   //                                                 <-------- enciende azul

//Q7--> AMARILLO
//apagar azul
LDR R3, =0x400FF0C0
LDR R5, =0x2
STR R5, [R3]
//prender rojo y verde
LDR R4, =0x400FF040
LDR R6, =0x0
STR R6, [R4]   //                                                 <-------- enciende amarillo


BX LR
