/*
 * PinConfiguration.c
 *
 *  Created on: 13 mar. 2021
 *      Author: pamlo
 */
#include <stdio.h>
#include <string.h>

int dwaMascaraA_PDDR[32]={0};
int dwaMascaraB_PDDR[32]={0};
int dwaMascaraC_PDDR[32]={0};
int dwaMascaraD_PDDR[32]={0};
int dwaMascaraE_PDDR[32]={0};
int dwaMascaraA[32]={0};
int dwaMascaraB[32]={0};
int dwaMascaraC[32]={0};
int dwaMascaraD[32]={0};
int dwaMascaraE[32]={0};
int MODE;

void fnvPinMode(char bPORT,int wPIN,char *pbMODE){
	int *wp2SCG;
	int *wp2PCR;
	int *wp2PDDR;
	int wContador;
	int wPrevio=0;

	unsigned int wPrueba=0;
	unsigned int wTotal=0;

//Encender todos los clocks
wp2SCG=(int *)0x40048038;
*wp2SCG=0x3E00;

int vwComparador=strcmp(pbMODE,"OUTPUT");
MODE=vwComparador;
switch(bPORT){
	case 'A':{
		//PDDR
		wp2PDDR=(int *)0x400FF014;
		if(vwComparador==0){
			dwaMascaraA_PDDR[wPIN]=1;
			for(wContador=0;wContador<31;wContador++){
				if(dwaMascaraA_PDDR[wContador]==0){
					wPrevio++;
				}
				if(dwaMascaraA_PDDR[wContador]==1){
					wPrueba=0;
					wPrueba=1<<(wPrevio);
					wTotal=wTotal|wPrueba;
					wPrevio=wContador+1;
				}
			}
			*wp2PDDR=wTotal;
		}
	}
	//Alternativa del pin (Pin Controler Register)
	wp2PCR=(int *)0x40049000;
	for(wContador=0;wContador<wPIN;wContador++){
		wp2PCR=wp2PCR+(0x1);
	}
	*wp2PCR=0x100;
	break;
	case 'B':{
		//PDDR
		wp2PDDR=(int *)0x400FF054;
		if(vwComparador==0){
			dwaMascaraB_PDDR[wPIN]=1;
			for(wContador=0;wContador<31;wContador++){
				if(dwaMascaraB_PDDR[wContador]==0){
					wPrevio++;
				}
				if(dwaMascaraB_PDDR[wContador]==1){
					wPrueba=0;
					wPrueba=1<<wPrevio;
					wTotal=wTotal|wPrueba;
					wPrevio=wContador+1;
				}
			}
			*wp2PDDR=wTotal;
		}
	}
	//Alternativa del pin (Pin Controler Register)
	wp2PCR=(int *)0x4004A000;
	for(wContador=0;wContador<wPIN;wContador++){
		wp2PCR=wp2PCR+(0x1);
	}
	*wp2PCR=0x100;
	break;

	case 'C':{
		//PDDR
		wp2PDDR=(int *)0x400FF094;
		if(vwComparador==0){
			dwaMascaraC_PDDR[wPIN]=1;
			for(wContador=0;wContador<31;wContador++){
				if(dwaMascaraC_PDDR[wContador]==0){
					wPrevio++;
				}
				if(dwaMascaraC_PDDR[wContador]==1){
					wPrueba=0;
					wPrueba=1<<wPrevio;
					wTotal=wTotal|wPrueba;
					wPrevio=wContador+1;
				}
			}
			*wp2PDDR=wTotal;
		}
	}
	//Alternativa del pin (Pin Controler Register)
	wp2PCR=(int *)0x4004B000;
	for(wContador=0;wContador<wPIN;wContador++){
		wp2PCR=wp2PCR+(0x1);
	}
	*wp2PCR=0x100;
	break;

	case 'D':{
		//PDDR
		wp2PDDR=(int *)0x400FF0D4;
		if(vwComparador==0){
			dwaMascaraD_PDDR[wPIN]=1;
			for(wContador=0;wContador<31;wContador++){
				if(dwaMascaraD_PDDR[wContador]==0){
					wPrevio++;
				}
				if(dwaMascaraD_PDDR[wContador]==1){
					wPrueba=0;
					wPrueba=1<<wPrevio;
					wTotal=wTotal|wPrueba;
					wPrevio=wContador+1;
				}
			}
			*wp2PDDR=wTotal;
		}
	}
	//Alternativa del pin (Pin Controler Register)
	wp2PCR=(int *)0x4004C000;
	for(wContador=0;wContador<wPIN;wContador++){
		wp2PCR=wp2PCR+(0x1);
	}
	*wp2PCR=0x100;
	break;
	case 'E':{
		//PDDR
		wp2PDDR=(int *)0x400FF114;
		if(vwComparador==0){
			dwaMascaraE_PDDR[wPIN]=1;
			for(wContador=0;wContador<31;wContador++){
				if(dwaMascaraE_PDDR[wContador]==0){
					wPrevio++;
				}
				if(dwaMascaraE_PDDR[wContador]==1){
					wPrueba=0;
					wPrueba=1<<wPrevio;
					wTotal=wTotal|wPrueba;
					wPrevio=wContador+1;
				}
			}
			*wp2PDDR=wTotal;
		}
	}
	//Alternativa del pin (Pin Controler Register)
	wp2PCR=(int *)0x4004D000;
	for(wContador=0;wContador<wPIN;wContador++){
		wp2PCR=wp2PCR+(0x1);
	}
	*wp2PCR=0x100;
	break;
}
}

