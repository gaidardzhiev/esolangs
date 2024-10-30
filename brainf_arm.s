	.text
	.align	2
	.global	init_interpreter
	.syntax unified
	.arm
	.type	init_interpreter, %function
init_interpreter:
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	str	r0, [fp, #-8]
	mov	r1, #1
	mov	r0, #65536
	bl	calloc(PLT)
	mov	r3, r0
	mov	r2, r3
	ldr	r3, [fp, #-8]
	str	r2, [r3]
	ldr	r3, [fp, #-8]
	mov	r2, #65536
	str	r2, [r3, #4]
	ldr	r3, [fp, #-8]
	mov	r2, #0
	str	r2, [r3, #8]
	nop
	sub	sp, fp, #4
	pop	{fp, pc}
	.size	init_interpreter, .-init_interpreter
	.section	.rodata
	.align	2
.LC0:
	.ascii	"memory allocation failed\012\000"
	.text
	.align	2
	.global	expand_memory
	.syntax unified
	.arm
	.type	expand_memory, %function
expand_memory:
	push	{r4, fp, lr}
	add	fp, sp, #8
	sub	sp, sp, #20
	str	r0, [fp, #-24]
	ldr	r4, .L4
.LPIC0:
	add	r4, pc, r4
	ldr	r3, [fp, #-24]
	ldr	r3, [r3, #4]
	lsl	r3, r3, #1
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-24]
	ldr	r3, [r3]
	ldr	r1, [fp, #-16]
	mov	r0, r3
	bl	realloc(PLT)
	mov	r2, r0
	ldr	r3, [fp, #-24]
	str	r2, [r3]
	ldr	r3, [fp, #-24]
	ldr	r3, [r3]
	cmp	r3, #0
	bne	.L3
	ldr	r3, .L4+4
	ldr	r3, [r4, r3]
	ldr	r3, [r3]
	mov	r2, #25
	mov	r1, #1
	ldr	r0, .L4+8
.LPIC1:
	add	r0, pc, r0
	bl	fwrite(PLT)
	mov	r0, #1
	bl	exit(PLT)
.L3:
	ldr	r3, [fp, #-24]
	ldr	r2, [fp, #-16]
	str	r2, [r3, #4]
	nop
	sub	sp, fp, #8
	pop	{r4, fp, pc}
.L5:
	.align	2
.L4:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC0+8)
	.word	stderr(GOT)
	.word	.LC0-(.LPIC1+8)
	.size	expand_memory, .-expand_memory
	.section	.rodata
	.align	2
.LC1:
	.ascii	"pointer underflow\012\000"
	.text
	.align	2
	.global	interpret
	.syntax unified
	.arm
	.type	interpret, %function
interpret:
	push	{r4, fp, lr}
	add	fp, sp, #8
	sub	sp, sp, #36
	str	r0, [fp, #-40]
	ldr	r4, .L34
.LPIC3:
	add	r4, pc, r4
	ldr	r2, .L34+4
.LPIC5:
	add	r2, pc, r2
	ldr	r3, .L34+8
	ldr	r3, [r2, r3]
	ldr	r3, [r3]
	str	r3, [fp, #-16]
	mov	r3, #0
	sub	r3, fp, #28
	mov	r0, r3
	bl	init_interpreter(PLT)
	ldr	r3, [fp, #-40]
	str	r3, [fp, #-36]
	b	.L7
.L28:
	ldr	r3, [fp, #-36]
	ldrb	r3, [r3]
	sub	r3, r3, #43
	ldr	r2, .L34+12
.LPIC2:
	add	r2, pc, r2
	cmp	r3, #50
	bhi	.L8
	ldr	r3, [r2, r3, lsl #2]
	add	pc, pc, r3
.Lrtx10:
	nop
	.section	.rodata
	.align	2
.L10:
	.word	.L17-.Lrtx10-4
	.word	.L16-.Lrtx10-4
	.word	.L15-.Lrtx10-4
	.word	.L14-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L13-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L12-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L11-.Lrtx10-4
	.word	.L8-.Lrtx10-4
	.word	.L9-.Lrtx10-4
	.text
	.p2align 2
.L12:
	ldr	r3, [fp, #-20]
	add	r3, r3, #1
	str	r3, [fp, #-20]
	ldr	r2, [fp, #-20]
	ldr	r3, [fp, #-24]
	cmp	r2, r3
	bcc	.L30
	sub	r3, fp, #28
	mov	r0, r3
	bl	expand_memory(PLT)
	b	.L30
.L13:
	ldr	r3, [fp, #-20]
	cmp	r3, #0
	bne	.L19
	ldr	r3, .L34+16
	ldr	r3, [r4, r3]
	ldr	r3, [r3]
	mov	r2, #18
	mov	r1, #1
	ldr	r0, .L34+20
.LPIC4:
	add	r0, pc, r0
	bl	fwrite(PLT)
	mov	r0, #1
	bl	exit(PLT)
.L19:
	ldr	r3, [fp, #-20]
	sub	r3, r3, #1
	str	r3, [fp, #-20]
	b	.L8
.L17:
	ldr	r2, [fp, #-28]
	ldr	r3, [fp, #-20]
	add	r3, r2, r3
	ldrb	r2, [r3]
	add	r2, r2, #1
	uxtb	r2, r2
	strb	r2, [r3]
	b	.L8
.L15:
	ldr	r2, [fp, #-28]
	ldr	r3, [fp, #-20]
	add	r3, r2, r3
	ldrb	r2, [r3]
	sub	r2, r2, #1
	uxtb	r2, r2
	strb	r2, [r3]
	b	.L8
.L14:
	ldr	r2, [fp, #-28]
	ldr	r3, [fp, #-20]
	add	r3, r2, r3
	ldrb	r3, [r3]
	mov	r0, r3
	bl	putchar(PLT)
	b	.L8
.L16:
	bl	getchar(PLT)
	mov	r1, r0
	ldr	r2, [fp, #-28]
	ldr	r3, [fp, #-20]
	add	r3, r2, r3
	uxtb	r2, r1
	strb	r2, [r3]
	b	.L8
.L11:
	ldr	r2, [fp, #-28]
	ldr	r3, [fp, #-20]
	add	r3, r2, r3
	ldrb	r3, [r3]
	cmp	r3, #0
	bne	.L31
	mov	r3, #1
	str	r3, [fp, #-32]
	b	.L21
.L23:
	ldr	r3, [fp, #-36]
	add	r3, r3, #1
	str	r3, [fp, #-36]
	ldr	r3, [fp, #-36]
	ldrb	r3, [r3]
	cmp	r3, #91
	bne	.L22
	ldr	r3, [fp, #-32]
	add	r3, r3, #1
	str	r3, [fp, #-32]
.L22:
	ldr	r3, [fp, #-36]
	ldrb	r3, [r3]
	cmp	r3, #93
	bne	.L21
	ldr	r3, [fp, #-32]
	sub	r3, r3, #1
	str	r3, [fp, #-32]
.L21:
	ldr	r3, [fp, #-32]
	cmp	r3, #0
	bne	.L23
	b	.L31
.L9:
	ldr	r2, [fp, #-28]
	ldr	r3, [fp, #-20]
	add	r3, r2, r3
	ldrb	r3, [r3]
	cmp	r3, #0
	beq	.L32
	mov	r3, #1
	str	r3, [fp, #-32]
	b	.L25
.L27:
	ldr	r3, [fp, #-36]
	sub	r3, r3, #1
	str	r3, [fp, #-36]
	ldr	r3, [fp, #-36]
	ldrb	r3, [r3]
	cmp	r3, #91
	bne	.L26
	ldr	r3, [fp, #-32]
	sub	r3, r3, #1
	str	r3, [fp, #-32]
.L26:
	ldr	r3, [fp, #-36]
	ldrb	r3, [r3]
	cmp	r3, #93
	bne	.L25
	ldr	r3, [fp, #-32]
	add	r3, r3, #1
	str	r3, [fp, #-32]
.L25:
	ldr	r3, [fp, #-32]
	cmp	r3, #0
	bne	.L27
	b	.L32
.L30:
	nop
	b	.L8
.L31:
	nop
	b	.L8
.L32:
	nop
.L8:
	ldr	r3, [fp, #-36]
	add	r3, r3, #1
	str	r3, [fp, #-36]
.L7:
	ldr	r3, [fp, #-36]
	ldrb	r3, [r3]
	cmp	r3, #0
	bne	.L28
	ldr	r3, [fp, #-28]
	mov	r0, r3
	bl	free(PLT)
	nop
	ldr	r2, .L34+24
.LPIC6:
	add	r2, pc, r2
	ldr	r3, .L34+8
	ldr	r3, [r2, r3]
	ldr	r2, [r3]
	ldr	r3, [fp, #-16]
	eors	r2, r3, r2
	mov	r3, #0
	beq	.L29
	bl	__stack_chk_fail(PLT)
.L29:
	sub	sp, fp, #8
	pop	{r4, fp, pc}
.L35:
	.align	2
.L34:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC3+8)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC5+8)
	.word	__stack_chk_guard(GOT)
	.word	.L10-(.LPIC2+8)
	.word	stderr(GOT)
	.word	.LC1-(.LPIC4+8)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC6+8)
	.size	interpret, .-interpret
	.section	.rodata
	.align	2
.LC2:
	.ascii	"usage: %s <file.bf>\012\000"
	.align	2
.LC3:
	.ascii	"r\000"
	.align	2
.LC4:
	.ascii	"failed to open file\000"
	.text
	.align	2
	.global	main
	.syntax unified
	.arm
	.type	main, %function
main:
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #24
	str	r0, [fp, #-24]
	str	r1, [fp, #-28]
	ldr	r2, .L40
.LPIC7:
	add	r2, pc, r2
	ldr	r3, [fp, #-24]
	cmp	r3, #1
	bgt	.L37
	ldr	r3, .L40+4
	ldr	r3, [r2, r3]
	ldr	r0, [r3]
	ldr	r3, [fp, #-28]
	ldr	r3, [r3]
	mov	r2, r3
	ldr	r3, .L40+8
.LPIC8:
	add	r3, pc, r3
	mov	r1, r3
	bl	fprintf(PLT)
	mov	r3, #1
	b	.L38
.L37:
	ldr	r3, [fp, #-28]
	add	r3, r3, #4
	ldr	r3, [r3]
	ldr	r2, .L40+12
.LPIC9:
	add	r2, pc, r2
	mov	r1, r2
	mov	r0, r3
	bl	fopen(PLT)
	mov	r3, r0
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	bne	.L39
	ldr	r3, .L40+16
.LPIC10:
	add	r3, pc, r3
	mov	r0, r3
	bl	perror(PLT)
	mov	r3, #1
	b	.L38
.L39:
	mov	r2, #2
	mov	r1, #0
	ldr	r0, [fp, #-16]
	bl	fseek(PLT)
	ldr	r0, [fp, #-16]
	bl	ftell(PLT)
	str	r0, [fp, #-12]
	mov	r2, #0
	mov	r1, #0
	ldr	r0, [fp, #-16]
	bl	fseek(PLT)
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	mov	r0, r3
	bl	malloc(PLT)
	mov	r3, r0
	str	r3, [fp, #-8]
	ldr	r2, [fp, #-12]
	ldr	r3, [fp, #-16]
	mov	r1, #1
	ldr	r0, [fp, #-8]
	bl	fread(PLT)
	ldr	r3, [fp, #-12]
	ldr	r2, [fp, #-8]
	add	r3, r2, r3
	mov	r2, #0
	strb	r2, [r3]
	ldr	r0, [fp, #-16]
	bl	fclose(PLT)
	ldr	r0, [fp, #-8]
	bl	interpret(PLT)
	ldr	r0, [fp, #-8]
	bl	free(PLT)
	mov	r3, #0
.L38:
	mov	r0, r3
	sub	sp, fp, #4
	pop	{fp, pc}
.L41:
	.align	2
.L40:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC7+8)
	.word	stderr(GOT)
	.word	.LC2-(.LPIC8+8)
	.word	.LC3-(.LPIC9+8)
	.word	.LC4-(.LPIC10+8)
	.size	main, .-main
