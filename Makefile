AS=gcc
CC=tcc
all: brainf
all: whitespace

whitespace: whitespace_arm.s whitespace_x86_64.s
	if uname -a | grep "arm"; then\
		$(AS) whitespace_arm.s -o whitespace;\
		$(AS) brainf_arm.s -o brainf_arm;\
		elif uname -a | grep "x86"; then\
		$(AS)  whitespace_x86_64.s -o whitespace;\
		elif uname -a | grep "i686"; then\
		$(AS) whitespace_i686.s -o whitespace;\
	fi


brainf: brainf.c
	$(CC) brainf.c -o brainf

clean:
	rm whitespace brainf brainf_arm
