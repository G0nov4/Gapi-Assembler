;macro
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

PRINT_STRING MACRO STRING
PUSH AX
PUSH DX
	MOV AH,9
	LEA DX, STRING
	INT 21H
POP DX
POP AX
ENDM

; Programa que leer un archivo
.model small
.stack 64
.data
	filename db "pruebaArchivo.md",0

	handle dw ?
	msj db 100 dup('$')
	ln db 10,13
	mensajeError db "[!] Error...$"
.code

Inicio:
	mov ax,@data
	mov ds,ax

;=========================================
;Crear archivo
	;mov ah,3ch ; 				Funcion de creador de archivos
	;mov cx,0;					
	;mov dx,offset filename;		filename = nombre del archivo
	;int 21h			
	;jc lecturaError
	;mov handle,ax

;Abrir archivo
	mov al,2
	mov dx,offset  	
	mov ah,3dh
	int 21h
	jc lecturaError
	mov handle,ax
;escritura
	mov ah,40h
	mov bx,handle
	READ_STRING msj
	mov dx,offset msj
	mov cx,10
	int 21h

	je escrituraError

	jmp cerrarArchivo
;=========================================

cerrarArchivo:
	mov ah,3Eh
	mov bx,handle
	int 21h
	jc cerrarError

lecturaError:
	mov ah,12
	mov dx, offset mensajeError
	int 21h
cerrarError:
	mov ah,12
	mov dx, offset mensajeError
	int 21h
	jmp Salir 
escrituraError:
	mov ah,12
	mov dx, offset mensajeError
	int 21h
	jmp Salir 
Salir:
	mov ah,4ch
	int 21h

end Inicio