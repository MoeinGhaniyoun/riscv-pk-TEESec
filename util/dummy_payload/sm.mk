sm_hdrs = \
  sm.h \
  sm-sbi.h \

sm_c_srcs = \
  sm.c \
  sm-sbi.c \
  cpu.c \
  thread.c \
  pmp.c \
  enclave.c \
  crypto.c \
  attest.c \
  sha3/sha3.c \
  ed25519/keypair.c \
  ed25519/sign.c \
  ed25519/fe.c \
  ed25519/ge.c \
  ed25519/sc.c \
  hkdf_sha3_512/hkdf_sha3_512.c \
  hmac_sha3/hmac_sha3.c \
  platform/default/default.c \
	plugins/plugins.c \

sm_asm_srcs = \
  trap.S \
  mprv.S \

sm_test_srcs =

sm_install_prog_srcs =
