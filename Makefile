AS=gcc
all: whitespace

whitespace: whitespace_arm.s whitespace_x86_64.s
	if uname -a | grep "arm"; then\
		$(AS) whitespace_arm.s -o whitespace;\
		elif uname -a | grep "x86"; then\
		$(AS)  whitespace_x86_64.s -o whitespace;\
	fi

clean:
	rm whitespace
