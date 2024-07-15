ORG 100H

;Opciones a mostrar
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

;Funcion del programa principal
MAIN: 

    CALL MostrarMenu
    CALL EsperarTecla
    INT 20H
;Menu secundario al selccionar 1 o 2
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
;Opciones secundario al selccionar 1 o 2
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
    MOV CH, 6 ; posicion de la opcion 1 fila 20
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
;Menu principal del prgrama
MostrarMenu:

    CALL IniciarModoTexto

    MOV BH, 0 ;pagina 0
    
    CALL ImprimirOpciones ; Imprimir las opciones

    CALL EsperarTecla

    CMP AL, '1' ; Mostrar el triangulo
    JE Triangulo

    CMP AL, '2' ; Mostrar el cuadrado
    JE Figura

    ;CMP AL, '3' ; Mostrar la figura
    ;JE Figura

    CMP AL, '2' ; Mostrar la figura
    ;JE Figura2Arania

    CMP AL, '3' ; Salir
    JE FIN

    JMP MostrarMenu

    RET
;Termianr programa
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
;Cambiar de pagina que se muestra
CambiarPagina:

    MOV AH, 05h  ; Funcion para cambiar pagina
    MOV AL, 1    ; Cambiar a la pagina 1
    INT 10h 

    RET
;Inicio modo texto
IniciarModoTexto:
    MOV AH, 00h ;funcion que establece el modo texto
    MOV AL, 03h ;Establece modo texto 80x25
    int 10h ;Llama a la interrupcion del bios para cambiar el modo texto
    ret
;Inicio modo grafico
IniciarModoGrafico:
    MOV AH, 00H ;modo grafico
    MOV AL, 12H ;vga 640x480
    INT 10H
    ret
;Imprimir opciones principales
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
;Mover cursos dependiendo de la posicion
MoverCursor:
    ; Funcion para mover y centrar el cursor
    MOV AH, 02h 

    MOV DH, CH ; Posicionar el cursor en la fila 10 (fila central)
    MOV DL, CL ; Posiciona el cursor en la columna 25 (columna central)

    INT 10h ; Interrupcion de BIOS para mover el cursor

    RET
;Teclad de ingreso
EsperarTecla:
    ; Funcion para esperar a que se presione una tecla
    MOV AH, 00h 
    INT 16h ; Interrupcion BIOS para esperar a que se presione una tecla

    RET
;Parametros del triangulo
Triangulo:
    CALL IniciarModoGrafico
    CALL CambiarPagina

    ; Posiciones iniciales

    MOV SI, 90d

    MOV DX, 70d ;En la fila 70 (46 hexa)
    MOV CX, 90d ;En la columna 90 (8c hexa)

    CALL ConstruirTriangulo
;Construir en base a los parametros 
ConstruirTriangulo:
    

    MOV AH, 0CH  ;Peticion para escribir un punto
    MOV AL, 12H 
    MOV BH, 1 

    INT 10H

    CMP CX, SI
    JE Comparar

    INC CX
    JMP ConstruirTriangulo
;Delimitar el triangulo
Comparar:
    CMP DX, 240d
    JE FinConstruir

    MOV CX, 90d 

    INC SI
    INC DX

    JMP ConstruirTriangulo
;Para construir la figura que se necesite
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

    JMP FinConstruir
;Parametros para modo video
IniciarModoVideo:
  MOV AH, 0h
  MOV AL, 12h      ; Modo gráfico 640x480, 16 colores
  INT 10h
  RET
