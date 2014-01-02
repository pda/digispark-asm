MCU=attiny85
MICRONUCLEUS=micronucleus
OBJCOPY=avr-objcopy
CC=avr-gcc
AS=avr-as
OBJCOPY=avr-objcopy
OBJDUMP=avr-objdump

all: main.hex

upload: main.hex
	$(MICRONUCLEUS) --run main.hex

main.hex: main.elf
	$(OBJCOPY) -O ihex --remove-section=.eeprom main.elf main.hex

main.elf: main.o
	$(CC) -Os -mmcu=$(MCU) -o main.elf main.o

main.o: main.s
	$(AS) -Wall -mmcu=$(MCU) -a=main.list -o main.o main.s

clean:
	rm -f main.hex main.elf main.o main.list

dump:
	$(OBJDUMP) -m avr -h -d main
