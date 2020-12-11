mostrarcad proc cad
	push ax
	push dx
	
	mov ah,09h
	lea dx, cad
	int 21h
	
	pop dx
	pop ax
	
	ret
mostrarcad endp

clrscr proc
	push ax
	push bx
	push cx
	push dx
	mov ah,06h
	mov bh,color
	mov al,lineas
	mov ch,fini
	mov cl,cini
	mov dh,ffin
	mov dl,cfin
	int 10h
	pop dx
	pop cx
	pop bx
	pop ax
	Ret
clrscr endp

gotoxy proc
	push ax
	push bx
	push dx
	mov ah,02h
	mov bh,pag
	mov dh,fila
	mov dl,columna
	int 10h
	pop dx
	pop bx
	pop ax
 	ret
gotoxy endp

;======================MACRO===================
mostrarCadena macro cad
	push ax
	push dx
	
	mov ah,09h
	lea dx,cad
	int 21h
	
	pop dx
	pop ax
	
endm

READ_NUMERO MACRO NUMBER
LOCAL READN, READN_END
PUSH AX
PUSH BX
PUSH CX
PUSH DX
	MOV AX,0
	MOV BX,10
	MOV CX,0
READN:
	PUSH AX
	MOV AH,1
	INT 21H
	CMP AL,0DH
	JE READN_END
	SUB AL,30H
	MOV CL,AL
	POP AX
	MUL BX
	ADD AX,CX
	JMP READN
READN_END:
	POP AX
	MOV NUMBER, AX
POP DX
POP CX
POP BX
POP AX
ENDM

PRINT_NUMBER MACRO NUMBER
LOCAL DIVIDIR, PRINTN
PUSH AX
PUSH BX
PUSH CX
PUSH DX
    MOV AX,NUMBER
    MOV BX,10
    MOV DX,0
    MOV CX,0
    MOV SI,0
DIVIDIR:
    DIV BX
    PUSH DX
    ADD CX,1
    MOV DX,0
    CMP  AX,0
    JE PRINTN
    JMP DIVIDIR
PRINTN:
    POP DX
    ADD DL,30H
    MOV AH,2
    INT 21H 
    LOOP PRINTN    
   
POP DX
POP CX
POP BX
POP AX
ENDM

PRINT_STRING MACRO STRING
PUSH AX
PUSH DX
	MOV AH,9
	LEA DX, STRING
	INT 21H
POP DX
POP AX
ENDM

PRINT_CHARACTER MACRO CHARACTER
PUSH AX
PUSH DX
	MOV AH,2
	MOV DL, CHARACTER
	INT 21H
POP DX
POP AX
ENDM

READ_STRING MACRO STRING
LOCAL READING,END_READ
PUSH AX
PUSH SI

MOV SI,0
READING:
	MOV AH,1
	INT 21H
	CMP AL,0DH
	JE END_READ
	MOV STRING[SI],AL
	INC SI
	JMP READING
END_READ:
POP SI
POP AX
ENDM

READ_CHARACTER MACRO CHARACTER
PUSH AX
	MOV AH,1
	INT 21H
	MOV CHARACTER,AL
POP AX
ENDM

VERIFICA_PRIMO MACRO NUMBER, MSJ_ES_PRIMO, MSJ_NO_ES_PRIMO
LOCAL BUSCA_PRIMO,ES_PRIMO,END_PRIMO
PUSH AX
PUSH BX
PUSH DX

	MOV AX,NUMBER
    MOV DX,0
    MOV BX,2 
    
    BUSCA_PRIMO:
    
    CMP BX,NUMBER
    JE  ES_PRIMO

    MOV DX,0
    MOV AX,NUMBER
    DIV BX
    INC BX  
    CMP DX,0
    JNE BUSCA_PRIMO

    MOV AH,9
    LEA DX,MSJ_NO_ES_PRIMO
    INT 21H
    JMP END_PRIMO
    
    ES_PRIMO:
    
    MOV AH,9
    LEA DX,MSJ_ES_PRIMO
    INT 21H
    
    END_PRIMO:

POP DX
POP BX
POP AX
ENDM