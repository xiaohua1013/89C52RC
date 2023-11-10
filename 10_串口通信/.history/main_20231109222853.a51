ORG 0000H;0000H��ԪΪϵͳ������ַ
LJMP MAIN ;��ת��������
ORG 0023H;����1�ж�������ַ0023H
LJMP UART_INT   ;����1�жϷ������
ORG 0100H   ;�û������0100H��ʼ���
MAIN:   
    CLR 0XE8;�ر�P4.0����������
    MOV SP,#70H;���ö�ջָ��
    MOV IE,#90H;�����ж�����,���������ж�����
    MOV TMOD,#20H;���ö�ʱ��1������ʽ,8λ�Զ���װ�ض�ʱ��,�����ʱ��TH1��ŵ�ֵ�Զ���װ��TL1?
    MOV TH1,#0FDH;���ö�ʱ��1�ĳ�ֵ
    MOV TL1,#0FDH;
    MOV PCON,#00H;
    MOV SCON,#50H
    SETB TR1;��ʱ��T1�����п���λ,������ʱ��T1
    SETB ES;���ô����ж�����
    SETB EA;�������ж�����
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