void fnvDigitalWrite(char bPORT,int wPIN,char *pbDATA){
	//PDOR de cada puerto
	int *wp2PDOR;
	int *wp2PDIR;
	int wContador;
	int wPrevio=0;
	unsigned int wPrueba=0;
	unsigned int wTotal=0;

	int vwComparador;
	vwComparador=strcmp(pbDATA,"ON");

	switch(bPORT){
	case 'A':
		if(MODE==0){
			wp2PDOR=(int *)0x400FF000;
			//Si PDDR es OUTPUT
			if(vwComparador){
				*wp2PDOR=0x0;
			}
			if(vwComparador==0){
				dwaMascaraA[wPIN]=1;
				for(wContador=0;wContador<31;wContador++){
					if(dwaMascaraA[wContador]==0){
						wPrevio++;
					}
					if(dwaMascaraA[wContador]==1){
						wPrueba=0;
						wPrueba=1<<(wPrevio);
						wTotal=wTotal|wPrueba;
						wPrevio=wContador+1;
					}
				}
				*wp2PDOR=wTotal;
			}
		}
		else{
			wp2PDIR=(int *)0x400FF010;
			//Si PDDR es INPUT
			if(vwComparador){
				*wp2PDIR=0x0;
			}
			if(vwComparador==0){
				dwaMascaraA[wPIN]=1;
				for(wContador=0;wContador<31;wContador++){
					if(dwaMascaraA[wContador]==0){
						wPrevio++;
					}
					if(dwaMascaraA[wContador]==1){
						wPrueba=0;
						wPrueba=1<<(wPrevio);
						wTotal=wTotal|wPrueba;
						wPrevio=wContador+1;
					}
				}
				*wp2PDIR=wTotal;
			}
		}
		break;

	case 'B':
		if(MODE==0){
			wp2PDOR=(int *)0x400FF040;
			//Si PDDR es OUTPUT
			if(vwComparador){
				*wp2PDOR=0x0;
			}
			if(vwComparador==0){
				dwaMascaraB[wPIN]=1;
				for(wContador=0;wContador<31;wContador++){
					if(dwaMascaraB[wContador]==0){
						wPrevio++;
					}
					if(dwaMascaraB[wContador]==1){
						wPrueba=0;
						wPrueba=1<<(wPrevio);
						wTotal=wTotal|wPrueba;
						wPrevio=wContador+1;
					}
				}
				*wp2PDOR=wTotal;
			}
		}
		else{
			wp2PDIR=(int *)0x400FF050;
			//Si PDDR es INPUT
			if(vwComparador){
				*wp2PDIR=0x0;
			}
			if(vwComparador==0){
				dwaMascaraB[wPIN]=1;
				for(wContador=0;wContador<31;wContador++){
					if(dwaMascaraB[wContador]==0){
						wPrevio++;
					}
					if(dwaMascaraB[wContador]==1){
					wPrueba=0;
					wPrueba=1<<(wPrevio);
					wTotal=wTotal|wPrueba;
					wPrevio=wContador+1;
					}
				}
				*wp2PDIR=wTotal;
			}
		}
		break;

	case 'C':
		if(MODE==0){
			wp2PDOR=(int *)0x400FF080;
			//Si PDDR es INPUT
			if(vwComparador){
				*wp2PDIR=(int *)0x0;
			}
			if(vwComparador==0){
				dwaMascaraC[wPIN]=1;
				for(wContador=0;wContador<31;wContador++){
					if(dwaMascaraC[wContador]==0){
						wPrevio++;
					}
					if(dwaMascaraC[wContador]==1){
						wPrueba=0;
						wPrueba=1<<(wPrevio);
						wTotal=wTotal|wPrueba;
						wPrevio=wContador+1;
					}
				}
				*wp2PDIR=wTotal;
			}
		}
		else{
			wp2PDIR=(int *)0x400FF090;
			//Si PDDR es OUTPUT
			if(vwComparador){
				*wp2PDOR=(int *)0x0;
			}
			if(vwComparador==0){
				dwaMascaraC[wPIN]=1;
				for(wContador=0;wContador<31;wContador++){
					if(dwaMascaraC[wContador]==0){
						wPrevio++;
					}
					if(dwaMascaraC[wContador]==1){
						wPrueba=0;
						wPrueba=1<<(wPrevio);
						wTotal=wTotal|wPrueba;
						wPrevio=wContador+1;
					}
				}
				*wp2PDOR=wTotal;
			}
		}
		break;

	case 'D':
		if(MODE==0){
			wp2PDOR=(int *)0x400FF0C0;
			//Si PDDR es OUTPUT
			if(vwComparador){
				*wp2PDOR=0x0;
			}
			if(vwComparador==0){
				dwaMascaraD[wPIN]=1;
				for(wContador=0;wContador<31;wContador++){
					if(dwaMascaraD[wContador]==0){
						wPrevio++;
					}
					if(dwaMascaraD[wContador]==1){
						wPrueba=0;
						wPrueba=1<<(wPrevio);
						wTotal=wTotal|wPrueba;
						wPrevio=wContador+1;
					}
				}
				*wp2PDOR=wTotal;
			}
		}
		else{
			wp2PDIR=(int *)0x400FF0D0;
			//Si PDDR es INPUT
			if(vwComparador){
				*wp2PDIR=0x0;
			}
			if(vwComparador==0){
				dwaMascaraD[wPIN]=1;
				for(wContador=0;wContador<31;wContador++){
					if(dwaMascaraD[wContador]==0){
					wPrevio++;
					}
					if(dwaMascaraD[wContador]==1){
					wPrueba=0;
					wPrueba=1<<(wPrevio);
					wTotal=wTotal|wPrueba;
					wPrevio=wContador+1;
					}
				}
				*wp2PDIR=wTotal;
			}
		}
		break;

	case 'E':
		if(MODE==1){
			wp2PDOR=(int *)0x400FF100;
			//Si PDDR es OUTPUT
			if(vwComparador){
				*wp2PDOR=0x0;
			}
			if(vwComparador==0){
				dwaMascaraE[wPIN]=1;
				for(wContador=0;wContador<31;wContador++){
					if(dwaMascaraE[wContador]==0){
					wPrevio++;
					}
					if(dwaMascaraE[wContador]==1){
						wPrueba=0;
						wPrueba=1<<(wPrevio);
						wTotal=wTotal|wPrueba;
						wPrevio=wContador+1;
					}
				}
				*wp2PDOR=wTotal;
			}
		}
		else{
			wp2PDIR=(int *)0x400FF110;
			//Si PDDR es INPUT
			if(vwComparador){
				*wp2PDIR=0x0;
			}
			if(vwComparador==0){
				dwaMascaraE[wPIN]=1;
				for(wContador=0;wContador<31;wContador++){
					if(dwaMascaraE[wContador]==0){
					wPrevio++;
					}
					if(dwaMascaraE[wContador]==1){
						wPrueba=0;
						wPrueba=1<<(wPrevio);
						wTotal=wTotal|wPrueba;
						wPrevio=wContador+1;
					}
				}
				*wp2PDIR=wTotal;
			}
		}
		break;
	}
}
