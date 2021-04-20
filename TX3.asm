title emisor
.model tiny
.code
org 100h

begin: jmp short main
temporal db ?

;procedimiento principal
main proc near
;parametros para ?conexion?
mov ah,00h
mov al,11100011b ;9600,no paridad,1bit de paro,8 bits de infor 
mov dx,03 ;la configuraci?n se aplicar? al puerto serie
int 14h

;la siguiente funci?n espera un caracter
espera:
mov ah, 08h
int 21h
mov temporal,al;en al esta el caracter tecleado
 
mov ah,02h ; funci?n para desplegar
mov dl,temporal 
int 21h

mov dx,0 ;Select COM1:
mov al,temporal
mov ah, 1           ;Receive opcode
int 14h
test ah,80h ;para probar que se haya hecho correcta la transmisi?n
jnz final ;sino brinca al final

jmp espera ;salto para esperar mas caracteres para enviar
final: mov ax,4c00h
int 21h
main endp
end begin