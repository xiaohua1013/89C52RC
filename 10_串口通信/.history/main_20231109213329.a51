ORG 0000H
LJMP MAIN
ORG 0023H
LJMP UART_INT
ORG 0100H
MAIN:   
    CLR 0XE8
    MOV SP,#70H
    MOV IE,#90H
    MOV TMOD,#20H
    MOV TH1,#0FDH
    MOV TL1,#0FDH
    MOV PCON,#00H
    MOV SCON,#50H
    SETB TR1
    SETB ES
    SETB EA
LED:
    CLR P3.7
    LCALL DELAY500MS
    SETB P3.7
    LCALL DELAY500MS
    LJMP LED

UART_INT:
    JNB RI,K1
    MOV A,SBUF
    XRL A,SBUF
    MOV SBUF,A
    CLR RI
K1:    
    CLR TI
    RETI

DELAY500MS:   
    MOV R7,#0CDH
DL1:
    MOV R6,#74H
DL0:
    MOV R5,#09H
    DJNZ R5,$
    DJNZ R6,DL0
    DJNZ R7,DL1
    RET

END
