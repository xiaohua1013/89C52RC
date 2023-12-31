ORG 0000H;0000H单元为系统启动地址
LJMP MAIN ;跳转至主程序
ORG 0023H;串口1中断向量地址0023H
LJMP UART_INT   ;串口1中断服务程序
ORG 0100H   ;用户程序从0100H开始存放
MAIN:   
    CLR 0XE8;关闭P4.0（蜂鸣器）
    MOV SP,#70H;设置堆栈指针
    MOV IE,#90H;设置中断允许,并允许串口中断请求
    MOV TMOD,#20H;设置定时器1工作方式
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
    ; XRL A,#0FFH
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
