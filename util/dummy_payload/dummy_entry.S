#include "mcall.h"
#include "bits.h"
#include "encoding.h"
#define SBI_SM_CREATE_ENCLAVE    101
#define SBI_SM_DESTROY_ENCLAVE   102
#define SBI_SM_ATTEST_ENCLAVE    103
#define SBI_SM_GET_SEALING_KEY   104
#define SBI_SM_RUN_ENCLAVE       105
#define SBI_SM_STOP_ENCLAVE      106
#define SBI_SM_RESUME_ENCLAVE    107
#define SBI_SM_RANDOM            108
#define SBI_SM_EXIT_ENCLAVE     1101
#define SBI_SM_CALL_PLUGIN      1000
#define SBI_SM_NOT_IMPLEMENTED  1111



#define STACK_TOP_TEMP (_end + 4096) 
 .section ".text.init"
  .globl _start
_start:
# Test fast path for X0
  li x5, 0x80480000
  ld x4, 0(x5)
  and x6, x4, x0
  addi x6, x6, 15
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0


# Enclave supervisor code
  li x5, 0x80480000
  li x6, 0x000012b7
  sw x6, 0(x5)
  li x6, 0x0092829b
  sw x6, 4(x5)
  li x6, 0x01329293
  sw x6, 8(x5)
  li x6, 0x50028293
  sw x6, 12(x5)
  # li x6, 0x10529073
  li x6, 0x00000000 
  sw x6, 16(x5)
  #li x6, 0x10200072
  li x6, 0x00000000
  sw x6, 20(x5)

# Enclave supervisor trap entry code
  li x5, 0x80480500
  li x6, 0x06a00893
  sh x6, 0(x5)
  li x6, 0x4505
  sh x6, 4(x5)
  li x6, 0x00000073
  sw x6, 6(x5)


# Enclave user code
  li x5, 0x80481000
  li x6, 0x000802b7
  sw x6, 0(x5)
  li x6, 0x0012829b
  sw x6, 4(x5)
  li x6, 0x00c29293
  sw x6, 8(x5)
  li x6, 0x000013b7
  sw x6, 12(x5)
  li x6, 0x00b3839b
  sw x6, 16(x5)
  li x6, 0x01339393
  sw x6, 20(x5)
  li x6, 0x42343237
  sw x6, 24(x5)
  li x6, 0x4322021b
  sw x6, 28(x5)
  li x6, 0x736481b7
  sw x6, 32(x5)
  li x6, 0x7321819b
  sw x6, 36(x5)
  li x6, 0x0241c1bb
  sw x6, 40(x5)
  li x6, 0x0232c23b
  sw x6, 44(x5)
  li x6, 0x00521663
  sw x6, 48(x5)
  li x6, 0x0003b303
  sw x6, 52(x5)
  li x6, 0x0002b403
  sw x6, 56(x5)
  li x6, 0x9086
  sh x6, 60(x5)
  li x6, 0x4505
  sh x6, 62(x5)
  li x6, 0x00000073
  sw x6, 64(x5)

# Enclave_2 data
  li x4, 0x80580010
  li x5, 0xdeadbeef
  sd x5, 0(x4) 
  li x4, 150
  li x5, 0x80580020
  li x6, 0x2222222222222222
looop:  sd x6, 0(x5)
  addi x4, x4, -1
  addi x5, x5, 8
  bnez x4, looop



  li sp, 0x80473000
  jal pk_vm_init
  jal set_trap_vector


# Setup enclave arguments  
  jal setup_enclave_args
  la a0, argoman
  li a7, SBI_SM_CREATE_ENCLAVE
  ecall
  jal setup_enclave_args_2
  la a0, argoman_2
  li a7, SBI_SM_CREATE_ENCLAVE
  ecall

# Reading SM memory and enclave memory
  li a6, 0x80580010
  li a5, 0x80480010
  li a4, 0x44444444
  li a7, 0x77777777
  divw x5, a7, a4
  divw a4, a7, x5
  bne a4, a6, jafar
  ld a6, 0(a5)


# Run the first enclave
jafar:li a5, 0x80475000
  ld a5, 0(a5)
  mv a0, a5
  # li a7, SBI_SM_RUN_ENCLAVE
  # ecall

