#include "enclave.h"

struct keystone_sbi_create argoman;
struct keystone_sbi_create argoman_2;
struct keystone_sbi_create argoman_3;
struct keystone_sbi_create argoman_4;

void  setup_enclave_args()
{
  // should return true
  argoman.epm_region.paddr = 0x80480000;
  argoman.epm_region.size = 0x4000;
  argoman.utm_region.paddr = 0x80488000;
  argoman.utm_region.size = 0x2000;
  argoman.runtime_paddr = 0x80480000;
  argoman.user_paddr = 0x80481000;
  argoman.free_paddr = 0x80482000;
  argoman.params.runtime_entry = 0x80480000;
  argoman.params.user_entry = 0x80481000;
  argoman.params.untrusted_ptr = 0x80488000;
  argoman.params.untrusted_size = 0x2000;
  argoman.eid_pptr = (unsigned int*)0x80475000;
}


void  setup_enclave_args_2()
{
  // should return true
  argoman_2.epm_region.paddr = 0x80580000;
  argoman_2.epm_region.size = 0x500;
  argoman_2.utm_region.paddr = 0x80588000;
  argoman_2.utm_region.size = 0x100;
  argoman_2.runtime_paddr = 0x80580000;
  argoman_2.user_paddr = 0x80580100;
  argoman_2.free_paddr = 0x80580200;
  argoman_2.params.runtime_entry = 0x80580000;
  argoman_2.params.user_entry = 0x80580100;
  argoman_2.params.untrusted_ptr = 0x80588000;
  argoman_2.params.untrusted_size = 0x100;
  argoman_2.eid_pptr = (unsigned int*)0x80575000;
}

void  setup_enclave_args_3()
{
  // should return true
  argoman_3.epm_region.paddr = 0x80680000;
  argoman_3.epm_region.size = 0x4000;
  argoman_3.utm_region.paddr = 0x80688000;
  argoman_3.utm_region.size = 0x2000;
  argoman_3.runtime_paddr = 0x80680000;
  argoman_3.user_paddr = 0x80681000;
  argoman_3.free_paddr = 0x80682000;
  argoman_3.params.runtime_entry = 0x80680000;
  argoman_3.params.user_entry = 0x80681000;
  argoman_3.params.untrusted_ptr = 0x80688000;
  argoman_3.params.untrusted_size = 0x2000;
  argoman_3.eid_pptr = (unsigned int*)0x80675000;
}

void  setup_enclave_args_4()
{
  // should return true
  argoman_4.epm_region.paddr = 0x80780000;
  argoman_4.epm_region.size = 0x4000;
  argoman_4.utm_region.paddr = 0x80788000;
  argoman_4.utm_region.size = 0x2000;
  argoman_4.runtime_paddr = 0x80780000;
  argoman_4.user_paddr = 0x80781000;
  argoman_4.free_paddr = 0x80782000;
  argoman_4.params.runtime_entry = 0x80780000;
  argoman_4.params.user_entry = 0x80781000;
  argoman_4.params.untrusted_ptr = 0x80788000;
  argoman_4.params.untrusted_size = 0x2000;
  argoman_4.eid_pptr = (unsigned int*)0x80775000;
}
