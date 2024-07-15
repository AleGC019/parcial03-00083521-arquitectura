ORG 100H

SECTION .data

    msg1 db 'Parcial diferido de arquitectura$', 0
    opc1 db 'Para mostrar el triangulo presione 1$', 0
    ;opc4 db 'Presionar 2 para mostrar el cuadrado$', 0
    opc2 db 'Para mostrar la figura presione 2$', 0
    ;opc5 db 'Presionar 4 para mostrar la arania$', 0
    ;Pruebas
    opc3 db 'Para salir presione 3$', 0

    msg2 db 'Carlos Alejandro Gomez Campos 00083521$', 0

    msg3 db 'Ingresaste la opción para ver el triangulo.$', 0
    ;msg5 db 'Ingresaste la opción para ver el cuadrado.$', 0
    msg4 db 'Ingresaste la opción para ver la Kitty o la casa.$', 0
    ;msg7 db 'Ingresaste la opción para ver la arania.$', 0

    msg8 db 'Presiona la tecla S o s para continuar.$', 0

    msg9 db 'Ingresa una opcion: $', 0

    msg11 db '1. Regresar al menu principal$', 0

    msg12 db '3. Salir del programa$', 0

    msgFin db 'Fin del programa$', 0

SECTION .text


MAIN: 

    CALL MostrarMenu
    CALL EsperarTecla
    INT 20H

MostrarMenu2:

    CALL IniciarModoTexto

    MOV BH, 0 

    CALL ImprimirOpciones2

    CALL EsperarTecla

    CMP AL, '1'
    JE MostrarMenu

    CMP AL, '3'
    JE FIN


    JMP MostrarMenu2

    RET


ImprimirOpciones2:

    ; Primer mensaje
    MOV CH, 2 ;fila 10
    MOV CL, 20 ;columna 20

    ; Mover el cursor
    CALL MoverCursor

    ; Primer mensaje
    MOV AH, 09h
    MOV DX, msg11
    INT 21h

    ; Mover el cursor
    MOV CH, 6 ; Posicion de la opcion 1 fila 20
    CALL MoverCursor

    ; Primera opcion

    MOV AH, 09h
    MOV DX, msg12
    INT 21h
 
    ;Pedir opcion
    MOV CH, 22
    CALL MoverCursor

    ;Mensaje de pedir opcion
    MOV AH, 09h
    MOV DX, msg9
    INT 21h


    RET


MostrarMenu:

    CALL IniciarModoTexto

    MOV BH, 0 ;pagina 0
    
    CALL ImprimirOpciones ; Imprimir las opciones

    CALL EsperarTecla

    CMP AL, '1' ; Mostrar el triangulo
    JE Triangulo

    ;CMP AL, '2' ; Mostrar el cuadrado
    ;JE DibujarCuadradoMenu

    ;CMP AL, '3' ; Mostrar la figura
    ;JE Figura

    CMP AL, '2' ; Mostrar la figura
    ;JE Figura2Arania

    CMP AL, '3' ; Salir
    JE FIN

    JMP MostrarMenu

    RET

FIN:
    CALL IniciarModoTexto
    CALL CambiarPagina

    MOV BH, 1

    MOV CH, 10 
    MOV CL, 25 

    CALL MoverCursor

    MOV AH, 09h
    MOV DX, msgFin
    INT 21h

    INT 20h


CambiarPagina:

    MOV AH, 05h  ; Funcion para cambiar pagina
    MOV AL, 1    ; Cambiar a la pagina 1
    INT 10h 

    RET


IniciarModoTexto:
    MOV AH, 00h ;funcion que establece el modo texto
    MOV AL, 03h ;Establece modo texto 80x25
    int 10h ;Llama a la interrupcion del bios para cambiar el modo texto
    ret

IniciarModoGrafico:
    MOV AH, 00H ;modo grafico
    MOV AL, 12H ;vga 640x480
    INT 10H
    ret

ImprimirOpciones:
    ; Primer mensaje
    MOV CH, 2 ;fila 10
    MOV CL, 20 ;columna 20

    ; Mover el cursor
    CALL MoverCursor

    ; Primer mensaje
    MOV AH, 09h
    MOV DX, msg1
    INT 21h

    ; Mover el cursor
    MOV CH, 6 ; Posicion de la opcion 1 fila 20
    CALL MoverCursor

    ; Primera opcion

    MOV AH, 09h
    MOV DX, opc1
    INT 21h

    ; Mover el cursor
    MOV CH, 10; Posicion de la opcion 2 fila 30
    CALL MoverCursor

    ; Tercera opcion
    MOV AH, 09h
    MOV DX, opc2
    INT 21h

    ; Mover el cursor
    MOV CH, 14 ; Posicion de la opcion 4 fila 50
    CALL MoverCursor

    ;Quinta opcion
    MOV AH, 09h
    MOV DX, opc3
    INT 21h

    ; Mover el cursor
    MOV CH, 18 ; Posicion de la opcion 6 fila 80
    CALL MoverCursor

    ; Mensaje final
    MOV AH, 09h
    MOV DX, msg2
    INT 21h

    ;Pedir opcion
    MOV CH, 22
    CALL MoverCursor

    ;Mensaje de pedir opcion
    MOV AH, 09h
    MOV DX, msg9
    INT 21h


    RET

MoverCursor:
    ; Funcion para mover y centrar el cursor
    MOV AH, 02h 

    MOV DH, CH ; Posicionar el cursor en la fila 10 (fila central)
    MOV DL, CL ; Posiciona el cursor en la columna 25 (columna central)

    INT 10h ; Interrupcion de BIOS para mover el cursor

    RET

EsperarTecla:
    ; Funcion para esperar a que se presione una tecla
    MOV AH, 00h 
    INT 16h ; Interrupcion BIOS para esperar a que se presione una tecla

    RET



Triangulo:
    CALL IniciarModoGrafico
    CALL CambiarPagina

    ; Posiciones iniciales

    MOV SI, 90d

    MOV DX, 70d ;En la fila 70 (46 hexa)
    MOV CX, 90d ;En la columna 90 (8c hexa)

    CALL ConstruirTriangulo

ConstruirTriangulo:

    MOV AH, 0CH  ;Peticion para escribir un punto
    MOV AL, 12H 
    MOV BH, 1 

    INT 10H

    CMP CX, SI
    JE Comparar

    INC CX
    JMP ConstruirTriangulo

Comparar:
    CMP DX, 240d
    JE FinConstruir

    MOV CX, 90d 

    INC SI
    INC DX

    JMP ConstruirTriangulo

FinConstruir:



    CALL EsperarTecla

    ;Imprimir mensaje 
    ;MOV AH, 09h
    ;MOV DX, msg8
    ;INT 21h

    CMP AL, 'S' ; Salir
    JE MostrarMenu2

    CMP AL, 's' ; Salir
    JE MostrarMenu2
