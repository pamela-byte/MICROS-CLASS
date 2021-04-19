/*
 * PinConfiguration.h
 *
 *  Created on: 15 mar. 2021
 *      Author: pamlo
 */

#ifndef PINCONFIGURATION_H_
#define PINCONFIGURATION_H_

void fnvPinMode(char bPORT,int wPIN,char *bMODE);
void fnvDigitalWrite(char bPORT,int wPIN,char *pbDATA);

#endif /* PINCONFIGURATION_H_ */
