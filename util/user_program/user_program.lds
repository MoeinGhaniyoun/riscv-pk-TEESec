ENTRY(_start_user)

SECTIONS {
  . = -0x80000000;

  .text.init : { *(.text.init) }
}
