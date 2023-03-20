#include "encoding.h"

  .section ".enclavedata_1","a",@progbits
  .align RISCV_PGSHIFT + RISCV_PGLEVEL_BITS

  .globl _enclave_1_start, _enclave_1_end
_enclave_1_start:
  .incbin "jooz"
_enclave_1_end:
