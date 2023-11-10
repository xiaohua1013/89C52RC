ORG 0000H;0000H单元为系统启动地址
LJMP MAIN ;跳转至主程序
ORG 0023H;串口1中断向量地址0023H
LJMP UART_INT   ;串口1中断服务程序
ORG 0100H   ;用户程序从0100H开始存放
MAIN:   
    CLR 0XE8;关闭P4.0（蜂鸣器）
    MOV SP,#70H;设置堆栈指针
    MOV IE,#90H;设置中断允许,并允许串口中断请求
    MOV TMOD,#20H;设置定时器1工作方式,8位自动重装载定时器,当溢出时将TH1存放的值自动重装入TL1?
    MOV TH1,#0FDH;设置定时器1的初值
    MOV TL1,#0FDH;
    MOV PCON,#00H;
    MOV SCON,#50H
    SETB TR1;定时器T1的运行控制位,启动定时器T1
    SETB ES;设置串口中断允许
    SETB EA;设置总中断允许
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
