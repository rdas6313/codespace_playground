

make:
	arm-none-eabi-as -mcpu=cortex-m3 -mthumb -ggdb simple.s -o simple.o
	arm-none-eabi-ld -T linker.ld simple.o -o simple.elf
	arm-none-eabi-objdump -D -t -x simple.elf > simple.lst
	qemu-system-arm -M stm32vldiscovery -kernel simple.elf -S -gdb tcp::1234 -nographic

gdb:
	gdb-multiarch simple.elf -q -ex "target remote localhost:1234"

clean:
	rm -rf *.elf *.o