;Elementos base para elaboracion de figura
Figura:

    MOV SI, 60d ; Columna inicial
    MOV DI, 60d ; Fila inicial

    MOV BH, 1d ; Cambia a la página 2

    CALL IniciarModoVideo
    CALL CambiarPagina

    ; ----------- CARA RECTANGULO ------------

    MOV BP, 200d      ; Fin Columna
    MOV BX, 60d       ; Inicio Columna

    MOV AL, 0110b   

    CALL DibujarCuadrado

    ; ----------- OREJA 1  IZQUIERDA ------------

    MOV SI, 60d       ; Inicio de la columna 
    MOV DI, 60d      ; Inicio de la fila

    MOV BP, 60d       ; Inicio Columna
    MOV BX, 105d       ; Fin Columna

    CALL DibujarTriangulo
    
    ; ----------- OREJA 2 DERECHA ------------

    MOV SI, 155d       ; Inicio de la columna 
    MOV DI, 60d        ; Inicio de la fila

    MOV BP, 155d       ; Inicio Columna
    MOV BX, 200d       ; Fin Columna

    CALL DibujarTriangulo

    ; ----------- OJO IZQUIERDO  ------------

    MOV SI, 85d ; Contador columna inicial
    MOV DI, 85d ; Contador fila inicial

    MOV BP, 105d ; Columna final
    MOV BX, 85d  ; Reinicio de la columna

    MOV AL, 0h    


    CALL DibujarRectangulo

    ; ----------- OJO DERECHO  ------------

    MOV SI, 155d ; Contador columna inicial
    MOV DI, 85d ; Contador fila inicial

    MOV BP, 175d ; Columna final
    MOV BX, 155d  ; Reinicio de la columna

    CALL DibujarRectangulo

    ; ----------- BIGOTE 1 IZQUIERDO ------------

    MOV AL, 1000b 

    MOV SI, 30d ; Contador columna inicial
    MOV DI, 150d ; Fila de la linea

    MOV BP, 90d  ;  Limite de la columna

    CALL Pataarania

    ; ----------- BIGOTE 2 IZQUIERDO ------------

    MOV SI, 30d ; Contador columna inicial
    MOV DI, 160d ; Fila de la linea

    MOV BP, 90d  ;  Limite de la columna

    CALL Pataarania

    ; ----------- BIGOTE 5 IZQUIERDO ------------

    MOV SI, 30d ; Contador columna inicial
    MOV DI, 140d ; Fila de la linea

    MOV BP, 90d  ;  Limite de la columna

    CALL Pataarania

    ; ----------- BIGOTE 7 IZQUIERDO ------------

    MOV SI, 30d ; Contador columna inicial
    MOV DI, 130d ; Fila de la linea

    MOV BP, 90d  ;  Limite de la columna

    CALL Pataarania

     ; ----------- BIGOTE 9 IZQUIERDO ------------

    MOV SI, 30d ; Contador columna inicial
    MOV DI, 120d ; Fila de la linea

    MOV BP, 90d  ;  Limite de la columna

    CALL Pataarania

    ; ----------- BIGOTE 3 DERECHO ------------

    MOV SI, 170d ; Contador columna inicial
    MOV DI, 150d ; Fila de la linea

    MOV BP, 225d  ;  Limite de la columna

    CALL Pataarania

    ; ----------- BIGOTE 4 DERECHO ------------

    MOV SI, 170d ; Contador columna inicial
    MOV DI, 160d ; Fila de la linea

    MOV BP, 225d  ;  Limite de la columna

    CALL Pataarania


    ; ----------- BIGOTE 6 DERECHO ------------

    MOV SI, 170d ; Contador columna inicial
    MOV DI, 140d ; Fila de la linea

    MOV BP, 225d  ;  Limite de la columna

    CALL Pataarania

       ; ----------- BIGOTE 8 DERECHO ------------

    MOV SI, 170d ; Contador columna inicial
    MOV DI, 130d ; Fila de la linea

    MOV BP, 225d  ;  Limite de la columna

    CALL Pataarania

       ; ----------- BIGOTE 10 DERECHO ------------

    MOV SI, 170d ; Contador columna inicial
    MOV DI, 120d ; Fila de la linea

    MOV BP, 225d  ;  Limite de la columna

    CALL Pataarania

    ; ----------- FIN ------------

    JMP FinConstruir

    RET
