#include <stdio.h>
#include "board.h"
#include "peripherals.h"
#include "pin_mux.h"
#include "clock_config.h"
#include "MKL25Z4.h"
#include "fsl_debug_console.h"
#include "PinConfiguration.h"
/* TODO: insert other include files here. */

/* TODO: insert other definitions and declarations here. */

/*
 * @brief   Application entry point.
 */

int main(void){
	fnvPinMode('B' , 18, "OUTPUT");
	fnvPinMode('B', 19, "OUTPUT");
	fnvPinMode('D' ,1, "OUTPUT");
/*NOTA: El clock no cambia si se activan todos almismo tiempo
 * pero la direccion PCR si varia entre pines
 * PDDR y PDOR cambian por puerto, hay uno dependiedno si es PORTA, PORTB, PORTC
 * y solo cambia el bit que se encendera
 */

    PRINTF("Hello World\n");

    /* Force the counter to be placed into memory. */
    volatile static int i = 0 ;
    /* Enter an infinite loop, just incrementing a counter. */
    while(1) {
    	fnvDigitalWrite('B',18,"ON");
    	fnvDigitalWrite('B',19,"ON");
    	fnvDigitalWrite('D',1,"ON");
    	fnvDigitalWrite('B',18,"OFF");
    	fnvDigitalWrite('B',19,"OFF");
    	fnvDigitalWrite('D',1,"OFF");

        i++ ;
        /* 'Dummy' NOP to allow source level single stepping of
            tight while() loop */
        __asm volatile ("nop");
    }
    return 0 ;
}
