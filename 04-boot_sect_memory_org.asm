; The figure with the memory layout on page 14 of
; https://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf
; NOTE: the BIOS place boot sector at `0x7C00`

; Set starting address
[org 0x7c00]
; tty mode
mov ah, 0x0e

; Attempt 1
; Fails again
; Because it prints the memory address (i.e. pointer)
; not actual contents '1'
mov al, '1'
int 0x10
mov al, the_secret
int 0x10

; Attempt 2
; Success
; BIOS place the bootsector bunary at adress `0x7c00`
; Solved the memory offset problem with 'org'
mov al, '2'
int 0x10
mov al, [the_secret]
int 0x10

; Attempt 3
; Fails
; Because adding 0x7c00 twice
mov al, '3'
int 0x10
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10

; Attempt 4
; Still works
; Directly addressing memory by counting bytes
; is always going to work, but it's inconvenient
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