
; CC5X Version 3.4H, Copyright (c) B Knudsen Data
; C compiler for the PICmicro family
; ************  30. Apr 2014  16:03  *************

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
millisec    EQU   0x22
n           EQU   0x7F
i           EQU   0x7F
note        EQU   0x20
out         EQU   0
button      EQU   1
i_2         EQU   0x22
j           EQU   0x23
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

  ; FILE delays.c
			;/* delays.c Delay functions           */
			;/* Function prototypes is in delays.h */
			;
			;
			;void delay( char millisec)
			;/* 
			;  Delays a multiple of 1 milliseconds at 4 MHz
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
m001	BCF   0x03,RP0
	BCF   0x03,RP1
	CLRF  TMR0
			;        while ( TMR0 < 125)   /* 125 * 8 = 1000  */
m002	MOVLW 125
	BCF   0x03,RP0
	BCF   0x03,RP1
	SUBWF TMR0,W
	BTFSS 0x03,Carry
			;            ;
	GOTO  m002
			;    } while ( -- millisec > 0);
	BCF   0x03,RP0
	BCF   0x03,RP1
	DECFSZ millisec,1
	GOTO  m001
			;}
	RETURN
			;
			;
			;void delay10( char n)
			;/*
			;  Delays a multiple of 10 milliseconds using the TMR0 timer
			;  Clock : 4 MHz   => period T = 0.25 microseconds
			;  1 IS = 1 Instruction Cycle = 1 microsecond
			;  error: 0.16 percent
			;*/
			;{
delay10
	MOVWF n
			;    char i;
			;
			;    OPTION = 7;
	MOVLW 7
	BSF   0x03,RP0
	BCF   0x03,RP1
	MOVWF OPTION_REG
			;    do  {
			;        i = TMR0 + 39; /* 256 microsec * 39 = 10 ms */
m003	MOVLW 39
	BCF   0x03,RP0
	BCF   0x03,RP1
	ADDWF TMR0,W
	MOVWF i
			;        while ( i != TMR0)
m004	MOVF  i,W
	BCF   0x03,RP0
	BCF   0x03,RP1
	XORWF TMR0,W
	BTFSS 0x03,Zero_
			;            ;
	GOTO  m004
			;    } while ( --n > 0);
	DECFSZ n,1
	GOTO  m003
			;}
	RETURN

  ; FILE mel690.c
			;/* mel690.c  Play a melody */
			;
			;/*    Low pin count demo board               J1      ----------
			;         ___________  ___________           1 RA5 --| earphone |
			;        |           \/           |          2 RA4 --| earphone |
			;  +5V---|Vdd     16F690       Vss|---GND    3 RA3    ----------
			;     ---|RA5        RA0/AN0/(PGD)|-<-RP1    4 RC5
			;     ---|RA4            RA1/(PGC)|---       5 RC4
			;  SW1---|RA3/!MCLR/(Vpp)  RA2/INT|---       6 RC3
			;     ---|RC5/CCP              RC0|->-DS1    7 RA0
			;     ---|RC4                  RC1|->-DS2    8 RA1
			;  DS4-<-|RC3                  RC2|->-DS3    9 RA2
			;        |RC6                  RB4|         10 RC0
			;        |RC7               RB5/Rx|         11 RC1
			;        |RB7/Tx               RB6|         12 RC2
			;        |________________________|         13 +5V
			;                                           14 GND
			;*/
			;
			;/* Connect high impedance earphone to J1:1 and J1:2 */
			;
			;/* B Knudsen Cc5x C-compiler - not ANSI-C */
			;#include "16F690.h"
			;#pragma config |= 0x00D4
			;
			;#include "lookup.c"
			;#include "delays.c"
			;#define EIGHT_NOTE 250
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
			;  PORTA = 0;
	CLRF  PORTA
			;  TRISA.5 = 0; /* RB5 will act as "ground-pin" for earphone */
	BSF   0x03,RP0
	BCF   TRISA,5
			;  TRISA.3 = 1; /* SW1 input                                 */
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
m005	BCF   0x03,RP0
	BCF   0x03,RP1
	CLRF  i_2
			;     {
			;       note = LookUpNote(i);
m006	BCF   0x03,RP0
	BCF   0x03,RP1
	MOVF  i_2,W
	CALL  LookUpNote
	MOVWF note
			;       if( note == 0 ) break;
	MOVF  note,1
	BTFSC 0x03,Zero_
	GOTO  m013
			;       if( note == 1 ) TRISA.4 = 1;  /* pause note is silent */
	BCF   0x03,RP0
	BCF   0x03,RP1
	DECFSZ note,W
	GOTO  m007
	BSF   0x03,RP0
	BSF   TRISA,4
			;       else TRISA.4 =  0;            /* RA4 is output        */
	GOTO  m008
m007	BSF   0x03,RP0
	BCF   0x03,RP1
	BCF   TRISA,4
			;          TMR0 = 0;                  /* Reset timer0         */
m008	BCF   0x03,RP0
	BCF   0x03,RP1
	CLRF  TMR0
			;          while (TMR0 < EIGHT_NOTE)  /* "1/8"-note duration  */
m009	MOVLW 250
	BCF   0x03,RP0
	BCF   0x03,RP1
	SUBWF TMR0,W
	BTFSC 0x03,Carry
	GOTO  m012
			;      	    {
			;              char j;
			;              for(j = note; j > 0; j--) 
	MOVF  note,W
	MOVWF j
m010	BCF   0x03,RP0
	BCF   0x03,RP1
	MOVF  j,1
	BTFSC 0x03,Zero_
	GOTO  m011
			;                { /* Delay. Loop + 4 nop()'s totals 10 us  */
			;                  nop(); nop(); nop(); nop();
	NOP  
	NOP  
	NOP  
	NOP  
			;                }
	DECF  j,1
	GOTO  m010
			;              /* Toggle Output bit RA4 On/Off */
			;              out = !out; 
m011	MOVLW 1
	BCF   0x03,RP0
	BCF   0x03,RP1
	XORWF TtmpA33,1
			;              PORTA.4 = out;
	BTFSS 0x21,out
	BCF   PORTA,4
	BTFSC 0x21,out
	BSF   PORTA,4
			;            }
	GOTO  m009
			;     }
m012	BCF   0x03,RP0
	BCF   0x03,RP1
	INCF  i_2,1
	GOTO  m006
			;    while(PORTA.3 == 1){ /* wait */ } /* SW1 to play again */ 
m013	BCF   0x03,RP0
	BCF   0x03,RP1
	BTFSS PORTA,3
	GOTO  m005
	GOTO  m013
			;   }

	END


; *** KEY INFO ***

; 0x0001 P0   63 word(s)  3 % : LookUpNote
; 0x0040 P0   20 word(s)  0 % : delay
; 0x0054 P0   19 word(s)  0 % : delay10
; 0x0067 P0   74 word(s)  3 % : main

; RAM usage: 4 bytes (4 local), 252 bytes free
; Maximum call level: 1
;  Codepage 0 has  177 word(s) :   8 %
;  Codepage 1 has    0 word(s) :   0 %
; Total of 177 code words (4 %)
