imprime MACRO cadena
push ax
push dx

 MOV AH,09
 MOV DX,OFFSET cadena

pop dx
pop ax
 INT 21H
ENDM

.model small
.stack
.data
	msj  DB 0AH, 0DH, 	'  		Menu 		','$'
	msj2  DB 0AH, 0DH, 	'1.- Crear Archivo  ','$'
	msj3 DB 0AH, 0DH, 	'2.- Abrir Archivo','$'
	msj4  DB 0AH, 0DH, 	'3.- Modificar Archivo','$'
	msj5  DB 0AH, 0DH, 	'4.- Eliminar Archivo','$'
	msj6  DB 0AH, 0DH, 	'5.- Salir','$'
	msj7  DB 0AH, 0DH, 	'Elegir opcion -------->','$'
	msjelim DB 0AH, 0DH, 'Archivo eliminado con exito','$'
	msjcrear DB 0AH, 0DH, 'Archivo creado con exito','$'
	msjescr DB 0AH, 0DH, 'Archivo escrito con exito','$'
	msjnom  DB 0AH, 0DH, 'Nombre del archivo:','$'
	cadena DB '  ','$'
	nombre DB 'Ejemplo_texto.txt',0
	vec  DB 50 DUP('$')
	imp  DB 50 DUP('$')
	handle DB 0
	linea DB 10,13,'$'
.code
inicio:
	mov ax,@data
	mov ds,ax
menu:
 imprime msj
 imprime msj2
 imprime msj3
 imprime msj4
 imprime msj5
 imprime msj6
 imprime msj7
 
 MOV  AH,0DH
 INT  21H
 MOV  AH,01H
 INT  21H
 CMP  AL,31H
 JE  crear
 CMP  AL,32H
 JE  abrir
 CMP  AL,33H
 JE  pedir
 CMP  Al,34H
 JE  eliminar
 CMP  Al,35H
 JE  salir
  
eliminar:
 MOV  AH,41H
 MOV  DX,OFFSET nombre
 INT  21H
 JC salir
 imprime msjelim
salir:
 MOV  AH,04CH
 INT  21H
crear:
 MOV  AX,@data
 MOV  DS,AX
 MOV  AH,3CH
 MOV  CX,0
 MOV  DX,OFFSET nombre
 INT  21H
 JC  salir
 MOV  BX,AX
 MOV  AH,3EH
 INT  21H
 JMP  menu
 
abrir:
 MOV  AH,3DH
 MOV  DX,OFFSET nombre
 INT  21H
 MOV  AH,3FH
 MOV  BX,AX
 MOV  CX,10
 MOV  SI,00H
 MOV  DX,OFFSET imp
 MOV  DL,imp[SI]
 INT  21H
 MOV  AH,09H
 INT  21H
 
 MOV  AH,3EH
 INT  21H
 JMP  menu
 
pedir:
 MOV  AH,01H
 INT  21H
 MOV  vec[SI],AL
 INC  SI
 CMP  AL,0DH
 JA  pedir
 JB  pedir
 
editar:
 MOV  AH,3DH
 MOV  AL,01H
 MOV  DX,OFFSET nombre
 INT  21H
 
 MOV  BX,AX
 MOV  CX,SI
 MOV  DX,OFFSET vec
 MOV  DX,OFFSET imp
 MOV  AH,40H
 INT  21H
 imprime msjescr
 
 MOV  AH,3EH
 INT  21H
 JMP  menu

 

END