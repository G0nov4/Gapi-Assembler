;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;		Editor de Texto		;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Autores: 	Gary Omar Nova Mamani
; 			Pilar Sahonero Diaz
; Descripcion:	Editor de texto básico hecho en lenguaje ensamblador

.model small
.stack 64
.data
	
	color db 34h
	lineas db 0
	fini db 0
	cini db 0
	ffin db 24
	cfin db 79
	

.code

Inicio:
	mov ax,@data
	mov ds, ax
;---------------------------
	call clrscr
	jmp salir
	

salir:	
	
;---------------------------
	mov ah,4ch
	int 21h
;---proc	
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

end Inicio
