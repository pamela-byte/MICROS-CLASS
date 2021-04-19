/*
 * Copyright 2016-2021 NXP
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * o Redistributions of source code must retain the above copyright notice, this list
 *   of conditions and the following disclaimer.
 *
 * o Redistributions in binary form must reproduce the above copyright notice, this
 *   list of conditions and the following disclaimer in the documentation and/or
 *   other materials provided with the distribution.
 *
 * o Neither the name of NXP Semiconductor, Inc. nor the names of its
 *   contributors may be used to endorse or promote products derived from this
 *   software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/**
 * @file    MKL25Z4_Project.c
 * @brief   Application entry point.
 */
#include <stdio.h>
#include "board.h"
#include "peripherals.h"
#include "pin_mux.h"
#include "clock_config.h"
#include "MKL25Z4.h"
#include "fsl_debug_console.h"


/* EXTERNO: VOLTAJE, TIERRA, PTE20*/

void ADC0_confi(void);
void Bounce(void);
void Delay1(void);



int main (void)
{
int i = 0;
int res;


ADC0_confi(); /* Configura el ADC0 */
Bounce(); // Configura Máquina de Estados(Bounce)


while (1)
{
	ADC0->SC1[0] = 0; /* Se usa para el trigger,  */
	while(!(ADC0->SC1[0] & 0x80))
	{
	} /* COCO: conversión completada. Que se pare en ese ciclo hasta que la conversión se complete */
	/*Un registro controla la conversión de los datos*/
		res = ADC0->R[0]; /* la respuesta es igual al número que se guardó en el registro */

		/*aquí se inserta el bounce*/
		printf("ADC Res: %i\n",res);


		if(res>=15000)
		{
		i++;
		printf("valor de i: %i\n",i);
			if(i==160)
			{
				while((GPIOD->PDIR & (1<<7))!= 128)
					{
					//AZUL
					GPIOD->PTOR |= (1<<1);
					Delay1();
					GPIOD->PTOR |= (1<<1);

					//VERDE
					GPIOB->PTOR |= (1<<19);
					Delay1();
					GPIOB->PTOR |= (1<<19);

					//ROJO
					GPIOB->PTOR |= (1<<18);
					Delay1();
					GPIOB->PTOR |= (1<<18);

					//VERDE
					GPIOB->PTOR |= (1<<19);
					Delay1();
					GPIOB->PTOR |= (1<<19);
					}
				if((GPIOD->PDIR & (1<<7))== 0)
				{
					i=0;
				}
			}
		}
		else
		{
			i=0;
			printf("%i",i);
		}

}
}

void ADC0_confi(void)
{
SIM->SCGC5 |= 0x2000; /* reloj al PORTE para configurar la señal del reloj*/
PORTE->PCR[20] = 0; /* Entrada análoga del POT. Puerto de solo lectura. Siempre tiene valor de cero.  */
SIM->SCGC6 |= 0x8000000; /* reloj del ADC0 */
ADC0->SC2 &= ~0x40; /* Status and control register. trigger del software */
ADC0->SC3 |= 0x07; /* 32 samples average */
/* clock div by 4, long sample time, single ended 16 bit, bus clock */
ADC0->CFG1 = 0x40 | 0x10 | 0x0C | 0x00;
}


void Bounce()
{

	SIM->SCGC5 |= (1<<12); //PORTD CLOCK
	PORTD->PCR[7] |= (1<<8); //MUX PORTD MODO GPIO BOTÓN
	GPIOD->PDDR &= ~(1<<7); //PORTA INPUT_OUTPUT BOTÓN

	SIM->SCGC5 |= (1<<10); //PORTB CLOCK

	PORTB->PCR[18] |= (1<<8); //MUX PORTB MODO GPIO RED
	PORTB->PCR[19] |= (1<<8); //MUX PORTB MODO GPIO GREEN
	PORTD->PCR[1] |= (1<<8); //MUX PORTB MODO GPIO BLUE

	GPIOB->PDDR |= (11<<18); //PORTA INPUT_OUTPUT RED AND GREEN
	GPIOD->PDDR |= (1<<1); //PORTA INPUT_OUTPUT BLUE
	GPIOB->PTOR |= (1<<18);
	GPIOB->PTOR |= (1<<19);
	GPIOD->PTOR |= (1<<1);


}

void Delay1()
{
	int j;
	for (j = 0; j < 800000; j++)
	{}
}
