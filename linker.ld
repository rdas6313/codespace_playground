/* Define memory regions */
MEMORY
{
    MEM (rx) : ORIGIN = 0x00000000, LENGTH = 0x4000
}


SECTIONS
{
    
    .text :
    {
       *(.vectors*)
       *(.text*)
    } > MEM

}
