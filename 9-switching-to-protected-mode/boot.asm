ORG 0x7c00
BITS 16

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
_start:
  jmp short start
  nop

times 33 db 0

start:
  jmp 0:step2

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
  mov ss, ax
  mov sp, 0x7c00
  sti ; Enable interrupts

.load_protected:
  cli
  lgdt[gdt_descriptor]
  mov eax, cr0
  or eax, 0x1
  mov cr0, eax
  jmp CODE_SEG:load32
  

; GDT
gdt_start:
gdt_null:
  dd 0x0
  dd 0x0

; offset 0x8
gdt_code:   ; CS should point to this
  dw 0xffff ; Segement limit first 0-15 bits
  dw 0      ; Base 0-15 bits
  db 0      ; Base 16-23 bits
  db 0x9a   ; Access byte
  db 11001111b ; High 4 bit flags and the low 4 bit flags
  db 0      ; Base 24-31 bits

; offset 0x10
gdt_data:   ; DS, SS, ES, FS, GS should link to this
  dw 0xffff ; Segement limit first 0-15 bits
  dw 0      ; Base 0-15 bits
  db 0      ; Base 16-23 bits
  db 0x92   ; Access byte
  db 11001111b ; High 4 bit flags and the low 4 bit flags
  db 0      ; Base 24-31 bits

gdt_end:

gdt_descriptor:
  dw gdt_end - gdt_start - 1
  dd gdt_start

[BITS 32]
load32:
  mov ax, DATA_SEG
  mov ds, ax
  mov es, ax
  mov fs, ax
  mov gs, ax
  mov ss, ax
  mov ebp, 0x00200000
  mov esp, ebp
  jmp $

times 510-($ - $$) db 0
dw 0xAA55

