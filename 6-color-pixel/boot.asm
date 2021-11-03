ORG 0
BITS 16

_start:
  jmp short start
  nop

times 33 db 0

start:
  jmp 0x7c0:step2

step2:
  cli ; clear interrupts
  mov ax, 0x7c0
  mov ds, ax
  mov es, ax
  mov ax, 0x00
  mov ss, ax
  mov sp, 0x7c00
  sti ; Enable interrupts
  sti
  mov si, message
  call print
  
  mov ah, 0x00
  mov al, 0x13
  int 0x10
  
  mov ah, 0xc
  mov al, 0xd
  xor bh, bh
  mov cx, 0x40
  mov dx, 0x40
loop:
  int 0x10
  dec dx
  dec cx
  test dx, dx
  jnz loop
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

message: db 'Hello world!', 0
times 510-($ - $$) db 0
dw 0xAA55