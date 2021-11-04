ORG 0
BITS 16

_start:
  jmp short start
  nop

times 33 db 0

start:
  jmp 0x7c0:step2

; AH = 02h
; AL = number of sectors to read (must be nonzero)
; CH = low eight bits of cylinder number
; CL = sector number 1-63 (bits 0-5)
; high two bits of cylinder (bits 6-7, hard disk only)
; DH = head number
; DL = drive number (bit 7 set for hard disk)
; ES:BX -> data buffer
; 
; Return:
; CF set on error
; if AH = 11h (corrected ECC error), AL = burst length
; CF clear if successful
; AH = status (see #00234)
; AL = number of sectors transferred (only valid if CF set for some BIOSes)

step2:
  cli ; clear interrupts
  mov ax, 0x7c0
  mov ds, ax
  mov es, ax
  mov ax, 0x00
  mov ss, ax
  mov sp, 0x7c00
  sti ; Enable interrupts
  
  mov ah, 2 ; read sector command
  mov al, 1 ; read obe sector
  mov ch, 0 ; Cylinder low eight bits
  mov cl, 2 ; Read sector 2
  mov dh, 0 ; head number
  mov bx, buffer
  int 0x13
  jc error ; jump on carry
  mov si, buffer
  call print
  jmp $
error:
  mov si, error_message
  call print
  jmp $

print:
  mov bx, 0
.loop:
  lodsb
  cmp al, 0
  je .done
  call print_char
  jmp .loop
.done:
  ret
  
print_char:
  mov ah, 0eh
  int 0x10
  ret

error_message: db 'Failed to load sector', 0
times 510-($ - $$) db 0
dw 0xAA55

buffer: