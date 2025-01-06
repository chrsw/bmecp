/* Specifying the firmware's entry point */
ENTRY(Reset_Handler)

/* Detailing the available memory */
MEMORY
{
	FLASH(rx) : ORIGIN = 0x08000000, LENGTH = 512K
	SRAM(rwx) : ORIGIN = 0x20000000, LENGTH = 128k
}

_estack = ORIGIN(SRAM) + LENGTH(SRAM);

/* Specifying the necessary heap and stack sizes */
__max_heap_size = 0x200;
__max_stack_size = 0x400;

/* Defining output sections */
SECTIONS
{
	.text :
	{
		. = ALIGN(4); 
		*(.isr_vector_tbl)   /* merge all .isr_vector_tbl (interrupt service routine) sections of input files */
		*(.text)   			 /* merge all .text (application code) sections of input files */
		*(.rodata)   	   	 /* merge all .rodata (read only data) sections of input files */
		. = ALIGN(4);
		_etext = .;			 /* create a global symbol to hold end of text section */
	} >FLASH
	
	.data :
	{
		_sdata = .;			 /* create a global symbol to the start of data */
		*(.data)
		. = ALIGN(4);
		_edata = .;			 /* create a global symbol to hold the end of data */
	} >SRAM AT> FLASH /* >(vma) AT> (lma) */
	
	.bss :
	{
		. = ALIGN(4);
		_sbss = .;
		*(.bss)
		. = ALIGN(4);
		_ebss = .;
	} >SRAM
}