;Practicamente dibujar una linea
Pataarania:
  MOV AH, 0Ch       ; Función del BIOS para poner un píxel
  ; MOV BH, 1         ; Página de video 0

  MOV CX, SI        ; Coordenada X
  MOV DX, DI        ; Coordenada Y

  INT 10h           ; Enciende el píxel

  INC SI            ; Incrementa la columna
  CMP SI, BP       ; Compara la columna actual con el límite

  JNE Pataarania ; Continúa en la misma fila si no se alcanza el límite

  RET               ; Termina la función cuando el triangulo está completo
;Elemento para dibujar un cuadrado
DibujarCuadrado:
 ; Dibujar un rectangulo 
  MOV AH, 0Ch       ; Función del BIOS para poner un píxel

  MOV CX, SI        ; Coordenada X
  MOV DX, DI        ; Coordenada Y

  INT 10h           ; Enciende el píxel

  INC SI            ; Incrementa la columna
  CMP SI, BP      ; Compara la columna actual con el límite de 150
  JNE DibujarCuadrado ; Continúa en la misma fila si no se alcanza el límite

  ; Al alcanzar el límite de la fila, prepara la siguiente fila
  INC DI            ; Incrementa la fila
  MOV SI, BX       ; Reinicia la columna al inicio para la nueva fila

  CMP DI, BP      ; Compara la fila actual con el límite de 120
  JNE DibujarCuadrado ; Si no se alcanza el límite, continúa dibujando la fila
  RET               ; Termina la función cuando el rectángulo está completo
;Dibujar otro triangulo para la oreja
DibujarTriangulo:

 ; Dibujar un triangulo 
  MOV AH, 0Ch       ; Función del BIOS para poner un píxel
  MOV AL, 0110b     ; Color del píxel (blanco)

  ; MOV BH, 1         ; Página de video 0

  MOV CX, SI        ; Coordenada X
  MOV DX, DI        ; Coordenada Y

  INT 10h           ; Enciende el píxel

  INC SI            ; Incrementa la columna
  CMP SI, BX       ; Compara la columna actual con el límite actual de 105

  JNE DibujarTriangulo ; Continúa en la misma fila si no se alcanza el límite

  ; Al alcanzar el límite de la fila, prepara la siguiente fila
  DEC DI            ; Disminuyo la fila

  INC BP           ; Incremento el inicio de la linea
  DEC BX           ; Disminuyo el final linea

  MOV SI, BP       ; Reinicia la columna al inicio para la nueva fila

  CMP DI, 37d      ; Compara la fila actual con el límite de 40
  JNE DibujarTriangulo ; Si no se alcanza el límite, continúa dibujando la fila

  RET               ; Termina la función cuando el rectángulo está completo
;Dibujar rectangulo de la figura
DibujarRectangulo:
 ; Dibujar un rectangulo 
  MOV AH, 0Ch  
   MOV AL, 0111b      ; Función del BIOS para poner un píxel

  MOV CX, SI        ; Coordenada X
  MOV DX, DI        ; Coordenada Y

  INT 10h           ; Enciende el píxel

  INC SI            ; Incrementa la columna
  CMP SI, BP      ; Compara la columna actual con el límite de 150
  JNE DibujarRectangulo ; Continúa en la misma fila si no se alcanza el límite

  ; Al alcanzar el límite de la fila, prepara la siguiente fila
  INC DI            ; Incrementa la fila
  MOV SI, BX       ; Reinicia la columna al inicio para la nueva fila

  CMP DI, 100d      ; Compara la fila actual con el límite de 115d
  JNE DibujarRectangulo ; Si no se alcanza el límite, continúa dibujando la fila
  RET               ; Termina la función cuando el rectángulo está completo
