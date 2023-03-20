dummy_payload_subproject_deps = \
	sm \
	util \
	machine \

dummy_payload_hdrs = \
	boot.h \
	elf.h \
	file.h \
	frontend.h \
        mmap.h \
	pk.h \
	syscall.h \

dummy_payload_c_srcs = \
	file.c \
	syscall.c \
	handlers.c \
	frontend.c \
	elf.c \
	console.c \
	mmap.c \
	enclave_args.c \
	setstvec.c \
	pk.c \

dummy_payload_asm_srcs = \
  dummy_entry.S \

dummy_payload_test_srcs =

dummy_payload_install_prog_srcs = \
  	dummy_payload.c \

