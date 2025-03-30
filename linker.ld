/* Define memory regions */
MEMORY
{
    FLASH (rx)  : ORIGIN = 0x00000000, LENGTH = 16K
    RAM (rwx)   : ORIGIN = 0x20000000, LENGTH = 4K
}


SECTIONS
{
    
    .text :
    {
        *(.vectors*)
        *(.text*)
        _etext = .;
    } > FLASH

    .data :
    {
        . = ALIGN(4);
        _sdata = .;
        *(.data)
        _edata = .;
    } > RAM AT > FLASH

    _stack_top = ORIGIN(RAM) + LENGTH(RAM);

}
