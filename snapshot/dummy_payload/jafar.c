#define write_csr(reg, val) ({ \
  asm volatile ("csrw " #reg ", %0" :: "rK"(val)); })

void jaber () {
	extern char trap_entry;
	write_csr(stvec, &trap_entry);
 asm volatile ("li x5, 0xfff\t\n");
 }
