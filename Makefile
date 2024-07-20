AS=gcc
CROSS=arm-none-eabi-gcc
all: whitespace

whitespace: whitespace.s
	if uname -a | grep "arm"; then\
		$(AS) whitespace.s -o whitespace;\
		elif uname -a | grep "x86"; then\
		$(CROSS) whitespace.s -o whitespace;\
	fi

clean:
	rm whitespace
