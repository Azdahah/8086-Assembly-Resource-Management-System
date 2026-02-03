.MODEL SMALL
.STACK 100H

.DATA
    
    filename        DB 'record.txt', 0
    filehandle      DW ?
    buffer          DB 100 DUP('$')
    
    
    menu_msg        DB 0DH, 0AH, 0DH, 0AH, '--- REMOTE AREA DATABASE ---', 0DH, 0AH
                    DB '1. Add New Record', 0DH, 0AH
                    DB '2. Show Totals', 0DH, 0AH
                    DB '3. Exit', 0DH, 0AH
                    DB 'Enter Choice: $'
                    
    prompt_id       DB 0DH, 0AH, 'Enter Sr# (1-9): $'
    prompt_name     DB 0DH, 0AH, 'Enter Name: $'
    prompt_fam      DB 0DH, 0AH, 'Family Members (Num): $' 
    prompt_water    DB 0DH, 0AH, 'Water (Liters): $'
    prompt_flour    DB 0DH, 0AH, 'Flour (Kg): $'
    prompt_pulse    DB 0DH, 0AH, 'Pulses (Kg): $'
    
    err_dup         DB 0DH, 0AH, 'ERROR: Duplicate Sr# Not Allowed!$'
    msg_saved       DB 0DH, 0AH, 'Record Saved to File Successfully!$'
    
    msg_totals      DB 0DH, 0AH, '--- TOTAL CONSUMPTION STATS ---', 0DH, 0AH, '$'
    lbl_mem         DB 'Total Members: $'
    lbl_wat         DB ' | Total Water: $'
    lbl_flo         DB 0DH, 0AH, 'Total Flour:   $'
    lbl_pul         DB ' | Total Pulses: $'
    
    newline         DB 0DH, 0AH, '$'
    comma           DB ', $'
    
    existing_ids    DB 10 DUP(0)
    id_count        DW 0
    
    curr_id         DB ?
    curr_name       DB 20 DUP('$')
    curr_fam        DW ?
    curr_wat        DW ?
    curr_flo        DW ?
    curr_pul        DW ?
    
    total_fam       DW 0
    total_wat       DW 0
    total_flo       DW 0
    total_pul       DW 0

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AH, 3CH
    LEA DX, filename
    MOV CX, 0
    INT 21H
    MOV filehandle, AX
    
    MOV AH, 3EH         
    MOV BX, filehandle
    INT 21H

MENU_LOOP:
    LEA DX, menu_msg
    MOV AH, 09H
    INT 21H
    
    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    
    CMP AL, 1
    JE CALL_ADD_RECORD
    CMP AL, 2
    JE CALL_SHOW_TOTALS
    CMP AL, 3
    JE EXIT_PROG
    JMP MENU_LOOP

CALL_ADD_RECORD:
    CALL ADD_RECORD
    JMP MENU_LOOP

CALL_SHOW_TOTALS:
    CALL SHOW_TOTALS
    JMP MENU_LOOP

EXIT_PROG:
    MOV AH, 4CH
    INT 21H
MAIN ENDP

ADD_RECORD PROC
    
    LEA DX, prompt_id
    MOV AH, 09H
    INT 21H
    
    CALL INPUT_NUM
    MOV curr_id, AL
   
    LEA SI, existing_ids
    MOV CX, id_count
    CMP CX, 0
    JE NO_DUPLICATE
    
CHECK_LOOP:
    MOV BL, [SI]
    CMP BL, curr_id
    JE FOUND_DUPLICATE
    INC SI
    LOOP CHECK_LOOP
    JMP NO_DUPLICATE

FOUND_DUPLICATE:
    LEA DX, err_dup
    MOV AH, 09H
    INT 21H
    RET

NO_DUPLICATE:
    LEA SI, existing_ids
    ADD SI, id_count
    MOV AL, curr_id
    MOV [SI], AL
    INC id_count

    LEA DX, prompt_name
    MOV AH, 09H
    INT 21H
    
    LEA DI, curr_name
    MOV CX, 10
READ_NAME:
    MOV AH, 01H
    INT 21H
    CMP AL, 0DH
    JE END_NAME
    MOV [DI], AL
    INC DI
    LOOP READ_NAME
END_NAME:
    MOV BYTE PTR [DI], '$'

    LEA DX, prompt_fam
    MOV AH, 09H
    INT 21H
    CALL INPUT_NUM      
    MOV curr_fam, AX
    ADD total_fam, AX

    LEA DX, prompt_water
    MOV AH, 09H
    INT 21H
    CALL INPUT_NUM
    MOV curr_wat, AX
    ADD total_wat, AX

    LEA DX, prompt_flour
    MOV AH, 09H
    INT 21H
    CALL INPUT_NUM
    MOV curr_flo, AX
    ADD total_flo, AX
    
    LEA DX, prompt_pulse
    MOV AH, 09H
    INT 21H
    CALL INPUT_NUM
    MOV curr_pul, AX
    ADD total_pul, AX

    MOV AH, 3DH
    LEA DX, filename
    MOV AL, 1
    INT 21H
    MOV filehandle, AX

    MOV AH, 42H
    MOV BX, filehandle
    MOV CX, 0
    MOV DX, 0
    MOV AL, 2
    INT 21H

    MOV AX, 0
    MOV AL, curr_id
    CALL WRITE_NUM_TO_FILE
    CALL WRITE_COMMA
    
    MOV AX, curr_fam
    CALL WRITE_NUM_TO_FILE
    CALL WRITE_COMMA

    MOV AX, curr_wat
    CALL WRITE_NUM_TO_FILE
    CALL WRITE_NEWLINE

    MOV AH, 3EH
    MOV BX, filehandle
    INT 21H

    LEA DX, msg_saved
    MOV AH, 09H
    INT 21H

    RET
