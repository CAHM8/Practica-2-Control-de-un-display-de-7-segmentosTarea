PROCESSOR 16F887 ;aqui declaramos el microcontrolador
    
    #include <xc.inc>   ;incluimos la libreria
    CONFIG FOSC=INTRC_NOCLKOUT ;se selecciona el osc
 
    CONFIG WDTE=OFF
    CONFIG PWRTE=ON
    CONFIG MCLRE=OFF
    CONFIG CP=OFF
    CONFIG CPD=OFF
    CONFIG BOREN=OFF
    CONFIG IESO=OFF
    CONFIG FCMEN=OFF
    CONFIG LVP=OFF
    CONFIG DEBUG=ON
    
    CONFIG BOR4V=BOR40V
    CONFIG WRT=OFF
     
    
    PSECT udata
mask:
    DS 1
cont:
    ds 1
    
PSECT resetVEC,class=CODE, delta=2
resetvec:
    PAGESEL main
    goto main
    
    ;registro de bits de encendido
    PSECT code
 num0:
    BANKSEL PORTA 
    clrf PORTA
    BANKSEL TRISA
    clrf TRISA
    movlw 0b11111100
    movwf PORTA
    nop
    PAGESEL main
    return
    
    PSECT code
 num1:
    BANKSEL PORTA 
    clrf PORTA
    BANKSEL TRISA
    clrf TRISA
    movlw 0b01100000
    movwf PORTA
    nop
    PAGESEL main
    return
    
    PSECT code
 num2:
    BANKSEL PORTA 
    clrf PORTA
    BANKSEL TRISA
    clrf TRISA
    movlw 0b11011010 ;encendemos a,b,d,e y g
    movwf PORTA
    nop
    PAGESEL main
    return
    
    PSECT code
 num3:
    BANKSEL PORTA 
    clrf PORTA
    BANKSEL TRISA
    clrf TRISA
    movlw 0b11110010 ;encendemos a,b,c,d y g
    movwf PORTA
    nop
    PAGESEL main
    return
    
    PSECT code
 num4:
    BANKSEL PORTA 
    clrf PORTA
    BANKSEL TRISA
    clrf TRISA
    movlw 0b01100110 ;encendemos b,c,f y g
    movwf PORTA
    nop
    PAGESEL main
    return
    
    PSECT code
 num5:
    BANKSEL PORTA 
    clrf PORTA
    BANKSEL TRISA
    clrf TRISA
    movlw 0b10110110 ;encendemos a,c,d,f y g
    movwf PORTA
    nop
    PAGESEL main
    return
    
    PSECT code
 num6:
    BANKSEL PORTA 
    clrf PORTA
    BANKSEL TRISA
    clrf TRISA
    movlw 0b10111110 ;encendemos a,c,d,e,f,g
    movwf PORTA
    nop
    PAGESEL main
    return
    
    PSECT code
 num7:
    BANKSEL PORTA 
    clrf PORTA
    BANKSEL TRISA
    clrf TRISA
    movlw 0b11100000 ;encendemo a,b y c
    movwf PORTA
    nop
    PAGESEL main
    return
    ;este espacio en blanco está colocado al proposito
    PSECT code
 num8:
    BANKSEL PORTA 
    clrf PORTA
    BANKSEL TRISA
    clrf TRISA
    movlw 0b11111110 ;encendemos a,b,c,d,e,f y g
    movwf PORTA
    nop
    PAGESEL main
    return
    
    PSECT code
 num9:
    BANKSEL PORTA 
    clrf PORTA
    BANKSEL TRISA
    clrf TRISA
    movlw 0b11110110 ;encendemos a,b,c,f y g
    movwf PORTA
    nop
    PAGESEL main
    return
    
    ;conteo-"timer" 500ms
    PSECT code
 pausa:
    bcf STATUS,6
    bcf STATUS,5
    movlw 0b00000001
    movwf 0x20
    nop
    suma:
    incfsz 0x20,f
    goto suma
    bcf STATUS,6
    bcf STATUS,5
    movlw 0b00000001
    movwf 0x21
    nop
    suma1:
    incfsz 0x21,f
    goto suma1
    bcf STATUS,6
    bcf STATUS,5
    movlw 0b00000001
    movwf 0x22
    nop
    suma2:
    incfsz 0x22,f
    btfss 0x22,3
    goto suma2
    nop
    return
    
    ;COdigo principal
    PSECT code
    main:
    BANKSEL ANSELH
    CLRF ANSELH
    BANKSEL PORTA 
    clrf PORTA
    BANKSEL TRISA
    clrf TRISA
    BANKSEL OSCCON
    movlw   0b01100101 ;seleccionamos el oscilador interno de 4MHz    
    movwf   OSCCON
    
;cambios de numero en pantalla
    loop:
    PAGESEL num0
    call num0
    call pausa
    call num1
    call pausa
    call num2
    call pausa
    call num3
    call pausa
    call num4
    call pausa
    call num5
    call pausa 
    call num6
    call pausa
    call num7
    call pausa
    call num8
    call pausa
    call num9
    call pausa
   nop
    goto loop
    END
