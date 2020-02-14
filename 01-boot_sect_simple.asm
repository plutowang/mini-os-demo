; Boot sector must be placed in a known, standard loaction,
; because BIOS does not know how to load the OS.
; The standard loaction is the first sector of disk
; i.e. cylinder 0, head 0, sector 0,
; the boot sector takes 512 bytes.

; To make sure that the "disk is bootable", the BIOS checks 
; that bytes 511 and 512 of the alleged boot sector are bytes `0xAA55`

; Note: x86 is little-endian
; `00 00 00 00 00 00 00 00 00 00 00 00 00 00 55 aa`

; Infinite loop
; in 16 bit x86
; 0x0000000000000000:  E9 FD FF    jmp 0
loop:
    jmp loop

; Fill with 510 zeros minus the size of previous code
; $: current address, position at the beginning of the line containing the expression
; $$: beginning of the current section
; ($−$$): current size of section, offset of this section
; db 510-($-$$) dup (0) in MASM
times 510-($-$$) db 0 ; 510-($-$$) bytes, all initialized to 0

; Magic number 
dw 0xaa55 