ADD_RECORD ENDP

SHOW_TOTALS PROC
    LEA DX, msg_totals
    MOV AH, 09H
    INT 21H
    
    LEA DX, lbl_mem
    MOV AH, 09H
    INT 21H
    MOV AX, total_fam
    CALL PRINT_NUM
    
    LEA DX, lbl_wat
    MOV AH, 09H
    INT 21H
    MOV AX, total_wat
    CALL PRINT_NUM
    
    LEA DX, lbl_flo
    MOV AH, 09H
    INT 21H
    MOV AX, total_flo
    CALL PRINT_NUM
    
    LEA DX, lbl_pul
    MOV AH, 09H
    INT 21H
    MOV AX, total_pul
    CALL PRINT_NUM
    
    LEA DX, newline
    MOV AH, 09H
    INT 21H
    RET
SHOW_TOTALS ENDP

INPUT_NUM PROC
    PUSH BX
    PUSH CX
    PUSH DX        
    
    MOV BX, 0      
    MOV CX, 10     
    
INPUT_LOOP:
    MOV AH, 01H
    INT 21H
    
    CMP AL, 0DH    
    JE END_INPUT
    
    CMP AL, '0'
    JB INPUT_LOOP  
    CMP AL, '9'
    JA INPUT_LOOP  
 
    SUB AL, 30H    
    MOV AH, 0
    
    PUSH AX        
    MOV AX, BX     
    MUL CX         
    MOV BX, AX      
    POP AX         
    
    ADD BX, AX     
    JMP INPUT_LOOP
    
END_INPUT:
    MOV AX, BX     
    POP DX
    POP CX
    POP BX
    RET
INPUT_NUM ENDP

PRINT_NUM PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    CMP AX, 0      
    JNE NON_ZERO
    MOV DL, '0'
    MOV AH, 02H
    INT 21H
    JMP EXIT_PRINT

NON_ZERO:
    MOV CX, 0
    MOV BX, 10
    
SPLIT_DIGITS:
    MOV DX, 0
    DIV BX
    PUSH DX
    INC CX
    CMP AX, 0
    JNE SPLIT_DIGITS
    
PRINT_DIGITS:
    POP DX
    ADD DL, 30H
    MOV AH, 02H
    INT 21H
    LOOP PRINT_DIGITS

EXIT_PRINT:
    POP DX
    POP CX
    POP BX
    POP AX
    RET
PRINT_NUM ENDP

WRITE_NUM_TO_FILE PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    CMP AX, 0
    JNE F_NON_ZERO
    MOV buffer, '0'
    JMP F_WRITE_SINGLE

F_NON_ZERO:
    MOV CX, 0
    MOV BX, 10
F_SPLIT:
    MOV DX, 0
    DIV BX
    PUSH DX
    INC CX
    CMP AX, 0
    JNE F_SPLIT
    
F_WRITE:
    POP DX
    ADD DL, 30H
    MOV [buffer], DL 
    PUSH CX
    JMP DO_WRITE
    
F_WRITE_SINGLE:
    MOV CX, 1
    JMP DO_WRITE_FINAL

DO_WRITE:
    MOV AH, 40H
    MOV BX, filehandle
    MOV CX, 1
    LEA DX, buffer
    INT 21H
    POP CX
    LOOP F_WRITE
    JMP F_END

DO_WRITE_FINAL:
    MOV AH, 40H
    MOV BX, filehandle
    MOV CX, 1
    LEA DX, buffer
    INT 21H

F_END:
    POP DX
    POP CX
    POP BX
    POP AX
    RET
WRITE_NUM_TO_FILE ENDP

WRITE_COMMA PROC
    MOV buffer, ','
    MOV AH, 40H
    MOV BX, filehandle
    MOV CX, 1
    LEA DX, buffer
    INT 21H
    RET
WRITE_COMMA ENDP

WRITE_NEWLINE PROC
    MOV buffer, 0DH
    MOV AH, 40H
    MOV BX, filehandle
    MOV CX, 1
    LEA DX, buffer
    INT 21H
    
    MOV buffer, 0AH
    MOV AH, 40H
    MOV BX, filehandle
    MOV CX, 1
    LEA DX, buffer
    INT 21H
    RET
WRITE_NEWLINE ENDP

END MAIN