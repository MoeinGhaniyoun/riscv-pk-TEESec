#include "enclave.h"

struct keystone_sbi_create TEESec_enclave;
struct keystone_sbi_create TEESec_enclave_2;
struct keystone_sbi_create TEESec_enclave_3;
struct keystone_sbi_create TEESec_enclave_4;


//Fuzzer_Added_Code_Start
void setup_enclave_args()
{
TEESec_enclave.epm_region.paddr = 0x80580000;
TEESec_enclave.epm_region.size = 0x500;
TEESec_enclave.utm_region.paddr = 0x80588000;
TEESec_enclave.utm_region.size = 0x100;
TEESec_enclave.runtime_paddr = 0x80580000;
TEESec_enclave.user_paddr = 0x80580100;
TEESec_enclave.free_paddr = 0x80580200;
TEESec_enclave.params.runtime_entry = 0x80580000;
TEESec_enclave.params.user_entry = 0x80580100;
TEESec_enclave.params.untrusted_ptr = 0x80588000;
TEESec_enclave.params.untrusted_size = 0x100;
TEESec_enclave.eid_pptr = (unsigned int *)0x80575000;
}