; The figure with the memory layout on page 14 of
; https://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf
; NOTE: the BIOS place boot sector at `0x7C00`

; tty mode
mov ah, 0x0e

; Attempt 1
; Fails
; Because it prints the memory address (i.e. pointer)
; not actual contents '1'
mov al, '1'
int 0x10
mov al, the_secret
int 0x10

; Attempt 2
; Fails
; It print the memory address correctly,
; However, BIOS place the bootsector bunary at adress `0x7c00`
; So we need to add that padding beforehand
mov al, '2'
int 0x10
mov al, [the_secret]
int 0x10

; Attempt 3
; Add the BIOS strating offset 0x7c00 to the memory address of 'X'
; and then dereference the contents of the pointer
; NOTE: 'mov al, [ax]' is illegal
; A register can't be used as source and destination for the same command.
mov al, '3'
int 0x10
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10

; Attempt 4
; We know that 'X' is stored at byte 0x2d
; That's smart but ineffective,
; we don't want to be recounting label offsets
; every time we change the code
mov al, '4'
int 0x10
mov al, [0x7c2d]
int 0x10


jmp $                       ; jump to current address
                            ; infinite loop

the_secret:
    ; ASCII code 'X' i.e. 0x58 is stored just before the zero-padding
    ; On this code is at byte 0x2d
    ; check using `xxd file.bin`
    db "X"

times 510-($-$$) db 0       ; padding
dw 0xaa55                   ; magic number