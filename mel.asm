
; CC5X Version 3.4H, Copyright (c) B Knudsen Data
; C compiler for the PICmicro family
; ************  30. Apr 2014  18:00  *************

	processor  16F690
	radix  DEC

	__config 0xD4

TMR0        EQU   0x01
PCL         EQU   0x02
PORTA       EQU   0x05
TRISA       EQU   0x85
PCLATH      EQU   0x0A
Carry       EQU   0
Zero_       EQU   2
RP0         EQU   5
RP1         EQU   6
OPTION_REG  EQU   0x81
note        EQU   0x20
out         EQU   0
button      EQU   1
i           EQU   0x22
j           EQU   0x23
millisec    EQU   0x22
TtmpA33     EQU   0x21

	GOTO main

  ; FILE lookup.c
			;char LookUpNote(char W)
			;{
LookUpNote
			;skip(W); /* internal function to CC5X compiler */
	CLRF  PCLATH
	ADDWF PCL,1
			;return 1;   /* Pause */
	RETLW 1
			;return 76;  /* E5 */
	RETLW 76
			;return 85;  /* D5 */
	RETLW 85
			;return 76;  /* E5 */
	RETLW 76
			;return 76;
	RETLW 76
			;return 76;
	RETLW 76
			;return 76;
	RETLW 76
			;return 114; /* A4 */
	RETLW 114
			;return 114;
	RETLW 114
			;return 114;
	RETLW 114
			;return 114;
	RETLW 114
			;return 114;
	RETLW 114
			;return 114;
	RETLW 114
			;return 114;
	RETLW 114
			;return 114;
	RETLW 114
			;return 72;  /* F5 */
	RETLW 72
			;return 76;  /* E5 */
	RETLW 76
			;return 72;  /* F5 */
	RETLW 72
			;return 72;
	RETLW 72
			;return 76;  /* E5 */
	RETLW 76
			;return 76;
	RETLW 76
			;return 85;  /* D5 */
	RETLW 85
			;return 85;
	RETLW 85
			;return 85;
	RETLW 85
			;return 85;
	RETLW 85
			;return 85;
	RETLW 85
			;return 85;
	RETLW 85
			;return 85;
	RETLW 85
			;return 85;
	RETLW 85
			;return 1;   /* Pause */
	RETLW 1
			;return 1;
	RETLW 1
			;return 72;  /* F5 */
	RETLW 72
			;return 76;  /* E5 */
	RETLW 76
			;return 72;  /* F5 */
	RETLW 72
			;return 72;
	RETLW 72
			;return 72;
	RETLW 72
			;return 72;
	RETLW 72
			;return 114; /* A4 */
	RETLW 114
			;return 114;
	RETLW 114
			;return 114;
	RETLW 114
			;return 114;
	RETLW 114
			;return 114;
	RETLW 114
			;return 114;
	RETLW 114
			;return 114;
	RETLW 114
			;return 114;
	RETLW 114
			;return 85;  /* D5 */
	RETLW 85
			;return 96;  /* C5 */
	RETLW 96
			;return 85;  /* D5 */
	RETLW 85
			;return 85;
	RETLW 85
			;return 96;  /* C5 */
	RETLW 96
			;return 96;
	RETLW 96
			;return 101; /* B4 */
	RETLW 101
			;return 101;
	RETLW 101
			;return 85;  /* D5  */
	RETLW 85
			;return 85;
	RETLW 85
			;return 96;  /* C5  */
	RETLW 96
			;return 96;
	RETLW 96
			;return 96;
	RETLW 96
			;return 96;
	RETLW 96
			;return 1;   /* Pause */
	RETLW 1
			;return 0;   /* End */
	RETLW 0
			;}

  ; FILE mel.c
			;/* mel.c  Play a melody */
			;/* Connect high impedance earphone to RA5 and GND */
			;
			;/* B Knudsen Cc5x C-compiler - not ANSI-C */
			;#include "16F690.h"
			;#pragma config |= 0x00D4
			;
			;#include "lookup.c"
			;#define EIGHT_NOTE 250
			;
			;char LookUpNote(char);  /* function prototype */
			;void delay(char);
			;
			;void  main(void)
			;{
main
			;  char note;
			;  bit out, button = 1;
	BCF   0x03,RP0
	BCF   0x03,RP1
	BSF   0x21,button
			;  TRISA.3 = 1; /* SW1 input                                 */
	BSF   0x03,RP0
	BSF   TRISA,3
			;  delay(100);  /* 100 ms for demo board initialization      */
	MOVLW 100
	CALL  delay
			;  OPTION = 0b111; /* Timer0 Prescaler divide by 256         */
	MOVLW 7
	BSF   0x03,RP0
	BCF   0x03,RP1
	MOVWF OPTION_REG
			;
			;  while(1)
			;   {
			;     char i;   
			;     for(i=0;;i++)
m001	BCF   0x03,RP0
	BCF   0x03,RP1
	CLRF  i
			;     {
			;       note = LookUpNote(i);
m002	BCF   0x03,RP0
	BCF   0x03,RP1
	MOVF  i,W
	CALL  LookUpNote
	MOVWF note
			;       if( note == 0 ) break;
	MOVF  note,1
	BTFSC 0x03,Zero_
	GOTO  m009
			;       if( note == 1 ) TRISA.4 = 1;  /* pause note is silent */
	BCF   0x03,RP0
	BCF   0x03,RP1
	DECFSZ note,W
	GOTO  m003
	BSF   0x03,RP0
	BSF   TRISA,4
			;       else TRISA.4 =  0;            /* RA4 is output        */
	GOTO  m004
m003	BSF   0x03,RP0
	BCF   0x03,RP1
	BCF   TRISA,4
			;          TMR0 = 0;                  /* Reset timer0         */
m004	BCF   0x03,RP0
	BCF   0x03,RP1
	CLRF  TMR0
			;          while (TMR0 < EIGHT_NOTE)  /* "1/8"-note duration  */
m005	MOVLW 250
	BCF   0x03,RP0
	BCF   0x03,RP1
	SUBWF TMR0,W
	BTFSC 0x03,Carry
	GOTO  m008
			;      	    {
			;              char j;
			;              for(j = note; j > 0; j--) 
	MOVF  note,W
	MOVWF j
m006	BCF   0x03,RP0
	BCF   0x03,RP1
	MOVF  j,1
	BTFSC 0x03,Zero_
	GOTO  m007
			;                { /* Delay. Loop + 4 nop()'s totals 10 us  */
			;                  nop(); nop(); nop(); nop();
	NOP  
	NOP  
	NOP  
	NOP  
			;                }
	DECF  j,1
	GOTO  m006
			;              /* Toggle Output bit RA4 On/Off */
			;              out = !out; 
m007	MOVLW 1
	BCF   0x03,RP0
	BCF   0x03,RP1
	XORWF TtmpA33,1
			;              PORTA.4 = out;
	BTFSS 0x21,out
	BCF   PORTA,4
	BTFSC 0x21,out
	BSF   PORTA,4
			;            }
	GOTO  m005
			;     }
m008	BCF   0x03,RP0
	BCF   0x03,RP1
	INCF  i,1
	GOTO  m002
			;    while(PORTA.3 == 1){ /* wait */ } /* SW1 to play again */ 
m009	BCF   0x03,RP0
	BCF   0x03,RP1
	BTFSS PORTA,3
	GOTO  m001
	GOTO  m009
			;   }
			;}
			;
			;
			;/* *********************************** */
			;/*            FUNCTIONS                */
			;/* *********************************** */
			;
			;void delay( char millisec)
			;/* 
			;  Delays a multiple of 1 milliseconds at 4 MHz (16F628 internal clock)
			;  using the TMR0 timer 
			;*/
			;{
delay
	BCF   0x03,RP0
	BCF   0x03,RP1
	MOVWF millisec
			;    OPTION = 2;  /* prescaler divide by 8        */
	MOVLW 2
	BSF   0x03,RP0
	MOVWF OPTION_REG
			;    do  {
			;        TMR0 = 0;
m010	BCF   0x03,RP0
	BCF   0x03,RP1
	CLRF  TMR0
			;        while ( TMR0 < 125)   /* 125 * 8 = 1000  */
m011	MOVLW 125
	BCF   0x03,RP0
	BCF   0x03,RP1
	SUBWF TMR0,W
	BTFSS 0x03,Carry
			;            ;
	GOTO  m011
			;    } while ( -- millisec > 0);
	BCF   0x03,RP0
	BCF   0x03,RP1
	DECFSZ millisec,1
	GOTO  m010
			;}
	RETURN

	END


; *** KEY INFO ***

; 0x0001 P0   63 word(s)  3 % : LookUpNote
; 0x0088 P0   20 word(s)  0 % : delay
; 0x0040 P0   72 word(s)  3 % : main

; RAM usage: 4 bytes (4 local), 252 bytes free
; Maximum call level: 1
;  Codepage 0 has  156 word(s) :   7 %
;  Codepage 1 has    0 word(s) :   0 %
; Total of 156 code words (3 %)