# Get a sense of legit root page table contents
li x7, 0x80272010
ld x7, 0(x7)
csrr x8, satp




# Load last byte of an adjacent page to enclave memory
adjacent:li a4, 0x8047ffff
  lb a5, 0(a4)


# Check timing difference for multiplier
Timing:li a4, 0x44444444
  li a5, 0x55555555
  li a0, 0x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  xor a5, a5, a4
  and a5, a5, a0
  xor a5, a5, a4
  add a5, a5, a0
  li a4, 0x44444444
  li a5, 0x55555555
  li a0, 0xffffffff
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  xor a5, a5, a4
  and a5, a5, a0
  xor a5, a5, a4
  add a5, a5, a0
  


# Jump to enclave memory
jmpEnclave:li x4, 0x80480000
  li a5, 0x80001000
  li a4, 0x44444444
  li a7, 0x77777777
  divw x5, a7, a4
  divw a3, a7, x5
  divw a3, a7, a3
  divw a3, a7, a3
  bne a3, x4, mallagh
  jalr x4
  
mallagh:divw a3, a7, a3
  divw a3, a7 ,a3
  bne a3, a6, mallagh2
  jalr x4

# Get the enclave data in the cache
mallagh2:li x4, 0x80480010
  li a5, 0x80880210
  li a4, 0x44444444
  li a7, 0x77777777
  divw x5, a7, a4
  divw a3, a7, x5
  divw a3, a7, a3
  divw a3, a7, a3
  bne a3, x4, mallagh3
  ld x5, 0(x4)
  ld x4, 0(a5)

# Change root page table to enclave memory
mallagh3:csrr x5, satp
  li x5, 0x8000000000080480
  csrw satp, x5
  li x5, 0x80780010
  li a5, 0x80880210
  li a4, 0x44444444
  li a7, 0x77777777
  divw a3, a5, a4
  divw a3, a7, a3
  divw a3, a7, a3
  bne a3, x5, mallagh4
  ld x5, 0(x5)
mallagh4:add x0, x0, x0
  add x0, x0, x0
  li a0, 0x0
  li a4, 0x2
  li a5, 0x4
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  xor a5, a5, a4
  and a5, a0, a5
  xor a5, a5, a4
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  li a0, 0xffffffffffffffff
  li a4, 0x2
  li a5, 0x4
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  xor a5, a5, a4
  and a5, a0, a5
  xor a5, a5, a4
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  li a5, 0x80784210
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
  add x0, x0, x0
# Destroy second enclave
  li a3, 0x80780440
  li a4, 0x44444444
  li a7, 0x77777777
  divw a7, a5, a4
  divw a4, a3, a4
  divw a7, a3, a4
  bne a3, a7, mallagh5
  ld a4, 0(a5)
  ld a5, 0(a3)

mallagh5:mv a0, a5
  li a7, SBI_SM_DESTROY_ENCLAVE
  ecall

  li x14, 0x80271000
  ld x14, 0(x14)
  csrr x15, stvec
  li x14, 0x80001000
  ld x14, 0(x14)
  li x15, 0xdeaddead
  la s0, str
1:
  lbu a0, (s0)
  beqz a0, 1f
  li a7, SBI_CONSOLE_PUTCHAR
  ecall
  add s0, s0, 1
  j 1b

1:
  li a7, SBI_SHUTDOWN
  ecall

