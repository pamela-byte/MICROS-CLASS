/*CODIGO 1:
int sum = 15;
for (int i=0; i < sum; i++)
   i += 1 */
 
.text
.global codigo1
.type codigo1 function

codigo1:
MOVS r0,#2 //int sum = 15;
MOVS r1,#4 // int i=0;

comparacion:
CMP r1,r0 // comparación entre i y sum
BLO suma // branch a SUMA si la comparación si se cumple i<sum
BHS salida // branch a SALIDA si no se cumplie la condición i<sum

contador: // Se trata del contador del for
ADD r1,#1
B comparacion

suma:
nop
ADD r1,#1
MOVS r2,r1
B contador

salida:
BX LR


/*CODIGO 2:
int n = 20;
while (n--);*/

.text
.global codigo2
.type codigo2 function

codigo2:
MOVS r3,#0 //int n = 20

mientras:
CMP r3,#0 // compara r3 con 0
BNE resta // si no es igual ir a resta
BEQ salida // si es igual ir a salir

resta:
SUB r3,#1 // restar 1 a r3
B mientras

salida:
BX LR


/*Código 3:
int n = 1;
do
{
   n++;
}
while (n < 0) */

.text
.global codigo3
.type codigo3 function

codigo3:
MOVS r4,#1 //int n=1;

suma: //do
ADD r4,#1 // añade 1 a ro y va a condicion
B compara

compara: //while
CMP r4,#0 //comparar n con 0
BLE salida // mas bajo que la comparacion o igual ir a salida
BHI suma // mas grande que ir a suma

salida:
BX LR


/*Código 4:
void vfnCompareNumbers (unsigned char bNumber1, unsigned char bNumber2)
{
	if (bNumber1 < bNumber2)
	{
    ubCounter++;
	}
	else if (bNumber1 == bNumber2)
	{
    ubCounter = bNumber1 + bNumber2;
	}
	else
	{
    ubCounter--;
	}
}*/

.text
.global codigo4
.type codigo4 function

codigo4:
MOVS r5,#8 //unsigned char bNumber1=8
MOVS r6,#5 //unsigned char bNumber2=5
MOVS r7,#0 //ubCounter

comparacion:
CMP r5,r6 //comparar bNumber1 y bNumber2
BLO menor // si es menor ir a menor
BEQ iguales // si son iguales ir a iguales
BHS diferente // si es mayor o el mismo ir a diferente

menor: //si bNumber1<bNumber2
ADD r7,#1
BX LR

iguales: //si bNumber1==bNumber2
ADD r7, r6, r5
BX LR

diferente: //else
SUB r7,#1
BX LR