;Codigo reciclado para hacer el gato
;Se tomo como base una arania
Figura2Arania:

    MOV SI, 105d ; Columna inicial
    MOV DI, 30d ; Fila inicial

    MOV BH, 1d ; Cambia a la página 2

    CALL IniciarModoVideo
    CALL CambiarPagina

    ; ----------- CABEZA  ------------

    MOV BP, 155d      ; Fin Columna
    MOV BX, 105d       ; Inicio Columna

    MOV AL, 0111b     ; Color del píxel (blanco)

    CALL DibujarCuadrado

    ; ----------- CUERPO  ------------


    MOV SI, 60d ; Columna inicial
    MOV DI, 60d ; Fila inicial


    MOV BP, 200d      ; Fin Columna
    MOV BX, 60d       ; Inicio Columna

    MOV AL, 0111b     ; Color del píxel (blanco)

    CALL DibujarCuadrado

     ; ----------- OJO 1  ------------

    MOV SI, 110d ; Contador columna inicial
    MOV DI, 30d ; Contador fila inicial

    MOV BP, 115d ; Columna final
    MOV BX, 110d  ; Reinicio de la columna

    MOV AL, 0h     ; Color del píxel

    CALL DibujarRectanguloArania

    ; ----------- OJO 2  ------------

    MOV SI, 145d ; Contador columna inicial
    MOV DI, 30d ; Contador fila inicial

    MOV BP, 150d ; Columna final
    MOV BX, 145d  ; Reinicio de la columna

    CALL DibujarRectanguloArania

      ; ----------- BIGOTE 1 ------------

    MOV AL, 1000b     ; Color del píxel (azul)

    MOV SI, 30d ; Contador columna inicial
    MOV DI, 90d ; Fila de la linea

    MOV BP, 105d  ;  Limite de la columna

    CALL Pataarania

    ; ----------- BIGOTE 2 ------------

    MOV SI, 30d ; Contador columna inicial
    MOV DI, 110d ; Fila de la linea

    MOV BP, 105d  ;  Limite de la columna

    CALL Pataarania

       ; ----------- BIGOTE 7 ------------

    MOV AL, 1000b     ; Color del píxel (azul)

    MOV SI, 30d ; Contador columna inicial
    MOV DI, 130d ; Fila de la linea

    MOV BP, 105d  ;  Limite de la columna

    CALL Pataarania

    ; ----------- BIGOTE 8 ------------

    MOV SI, 30d ; Contador columna inicial
    MOV DI, 150d ; Fila de la linea

    MOV BP, 105d  ;  Limite de la columna

    CALL Pataarania



    ; ----------- BIGOTE 3 ------------

    MOV SI, 155d ; Contador columna inicial
    MOV DI, 90d ; Fila de la linea

    MOV BP, 225d  ;  Limite de la columna

    CALL Pataarania

    ; ----------- BIGOTE 4 ------------

    MOV SI, 155d ; Contador columna inicial
    MOV DI, 110d ; Fila de la linea

    MOV BP, 225d  ;  Limite de la columna

    CALL Pataarania


     ; ----------- BIGOTE 5 ------------

    MOV SI, 155d ; Contador columna inicial
    MOV DI, 130d ; Fila de la linea

    MOV BP, 225d  ;  Limite de la columna

    CALL Pataarania

    ; ----------- BIGOTE 6 ------------

    MOV SI, 155d ; Contador columna inicial
    MOV DI, 150d ; Fila de la linea

    MOV BP, 225d  ;  Limite de la columna

    CALL Pataarania





    RET
;Dibujar rectangulo de la figura
DibujarRectanguloArania:
 ; Dibujar un rectangulo 
  MOV AH, 0Ch       ; Función del BIOS para poner un píxel

  ; MOV BH, 1         ; Página de video 0

  MOV CX, SI        ; Coordenada X
  MOV DX, DI        ; Coordenada Y

  INT 10h           ; Enciende el píxel

  INC SI            ; Incrementa la columna
  CMP SI, BP      ; Compara la columna actual con el límite de 150
  JNE DibujarRectanguloArania ; Continúa en la misma fila si no se alcanza el límite

  ; Al alcanzar el límite de la fila, prepara la siguiente fila
  INC DI            ; Incrementa la fila
  MOV SI, BX       ; Reinicia la columna al inicio para la nueva fila

  CMP DI, 40d      ; Compara la fila actual con el límite de 115d
  JNE DibujarRectanguloArania ; Si no se alcanza el límite, continúa dibujando la fila
  RET               ; Termina la función cuando el rectángulo está completo