.macro save_tf
  # save gprs
  STORE  x1,1*REGBYTES(x2)
  STORE  x3,3*REGBYTES(x2)
  STORE  x4,4*REGBYTES(x2)
  STORE  x5,5*REGBYTES(x2)
  STORE  x6,6*REGBYTES(x2)
  STORE  x7,7*REGBYTES(x2)
  STORE  x8,8*REGBYTES(x2)
  STORE  x9,9*REGBYTES(x2)
  STORE  x10,10*REGBYTES(x2)
  STORE  x11,11*REGBYTES(x2)
  STORE  x12,12*REGBYTES(x2)
  STORE  x13,13*REGBYTES(x2)
  STORE  x14,14*REGBYTES(x2)
  STORE  x15,15*REGBYTES(x2)
  STORE  x16,16*REGBYTES(x2)
  STORE  x17,17*REGBYTES(x2)
  STORE  x18,18*REGBYTES(x2)
  STORE  x19,19*REGBYTES(x2)
  STORE  x20,20*REGBYTES(x2)
  STORE  x21,21*REGBYTES(x2)
  STORE  x22,22*REGBYTES(x2)
  STORE  x23,23*REGBYTES(x2)
  STORE  x24,24*REGBYTES(x2)
  STORE  x25,25*REGBYTES(x2)
  STORE  x26,26*REGBYTES(x2)
  STORE  x27,27*REGBYTES(x2)
  STORE  x28,28*REGBYTES(x2)
  STORE  x29,29*REGBYTES(x2)
  STORE  x30,30*REGBYTES(x2)
  STORE  x31,31*REGBYTES(x2)

  # get sr, epc, badvaddr, cause
  csrrw  t0,sscratch,x0
  csrr   s0,sstatus
  csrr   t1,sepc
  csrr   t2,sbadaddr
  csrr   t3,scause
  STORE  t0,2*REGBYTES(x2)
  STORE  s0,32*REGBYTES(x2)
  STORE  t1,33*REGBYTES(x2)
  STORE  t2,34*REGBYTES(x2)
  STORE  t3,35*REGBYTES(x2)

  # get faulting insn, if it wasn't a fetch-related trap
  li x5,-1
  STORE x5,36*REGBYTES(x2)
1:
  .endm

  .text
  .align 2
  .global  trap_entry
trap_entry:
  csrrw sp, sscratch, sp
  bnez sp, 1f
  csrr sp, sscratch
1:addi sp,sp,-320
  save_tf
  move  a0,sp
  jal handle_trap

  mv a0,sp
  # don't restore sscratch if trap came from kernel
  andi s0,s0,SSTATUS_SPP
  bnez s0,start_user
  addi sp,sp,320
  csrw sscratch,sp


  .globl start_user
start_user:
  LOAD t0, 32*REGBYTES(a0)
  LOAD t1, 33*REGBYTES(a0)
  csrw sstatus, t0
  csrw sepc, t1

  # restore x registers
  LOAD  x1,1*REGBYTES(a0)
  LOAD  x2,2*REGBYTES(a0)
  LOAD  x3,3*REGBYTES(a0)
  LOAD  x4,4*REGBYTES(a0)
  LOAD  x5,5*REGBYTES(a0)
  LOAD  x6,6*REGBYTES(a0)
  LOAD  x7,7*REGBYTES(a0)
  LOAD  x8,8*REGBYTES(a0)
  LOAD  x9,9*REGBYTES(a0)
  LOAD  x11,11*REGBYTES(a0)
  LOAD  x12,12*REGBYTES(a0)
  LOAD  x13,13*REGBYTES(a0)
  LOAD  x14,14*REGBYTES(a0)
  LOAD  x15,15*REGBYTES(a0)
  LOAD  x16,16*REGBYTES(a0)
  LOAD  x17,17*REGBYTES(a0)
  LOAD  x18,18*REGBYTES(a0)
  LOAD  x19,19*REGBYTES(a0)
  LOAD  x20,20*REGBYTES(a0)
  LOAD  x21,21*REGBYTES(a0)
  LOAD  x22,22*REGBYTES(a0)
  LOAD  x23,23*REGBYTES(a0)
  LOAD  x24,24*REGBYTES(a0)
  LOAD  x25,25*REGBYTES(a0)
  LOAD  x26,26*REGBYTES(a0)
  LOAD  x27,27*REGBYTES(a0)
  LOAD  x28,28*REGBYTES(a0)
  LOAD  x29,29*REGBYTES(a0)
  LOAD  x30,30*REGBYTES(a0)
  LOAD  x31,31*REGBYTES(a0)
  # restore a0 last
  LOAD  x10,10*REGBYTES(a0)

  # gtfo
  sret



  .data
str:
  .asciz "This is bbl's dummy_payload.  To boot a real kernel, reconfigure\n\
bbl with the flag --with-payload=PATH, then rebuild bbl.\n"
