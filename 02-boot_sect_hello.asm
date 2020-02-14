mov ah, 0x0e            ; ah is higher part of ax
                        ; tty mode
                        ; we use service 0x0e
                        ; (Write Character in Teletype TTY Mode)
                        ; of BIOS interrupt 0x10 (Video and Screen Services)
mov al, 'H'             ; al is lower part of ax
int 0x10                ; raise interrupt `0x10` which is a
                        ; general interrupt for video services
                        ; INT 10H
                        ; Teletype output
                        ; AH=0Eh
                        ; AL = Character, BH = Page Number, BL = Color (only in graphic mode)
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
int 0x10                ; 'l' is still on al
mov al, 'o'
int 0x10

jmp $                   ; jump to current address
                        ; infinite loop

times 510-($-$$) db 0   ; padding
dw 0xaa55               ; magic number