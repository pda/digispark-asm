; PORTB I/O addresses
.equ PINB,  0x16
.equ DDRB,  0x17
.equ PORTB, 0x18

.equ LED_INDEX, 1

.globl main
main:

  ; Set DDRB[1] to output
  SBI DDRB, LED_INDEX ; set bit in I/O register

loop:

  ; Set LED HIGH
  SBI PORTB, LED_INDEX ; set bit in I/O register
  LDI r20, 32 ; for busywait
  RCALL busywait

  ; Set LED LOW
  CBI PORTB, LED_INDEX ; set bit in I/O register
  LDI r20, 32 ; for busywait
  RCALL busywait

  RJMP loop

; busywait loop
; input: r20: controls how many iterations for outer loop.
busywait:
  PUSH r20
  PUSH r21
  PUSH r22

busywaitOuter:
  LDI r21, 0xFF
busywaitInner:
  LDI r22, 0xFF
busywaitInnerInner:
  DEC r22
  BRNE busywaitInnerInner
  DEC r21
  BRNE busywaitInner
  DEC r20
  BRNE busywaitOuter

  POP r22
  POP r21
  POP r20
  RET
