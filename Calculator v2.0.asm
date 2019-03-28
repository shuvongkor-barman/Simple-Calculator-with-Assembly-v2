TITLE: A simple Calculator

.MODEL SMALL
.STACK 100H


.DATA

INTRO DB "   Calculator v2.0",10,13
          DB " ---------------------------------",10,13 
          DB " - Use '+' For Addition          -",10,13
          DB " - Use '-' For Subtraction       -",10,13
          DB " - Use '*' For Multiplication    -",10,13
          DB " - Use '/' For Division          -",10,13
          DB " - Use '2' For Square            -",10,13
          DB " - Type 'h' For Help             -",10,13          
          DB " - Enter 'y' For EXIT            -",10,13          
          DB " ---------------------------------",10,13, "$"         

HELP DB " --------------- HELP -------------------", 10,13
     DB " - First Enter a number                 -", 10,13
     DB " - Then Enter an operator               -", 10,13
     DB " - Then Enter another number            -", 10,13
     DB " - For Square just enter a number AND 2 -", 10,13 
     DB " ----------------------------------------", 10,13, "$"



NUM3 DW ?
NUM4 DW ?
Quotient DB "Quotient: $" 
Remainder DB "Remainder: $"
NEWLINE DB 10,13, "$"

.CODE
 MAIN PROC
    
      MOV AX, @DATA
      MOV DS, AX
      
      MOV AH,9
      LEA DX, INTRO
      INT 21H
    

LOOPER:

        MOV AH,1
        INT 21h
        
        MOV BX, AX 
        
        
        
        CMP AL, "y"
        JE EXIT
        CMP AL, "Y"
        JE EXIT
        
        CMP AL, "h"
        JE @HELP 
        CMP AL, "H"
        JE @HELP
        
        
        
        MOV AH,1
        INT 21H
        
        CMP AL, "+"
        JE ADDER
        
        CMP AL, "-"
        JE SUBER
        
        CMP AL, "*"
        JE MULER 
        
        CMP AL, "/"
        JE DIVER
        
        CMP AL, "2"
        JE SQUARE
        




ADDER:

        MOV AH,1
        INT 21h
        
        MOV BH, 0
        
        ADD AX, BX
        MOV AH, 0
        AAA
        
        ADD AL, 48
        ADD AH, 48
        MOV BX, AX
        

        
        MOV AH,9
        LEA DX, NEWLINE
        INT 21H
       
        
        MOV AH,2
        MOV DL, BH
        INT 21H
     
        MOV AH,2
        MOV DL, BL
        INT 21H        

        
        JMP BOTTOM


SUBER:

    MOV AH,1
    INT 21h
    
    SUB BL, AL
    
    ADD BL, 48
    
   
    MOV AH,2
    MOV DL,10
    INT 21H
    MOV AH,2
    MOV DL,13
    INT 21H
    
    
    MOV AH,2
    MOV DL, BL
    INT 21H
    


    MOV AH,2
    MOV DL,10
    INT 21H
    MOV AH,2
    MOV DL,13
    INT 21H
    JMP BOTTOM
    


MULER:  
        MOV BH, 0
        SUB BX, 48
        
        MOV AH,1                  
        INT 21H
        
        
        MOV AH,0
               
        SUB AX, 48

        MUL BL
        AAM
        
        ADD AH, 48
        ADD AL, 48
        
        MOV BX, AX
        
        
        MOV AH,9
        LEA DX, NEWLINE
        INT 21H
 
        MOV AH,2
        MOV DL, BH
        INT 21H
     
        MOV AH,2
        MOV DL, BL
        INT 21H
        
        JMP BOTTOM



 DIVER:  
        MOV BH, 0
        SUB BX, 48        
        MOV NUM3, BX
        
        MOV AH,1               
        INT 21H
        
        SUB AL, 48
        MOV AH, 0
        
        
        MOV NUM4, AX
        
        MOV BX, NUM4
        MOV BH, 0
        
        MOV AX, NUM3
        MOV BX, NUM4
        
        DIV BL
        
        CMP AH, 0
        JNE FRACTION
 
        
        ADD AH, 48
        ADD AL, 48
        
        MOV BX, AX
        
        
        MOV AH,9
        LEA DX, NEWLINE
        INT 21H
 
        
        MOV AH,2
        MOV DL, BH
        INT 21H
     
        MOV AH,2
        MOV DL, BL
        INT 21H
        JMP BOTTOM
        
    
    
     FRACTION:
                
        ADD AH, 48
        ADD AL, 48
        
        MOV BX, AX
        
        MOV AH,9
        LEA DX, NEWLINE
        INT 21H
        LEA DX, Quotient
        INT 21H
        
                
        MOV AH,2
        MOV DL, BL
        INT 21H
        
        MOV AH,9
        LEA DX, NEWLINE
        INT 21H
        
        LEA DX, Remainder
        INT 21H
     
        MOV AH,2
        MOV DL, BH
        INT 21H
        
     JMP BOTTOM




 SQUARE: 
   
       
        MOV AH, 0
        MOV AX, BX
        SUB AX, 48
        
        MUL AX
        AAM
        
        ADD AH,48
        ADD AL, 48
        
        
        MOV BX, AX
        
        MOV AH,9
        LEA DX, NEWLINE
        INT 21H
        
        MOV AH,2
        MOV DL, BH
        INT 21H
     
        MOV AH,2
        MOV DL, BL
        INT 21H
        JMP BOTTOM


 
 
 @HELP:
 
      MOV AH,9
      LEA DX, NEWLINE
      INT 21H
      
      LEA DX, HELP
      INT 21H

BOTTOM:
        MOV AH,9
        LEA DX, NEWLINE
        INT 21H
  

LOOP LOOPER

 
EXIT:
      MOV AH,4CH
      INT 21H 
 
 
 
 
 

MAIN ENDP
 END MAIN



