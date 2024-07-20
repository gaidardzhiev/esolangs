	.arch armv7-a
	.fpu neon
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.text
	.global	stack
	.bss
	.align	2
	.type	stack, %object
	.size	stack, 12
stack:
	.space	12
	.global	heap
	.align	2
	.type	heap, %object
	.size	heap, 12
heap:
	.space	12
	.global	label_table
	.align	2
	.type	label_table, %object
	.size	label_table, 12
label_table:
	.space	12
	.global	instruction_set
	.align	2
	.type	instruction_set, %object
	.size	instruction_set, 12
instruction_set:
	.space	12
	.global	instruction_index
	.align	3
	.type	instruction_index, %object
	.size	instruction_index, 160
instruction_index:
	.space	160
	.global	current_instruction_index
	.align	3
	.type	current_instruction_index, %object
	.size	current_instruction_index, 8
current_instruction_index:
	.space	8
	.section	.rodata
	.align	2
.LC0:
	.ascii	"usage: %s *.whitespace\012\000"
	.text
	.align	2
	.global	main
	.syntax unified
	.arm
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	str	r0, [fp, #-16]
	str	r1, [fp, #-20]
	ldr	r2, .L11
.LPIC1:
	add	r2, pc, r2
	ldr	r3, .L11+4
	ldr	r3, [r2, r3]
	ldr	r3, [r3]
	str	r3, [fp, #-8]
	mov	r3, #0
	ldr	r3, [fp, #-16]
	cmp	r3, #2
	bne	.L2
	ldr	r3, [fp, #-20]
	add	r3, r3, #4
	ldr	r3, [r3]
	sub	r2, fp, #12
	mov	r1, r2
	mov	r0, r3
	bl	read_source_file(PLT)
	mov	r3, r0
	cmp	r3, #0
	beq	.L3
	ldr	r3, [fp, #-12]
	mov	r0, r3
	bl	remove_comments(PLT)
	bl	create_stack(PLT)
	mov	r3, r0
	cmp	r3, #0
	beq	.L3
	bl	create_heap(PLT)
	mov	r3, r0
	cmp	r3, #0
	beq	.L4
	bl	create_label_table(PLT)
	mov	r3, r0
	cmp	r3, #0
	beq	.L5
	bl	create_instruction_set(PLT)
	mov	r3, r0
	cmp	r3, #0
	beq	.L6
	ldr	r3, [fp, #-12]
	mov	r0, r3
	bl	locate_jump_labels(PLT)
	mov	r3, r0
	cmp	r3, #0
	beq	.L7
	ldr	r3, [fp, #-12]
	mov	r0, r3
	bl	step_through_program(PLT)
	ldr	r3, [fp, #-12]
	mov	r0, r3
	bl	free(PLT)
	bl	cleanup_stack(PLT)
	bl	cleanup_heap(PLT)
	bl	cleanup_label_table(PLT)
	bl	cleanup_instruction_set(PLT)
	mov	r3, #0
	b	.L9
.L7:
	bl	cleanup_instruction_set(PLT)
.L6:
	bl	cleanup_label_table(PLT)
.L5:
	bl	cleanup_heap(PLT)
.L4:
	bl	cleanup_stack(PLT)
	b	.L3
.L2:
	ldr	r3, [fp, #-20]
	ldr	r3, [r3]
	mov	r1, r3
	ldr	r3, .L11+8
.LPIC0:
	add	r3, pc, r3
	mov	r0, r3
	bl	printf(PLT)
.L3:
	mov	r3, #1
.L9:
	ldr	r1, .L11+12
.LPIC2:
	add	r1, pc, r1
	ldr	r2, .L11+4
	ldr	r2, [r1, r2]
	ldr	r1, [r2]
	ldr	r2, [fp, #-8]
	eors	r1, r2, r1
	mov	r2, #0
	beq	.L10
	bl	__stack_chk_fail(PLT)
.L10:
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L12:
	.align	2
.L11:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC1+8)
	.word	__stack_chk_guard(GOT)
	.word	.LC0-(.LPIC0+8)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC2+8)
	.size	main, .-main
	.section	.rodata
	.align	2
.LC1:
	.ascii	"r\000"
	.text
	.align	2
	.global	read_source_file
	.syntax unified
	.arm
	.type	read_source_file, %function
read_source_file:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	str	r0, [fp, #-16]
	str	r1, [fp, #-20]
	ldr	r3, .L18
.LPIC3:
	add	r3, pc, r3
	mov	r1, r3
	ldr	r0, [fp, #-16]
	bl	fopen(PLT)
	mov	r3, r0
	str	r3, [fp, #-12]
	ldr	r3, [fp, #-12]
	cmp	r3, #0
	beq	.L14
	mov	r2, #2
	mov	r1, #0
	ldr	r0, [fp, #-12]
	bl	fseek(PLT)
	mov	r3, r0
	cmp	r3, #0
	bne	.L15
	ldr	r0, [fp, #-12]
	bl	ftell(PLT)
	str	r0, [fp, #-8]
	ldr	r3, [fp, #-8]
	cmn	r3, #1
	beq	.L15
	ldr	r0, [fp, #-12]
	bl	rewind(PLT)
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	mov	r1, #1
	mov	r0, r3
	bl	calloc(PLT)
	mov	r3, r0
	mov	r2, r3
	ldr	r3, [fp, #-20]
	str	r2, [r3]
	ldr	r3, [fp, #-20]
	ldr	r3, [r3]
	cmp	r3, #0
	beq	.L15
	ldr	r3, [fp, #-20]
	ldr	r0, [r3]
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	mov	r2, r3
	ldr	r3, [fp, #-12]
	mov	r1, #1
	bl	fread(PLT)
	mov	r3, r0
	cmp	r3, #0
	beq	.L16
	ldr	r0, [fp, #-12]
	bl	fclose(PLT)
	ldr	r3, [fp, #-8]
	b	.L17
.L16:
	ldr	r3, [fp, #-20]
	ldr	r3, [r3]
	mov	r0, r3
	bl	free(PLT)
.L15:
	ldr	r0, [fp, #-12]
	bl	fclose(PLT)
.L14:
	mov	r3, #0
.L17:
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L19:
	.align	2
.L18:
	.word	.LC1-(.LPIC3+8)
	.size	read_source_file, .-read_source_file
	.align	2
	.global	remove_comments
	.syntax unified
	.arm
	.type	remove_comments, %function
remove_comments:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, fp, lr}
	add	fp, sp, #12
	sub	sp, sp, #16
	str	r0, [fp, #-24]
	mov	r3, #0
	str	r3, [fp, #-20]
	mov	r3, #0
	str	r3, [fp, #-16]
	b	.L21
.L23:
	ldr	r3, [fp, #-16]
	ldr	r2, [fp, #-24]
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	cmp	r3, #9
	beq	.L22
	ldr	r3, [fp, #-16]
	ldr	r2, [fp, #-24]
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	cmp	r3, #10
	beq	.L22
	ldr	r3, [fp, #-16]
	ldr	r2, [fp, #-24]
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	cmp	r3, #32
	beq	.L22
	ldr	r3, [fp, #-16]
	ldr	r2, [fp, #-24]
	add	r4, r2, r3
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	ldr	r2, [fp, #-24]
	add	r5, r2, r3
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	ldr	r2, [fp, #-24]
	add	r3, r2, r3
	mov	r0, r3
	bl	strlen(PLT)
	mov	r3, r0
	mov	r2, r3
	mov	r1, r5
	mov	r0, r4
	bl	memmove(PLT)
	ldr	r3, [fp, #-16]
	sub	r3, r3, #1
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-20]
	add	r3, r3, #1
	str	r3, [fp, #-20]
.L22:
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	str	r3, [fp, #-16]
.L21:
	ldr	r3, [fp, #-16]
	ldr	r2, [fp, #-24]
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L23
	ldr	r0, [fp, #-24]
	bl	strlen(PLT)
	mov	r2, r0
	ldr	r3, [fp, #-20]
	sub	r3, r2, r3
	ldr	r2, [fp, #-24]
	add	r3, r2, r3
	mov	r2, #0
	strb	r2, [r3]
	nop
	sub	sp, fp, #12
	@ sp needed
	pop	{r4, r5, fp, pc}
	.size	remove_comments, .-remove_comments
	.align	2
	.global	create_stack
	.syntax unified
	.arm
	.type	create_stack, %function
create_stack:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	mov	r1, #8
	mov	r0, #2048
	bl	calloc(PLT)
	mov	r3, r0
	mov	r2, r3
	ldr	r3, .L28
.LPIC4:
	add	r3, pc, r3
	str	r2, [r3, #8]
	ldr	r3, .L28+4
.LPIC5:
	add	r3, pc, r3
	ldr	r3, [r3, #8]
	cmp	r3, #0
	beq	.L26
	ldr	r3, .L28+8
.LPIC6:
	add	r3, pc, r3
	mov	r2, #2048
	str	r2, [r3]
	ldr	r3, .L28+12
.LPIC7:
	add	r3, pc, r3
	mov	r2, #2048
	str	r2, [r3, #4]
	mov	r3, #1
	b	.L27
.L26:
	mov	r3, #0
.L27:
	mov	r0, r3
	pop	{fp, pc}
.L29:
	.align	2
.L28:
	.word	stack-(.LPIC4+8)
	.word	stack-(.LPIC5+8)
	.word	stack-(.LPIC6+8)
	.word	stack-(.LPIC7+8)
	.size	create_stack, .-create_stack
	.align	2
	.global	stack_push
	.syntax unified
	.arm
	.type	stack_push, %function
stack_push:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	strd	r0, [fp, #-12]
	ldr	r3, .L33
.LPIC8:
	add	r3, pc, r3
	ldr	r3, [r3, #4]
	cmp	r3, #0
	ble	.L31
	ldr	r3, .L33+4
.LPIC9:
	add	r3, pc, r3
	ldr	r3, [r3, #4]
	sub	r2, r3, #1
	ldr	r3, .L33+8
.LPIC10:
	add	r3, pc, r3
	str	r2, [r3, #4]
	ldr	r3, .L33+12
.LPIC11:
	add	r3, pc, r3
	ldr	r2, [r3, #8]
	ldr	r3, .L33+16
.LPIC12:
	add	r3, pc, r3
	ldr	r3, [r3, #4]
	lsl	r3, r3, #3
	add	r1, r2, r3
	ldrd	r2, [fp, #-12]
	strd	r2, [r1]
	mov	r3, #1
	b	.L32
.L31:
	mov	r3, #0
.L32:
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
.L34:
	.align	2
.L33:
	.word	stack-(.LPIC8+8)
	.word	stack-(.LPIC9+8)
	.word	stack-(.LPIC10+8)
	.word	stack-(.LPIC11+8)
	.word	stack-(.LPIC12+8)
	.size	stack_push, .-stack_push
	.align	2
	.global	stack_pop
	.syntax unified
	.arm
	.type	stack_pop, %function
stack_pop:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	ldr	r3, .L38
.LPIC13:
	add	r3, pc, r3
	ldr	r2, [r3, #4]
	ldr	r3, .L38+4
.LPIC14:
	add	r3, pc, r3
	ldr	r3, [r3]
	cmp	r2, r3
	bge	.L36
	ldr	r3, .L38+8
.LPIC15:
	add	r3, pc, r3
	ldr	r3, [r3, #4]
	add	r2, r3, #1
	ldr	r3, .L38+12
.LPIC16:
	add	r3, pc, r3
	str	r2, [r3, #4]
	ldr	r3, .L38+16
.LPIC17:
	add	r3, pc, r3
	ldr	r2, [r3, #8]
	ldr	r3, .L38+20
.LPIC18:
	add	r3, pc, r3
	ldr	r3, [r3, #4]
	sub	r3, r3, #-536870911
	lsl	r3, r3, #3
	add	r3, r2, r3
	vldr.64	d16, [r3]	@ int
	b	.L37
.L36:
	vmov.i32	d16, #0  @ di
.L37:
	vmov	r2, r3, d16	@ int
	mov	r0, r2
	mov	r1, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
.L39:
	.align	2
.L38:
	.word	stack-(.LPIC13+8)
	.word	stack-(.LPIC14+8)
	.word	stack-(.LPIC15+8)
	.word	stack-(.LPIC16+8)
	.word	stack-(.LPIC17+8)
	.word	stack-(.LPIC18+8)
	.size	stack_pop, .-stack_pop
	.align	2
	.global	stack_peak
	.syntax unified
	.arm
	.type	stack_peak, %function
stack_peak:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	str	r0, [fp, #-8]
	ldr	r3, .L43
.LPIC19:
	add	r3, pc, r3
	ldr	r2, [r3, #4]
	ldr	r3, [fp, #-8]
	add	r2, r2, r3
	ldr	r3, .L43+4
.LPIC20:
	add	r3, pc, r3
	ldr	r3, [r3]
	cmp	r2, r3
	bge	.L41
	ldr	r3, .L43+8
.LPIC21:
	add	r3, pc, r3
	ldr	r2, [r3, #8]
	ldr	r3, .L43+12
.LPIC22:
	add	r3, pc, r3
	ldr	r1, [r3, #4]
	ldr	r3, [fp, #-8]
	add	r3, r1, r3
	lsl	r3, r3, #3
	add	r3, r2, r3
	vldr.64	d16, [r3]	@ int
	b	.L42
.L41:
	vmov.i32	d16, #0  @ di
.L42:
	vmov	r2, r3, d16	@ int
	mov	r0, r2
	mov	r1, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
.L44:
	.align	2
.L43:
	.word	stack-(.LPIC19+8)
	.word	stack-(.LPIC20+8)
	.word	stack-(.LPIC21+8)
	.word	stack-(.LPIC22+8)
	.size	stack_peak, .-stack_peak
	.align	2
	.global	cleanup_stack
	.syntax unified
	.arm
	.type	cleanup_stack, %function
cleanup_stack:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	ldr	r3, .L47
.LPIC23:
	add	r3, pc, r3
	ldr	r3, [r3, #8]
	mov	r0, r3
	bl	free(PLT)
	nop
	pop	{fp, pc}
.L48:
	.align	2
.L47:
	.word	stack-(.LPIC23+8)
	.size	cleanup_stack, .-cleanup_stack
	.align	2
	.global	create_heap
	.syntax unified
	.arm
	.type	create_heap, %function
create_heap:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	mov	r1, #8
	mov	r0, #2048
	bl	calloc(PLT)
	mov	r3, r0
	mov	r2, r3
	ldr	r3, .L53
.LPIC24:
	add	r3, pc, r3
	str	r2, [r3]
	ldr	r3, .L53+4
.LPIC25:
	add	r3, pc, r3
	ldr	r3, [r3]
	cmp	r3, #0
	beq	.L50
	mov	r1, #8
	mov	r0, #2048
	bl	calloc(PLT)
	mov	r3, r0
	mov	r2, r3
	ldr	r3, .L53+8
.LPIC26:
	add	r3, pc, r3
	str	r2, [r3, #4]
	ldr	r3, .L53+12
.LPIC27:
	add	r3, pc, r3
	ldr	r3, [r3, #4]
	cmp	r3, #0
	beq	.L51
	ldr	r3, .L53+16
.LPIC28:
	add	r3, pc, r3
	mov	r2, #0
	str	r2, [r3, #8]
	mov	r3, #1
	b	.L52
.L51:
	ldr	r3, .L53+20
.LPIC29:
	add	r3, pc, r3
	ldr	r3, [r3]
	mov	r0, r3
	bl	free(PLT)
.L50:
	mov	r3, #0
.L52:
	mov	r0, r3
	pop	{fp, pc}
.L54:
	.align	2
.L53:
	.word	heap-(.LPIC24+8)
	.word	heap-(.LPIC25+8)
	.word	heap-(.LPIC26+8)
	.word	heap-(.LPIC27+8)
	.word	heap-(.LPIC28+8)
	.word	heap-(.LPIC29+8)
	.size	create_heap, .-create_heap
	.align	2
	.global	heap_put
	.syntax unified
	.arm
	.type	heap_put, %function
heap_put:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #28
	strd	r0, [fp, #-20]
	strd	r2, [fp, #-28]
	mov	r3, #0
	str	r3, [fp, #-12]
	b	.L56
.L59:
	ldr	r3, .L61
.LPIC30:
	add	r3, pc, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-12]
	lsl	r3, r3, #3
	add	r3, r2, r3
	ldrd	r2, [r3]
	ldrd	r0, [fp, #-28]
	cmp	r1, r3
	cmpeq	r0, r2
	bne	.L57
	ldr	r3, .L61+4
.LPIC31:
	add	r3, pc, r3
	ldr	r2, [r3, #4]
	ldr	r3, [fp, #-12]
	lsl	r3, r3, #3
	add	r1, r2, r3
	ldrd	r2, [fp, #-20]
	strd	r2, [r1]
	mov	r3, #1
	b	.L58
.L57:
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L56:
	ldr	r3, .L61+8
.LPIC32:
	add	r3, pc, r3
	ldr	r3, [r3, #8]
	ldr	r2, [fp, #-12]
	cmp	r2, r3
	blt	.L59
	ldr	r3, .L61+12
.LPIC33:
	add	r3, pc, r3
	ldr	r3, [r3, #8]
	cmp	r3, #2048
	bge	.L60
	ldr	r3, .L61+16
.LPIC34:
	add	r3, pc, r3
	ldr	r3, [r3, #8]
	str	r3, [fp, #-8]
	ldr	r3, .L61+20
.LPIC35:
	add	r3, pc, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-8]
	lsl	r3, r3, #3
	add	r1, r2, r3
	ldrd	r2, [fp, #-28]
	strd	r2, [r1]
	ldr	r3, .L61+24
.LPIC36:
	add	r3, pc, r3
	ldr	r2, [r3, #4]
	ldr	r3, [fp, #-8]
	lsl	r3, r3, #3
	add	r1, r2, r3
	ldrd	r2, [fp, #-20]
	strd	r2, [r1]
	ldr	r3, .L61+28
.LPIC37:
	add	r3, pc, r3
	ldr	r3, [r3, #8]
	add	r2, r3, #1
	ldr	r3, .L61+32
.LPIC38:
	add	r3, pc, r3
	str	r2, [r3, #8]
	mov	r3, #1
	b	.L58
.L60:
	mov	r3, #0
.L58:
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
.L62:
	.align	2
.L61:
	.word	heap-(.LPIC30+8)
	.word	heap-(.LPIC31+8)
	.word	heap-(.LPIC32+8)
	.word	heap-(.LPIC33+8)
	.word	heap-(.LPIC34+8)
	.word	heap-(.LPIC35+8)
	.word	heap-(.LPIC36+8)
	.word	heap-(.LPIC37+8)
	.word	heap-(.LPIC38+8)
	.size	heap_put, .-heap_put
	.align	2
	.global	heap_get
	.syntax unified
	.arm
	.type	heap_get, %function
heap_get:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #20
	strd	r0, [fp, #-20]
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L64
.L67:
	ldr	r3, .L68
.LPIC39:
	add	r3, pc, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-8]
	lsl	r3, r3, #3
	add	r3, r2, r3
	ldrd	r2, [r3]
	ldrd	r0, [fp, #-20]
	cmp	r1, r3
	cmpeq	r0, r2
	bne	.L65
	ldr	r3, .L68+4
.LPIC40:
	add	r3, pc, r3
	ldr	r2, [r3, #4]
	ldr	r3, [fp, #-8]
	lsl	r3, r3, #3
	add	r3, r2, r3
	vldr.64	d16, [r3]	@ int
	b	.L66
.L65:
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L64:
	ldr	r3, [fp, #-8]
	cmp	r3, #2048
	blt	.L67
	vmov.i32	d16, #0  @ di
.L66:
	vmov	r2, r3, d16	@ int
	mov	r0, r2
	mov	r1, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
.L69:
	.align	2
.L68:
	.word	heap-(.LPIC39+8)
	.word	heap-(.LPIC40+8)
	.size	heap_get, .-heap_get
	.align	2
	.global	cleanup_heap
	.syntax unified
	.arm
	.type	cleanup_heap, %function
cleanup_heap:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	ldr	r3, .L72
.LPIC41:
	add	r3, pc, r3
	ldr	r3, [r3]
	mov	r0, r3
	bl	free(PLT)
	ldr	r3, .L72+4
.LPIC42:
	add	r3, pc, r3
	ldr	r3, [r3, #4]
	mov	r0, r3
	bl	free(PLT)
	nop
	pop	{fp, pc}
.L73:
	.align	2
.L72:
	.word	heap-(.LPIC41+8)
	.word	heap-(.LPIC42+8)
	.size	cleanup_heap, .-cleanup_heap
	.align	2
	.global	create_label_table
	.syntax unified
	.arm
	.type	create_label_table, %function
create_label_table:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	mov	r1, #4
	mov	r0, #200
	bl	calloc(PLT)
	mov	r3, r0
	mov	r2, r3
	ldr	r3, .L78
.LPIC43:
	add	r3, pc, r3
	str	r2, [r3]
	ldr	r3, .L78+4
.LPIC44:
	add	r3, pc, r3
	ldr	r3, [r3]
	cmp	r3, #0
	beq	.L75
	mov	r1, #4
	mov	r0, #200
	bl	calloc(PLT)
	mov	r3, r0
	mov	r2, r3
	ldr	r3, .L78+8
.LPIC45:
	add	r3, pc, r3
	str	r2, [r3, #4]
	ldr	r3, .L78+12
.LPIC46:
	add	r3, pc, r3
	ldr	r3, [r3, #4]
	cmp	r3, #0
	beq	.L76
	mov	r3, #1
	b	.L77
.L76:
	ldr	r3, .L78+16
.LPIC47:
	add	r3, pc, r3
	ldr	r3, [r3]
	mov	r0, r3
	bl	free(PLT)
.L75:
	mov	r3, #0
.L77:
	mov	r0, r3
	pop	{fp, pc}
.L79:
	.align	2
.L78:
	.word	label_table-(.LPIC43+8)
	.word	label_table-(.LPIC44+8)
	.word	label_table-(.LPIC45+8)
	.word	label_table-(.LPIC46+8)
	.word	label_table-(.LPIC47+8)
	.size	create_label_table, .-create_label_table
	.align	2
	.global	cleanup_label_table
	.syntax unified
	.arm
	.type	cleanup_label_table, %function
cleanup_label_table:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L81
.L83:
	ldr	r3, .L85
.LPIC48:
	add	r3, pc, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-8]
	lsl	r3, r3, #2
	add	r3, r2, r3
	ldr	r3, [r3]
	mov	r0, r3
	bl	free(PLT)
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L81:
	ldr	r3, [fp, #-8]
	cmp	r3, #199
	bgt	.L82
	ldr	r3, .L85+4
.LPIC49:
	add	r3, pc, r3
	ldr	r2, [r3, #4]
	ldr	r3, [fp, #-8]
	lsl	r3, r3, #2
	add	r3, r2, r3
	ldr	r3, [r3]
	cmp	r3, #0
	bne	.L83
.L82:
	ldr	r3, .L85+8
.LPIC50:
	add	r3, pc, r3
	ldr	r3, [r3]
	mov	r0, r3
	bl	free(PLT)
	ldr	r3, .L85+12
.LPIC51:
	add	r3, pc, r3
	ldr	r3, [r3, #4]
	mov	r0, r3
	bl	free(PLT)
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L86:
	.align	2
.L85:
	.word	label_table-(.LPIC48+8)
	.word	label_table-(.LPIC49+8)
	.word	label_table-(.LPIC50+8)
	.word	label_table-(.LPIC51+8)
	.size	cleanup_label_table, .-cleanup_label_table
	.section	.rodata
	.align	2
.LC2:
	.ascii	"  \000"
	.align	2
.LC3:
	.ascii	" \012 \000"
	.align	2
.LC4:
	.ascii	" \011 \000"
	.align	2
.LC5:
	.ascii	" \012\011\000"
	.align	2
.LC6:
	.ascii	" \012\012\000"
	.align	2
.LC7:
	.ascii	" \011\012\000"
	.align	2
.LC8:
	.ascii	"\011   \000"
	.align	2
.LC9:
	.ascii	"\011  \011\000"
	.align	2
.LC10:
	.ascii	"\011  \012\000"
	.align	2
.LC11:
	.ascii	"\011 \011 \000"
	.align	2
.LC12:
	.ascii	"\011 \011\011\000"
	.align	2
.LC13:
	.ascii	"\011\011 \000"
	.align	2
.LC14:
	.ascii	"\011\011\011\000"
	.align	2
.LC15:
	.ascii	"\012  \000"
	.align	2
.LC16:
	.ascii	"\012 \011\000"
	.align	2
.LC17:
	.ascii	"\012 \012\000"
	.align	2
.LC18:
	.ascii	"\012\011 \000"
	.align	2
.LC19:
	.ascii	"\012\011\011\000"
	.align	2
.LC20:
	.ascii	"\012\011\012\000"
	.align	2
.LC21:
	.ascii	"\012\012\012\000"
	.align	2
.LC22:
	.ascii	"\011\012  \000"
	.align	2
.LC23:
	.ascii	"\011\012 \011\000"
	.align	2
.LC24:
	.ascii	"\011\012\011 \000"
	.align	2
.LC25:
	.ascii	"\011\012\011\011\000"
	.text
	.align	2
	.global	create_instruction_set
	.syntax unified
	.arm
	.type	create_instruction_set, %function
create_instruction_set:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	mov	r1, #4
	mov	r0, #24
	bl	calloc(PLT)
	mov	r3, r0
	mov	r2, r3
	ldr	r3, .L89
.LPIC52:
	add	r3, pc, r3
	str	r2, [r3]
	mov	r1, #4
	mov	r0, #24
	bl	calloc(PLT)
	mov	r3, r0
	mov	r2, r3
	ldr	r3, .L89+4
.LPIC53:
	add	r3, pc, r3
	str	r2, [r3, #8]
	mov	r1, #4
	mov	r0, #24
	bl	calloc(PLT)
	mov	r3, r0
	mov	r2, r3
	ldr	r3, .L89+8
.LPIC54:
	add	r3, pc, r3
	str	r2, [r3, #4]
	ldr	r3, .L89+12
.LPIC55:
	add	r3, pc, r3
	ldr	r3, [r3]
	ldr	r2, .L89+16
.LPIC56:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+20
.LPIC57:
	add	r3, pc, r3
	ldr	r3, [r3, #4]
	ldr	r2, .L89+24
.LPIC58:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+28
.LPIC59:
	add	r3, pc, r3
	ldr	r3, [r3, #8]
	mov	r2, #2
	str	r2, [r3]
	ldr	r3, .L89+32
.LPIC60:
	add	r3, pc, r3
	ldr	r3, [r3]
	add	r3, r3, #4
	ldr	r2, .L89+36
.LPIC61:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+40
.LPIC62:
	add	r3, pc, r3
	ldr	r3, [r3, #4]
	add	r3, r3, #4
	ldr	r2, .L89+44
.LPIC63:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+48
.LPIC64:
	add	r3, pc, r3
	ldr	r3, [r3, #8]
	add	r3, r3, #4
	mov	r2, #3
	str	r2, [r3]
	ldr	r3, .L89+52
.LPIC65:
	add	r3, pc, r3
	ldr	r3, [r3]
	add	r3, r3, #8
	ldr	r2, .L89+56
.LPIC66:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+60
.LPIC67:
	add	r3, pc, r3
	ldr	r3, [r3, #4]
	add	r3, r3, #8
	ldr	r2, .L89+64
.LPIC68:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+68
.LPIC69:
	add	r3, pc, r3
	ldr	r3, [r3, #8]
	add	r3, r3, #8
	mov	r2, #3
	str	r2, [r3]
	ldr	r3, .L89+72
.LPIC70:
	add	r3, pc, r3
	ldr	r3, [r3]
	add	r3, r3, #12
	ldr	r2, .L89+76
.LPIC71:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+80
.LPIC72:
	add	r3, pc, r3
	ldr	r3, [r3, #4]
	add	r3, r3, #12
	ldr	r2, .L89+84
.LPIC73:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+88
.LPIC74:
	add	r3, pc, r3
	ldr	r3, [r3, #8]
	add	r3, r3, #12
	mov	r2, #3
	str	r2, [r3]
	ldr	r3, .L89+92
.LPIC75:
	add	r3, pc, r3
	ldr	r3, [r3]
	add	r3, r3, #16
	ldr	r2, .L89+96
.LPIC76:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+100
.LPIC77:
	add	r3, pc, r3
	ldr	r3, [r3, #4]
	add	r3, r3, #16
	ldr	r2, .L89+104
.LPIC78:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+108
.LPIC79:
	add	r3, pc, r3
	ldr	r3, [r3, #8]
	add	r3, r3, #16
	mov	r2, #3
	str	r2, [r3]
	ldr	r3, .L89+112
.LPIC80:
	add	r3, pc, r3
	ldr	r3, [r3]
	add	r3, r3, #20
	ldr	r2, .L89+116
.LPIC81:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+120
.LPIC82:
	add	r3, pc, r3
	ldr	r3, [r3, #4]
	add	r3, r3, #20
	ldr	r2, .L89+124
.LPIC83:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+128
.LPIC84:
	add	r3, pc, r3
	ldr	r3, [r3, #8]
	add	r3, r3, #20
	mov	r2, #3
	str	r2, [r3]
	ldr	r3, .L89+132
.LPIC85:
	add	r3, pc, r3
	ldr	r3, [r3]
	add	r3, r3, #24
	ldr	r2, .L89+136
.LPIC86:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+140
.LPIC87:
	add	r3, pc, r3
	ldr	r3, [r3, #4]
	add	r3, r3, #24
	ldr	r2, .L89+144
.LPIC88:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+148
.LPIC89:
	add	r3, pc, r3
	ldr	r3, [r3, #8]
	add	r3, r3, #24
	mov	r2, #4
	str	r2, [r3]
	ldr	r3, .L89+152
.LPIC90:
	add	r3, pc, r3
	ldr	r3, [r3]
	add	r3, r3, #28
	ldr	r2, .L89+156
.LPIC91:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+160
.LPIC92:
	add	r3, pc, r3
	ldr	r3, [r3, #4]
	add	r3, r3, #28
	ldr	r2, .L89+164
.LPIC93:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+168
.LPIC94:
	add	r3, pc, r3
	ldr	r3, [r3, #8]
	add	r3, r3, #28
	mov	r2, #4
	str	r2, [r3]
	ldr	r3, .L89+172
.LPIC95:
	add	r3, pc, r3
	ldr	r3, [r3]
	add	r3, r3, #32
	ldr	r2, .L89+176
.LPIC96:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+180
.LPIC97:
	add	r3, pc, r3
	ldr	r3, [r3, #4]
	add	r3, r3, #32
	ldr	r2, .L89+184
.LPIC98:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+188
.LPIC99:
	add	r3, pc, r3
	ldr	r3, [r3, #8]
	add	r3, r3, #32
	mov	r2, #4
	str	r2, [r3]
	ldr	r3, .L89+192
.LPIC100:
	add	r3, pc, r3
	ldr	r3, [r3]
	add	r3, r3, #36
	ldr	r2, .L89+196
.LPIC101:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+200
.LPIC102:
	add	r3, pc, r3
	ldr	r3, [r3, #4]
	add	r3, r3, #36
	ldr	r2, .L89+204
.LPIC103:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+208
.LPIC104:
	add	r3, pc, r3
	ldr	r3, [r3, #8]
	add	r3, r3, #36
	mov	r2, #4
	str	r2, [r3]
	ldr	r3, .L89+212
.LPIC105:
	add	r3, pc, r3
	ldr	r3, [r3]
	add	r3, r3, #40
	ldr	r2, .L89+216
.LPIC106:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+220
.LPIC107:
	add	r3, pc, r3
	ldr	r3, [r3, #4]
	add	r3, r3, #40
	ldr	r2, .L89+224
.LPIC108:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+228
.LPIC109:
	add	r3, pc, r3
	ldr	r3, [r3, #8]
	add	r3, r3, #40
	mov	r2, #4
	str	r2, [r3]
	ldr	r3, .L89+232
.LPIC110:
	add	r3, pc, r3
	ldr	r3, [r3]
	add	r3, r3, #44
	ldr	r2, .L89+236
.LPIC111:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+240
.LPIC112:
	add	r3, pc, r3
	ldr	r3, [r3, #4]
	add	r3, r3, #44
	ldr	r2, .L89+244
.LPIC113:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+248
.LPIC114:
	add	r3, pc, r3
	ldr	r3, [r3, #8]
	add	r3, r3, #44
	mov	r2, #3
	str	r2, [r3]
	ldr	r3, .L89+252
.LPIC115:
	add	r3, pc, r3
	ldr	r3, [r3]
	add	r3, r3, #48
	ldr	r2, .L89+256
.LPIC116:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+260
.LPIC117:
	add	r3, pc, r3
	ldr	r3, [r3, #4]
	add	r3, r3, #48
	ldr	r2, .L89+264
.LPIC118:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+268
.LPIC119:
	add	r3, pc, r3
	ldr	r3, [r3, #8]
	add	r3, r3, #48
	mov	r2, #3
	str	r2, [r3]
	ldr	r3, .L89+272
.LPIC120:
	add	r3, pc, r3
	ldr	r3, [r3]
	add	r3, r3, #52
	ldr	r2, .L89+276
.LPIC121:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+280
.LPIC122:
	add	r3, pc, r3
	ldr	r3, [r3, #4]
	add	r3, r3, #52
	ldr	r2, .L89+284
.LPIC123:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+288
.LPIC124:
	add	r3, pc, r3
	ldr	r3, [r3, #8]
	add	r3, r3, #52
	mov	r2, #3
	str	r2, [r3]
	ldr	r3, .L89+292
.LPIC125:
	add	r3, pc, r3
	ldr	r3, [r3]
	add	r3, r3, #56
	ldr	r2, .L89+296
.LPIC126:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+300
.LPIC127:
	add	r3, pc, r3
	ldr	r3, [r3, #4]
	add	r3, r3, #56
	ldr	r2, .L89+304
.LPIC128:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+308
.LPIC129:
	add	r3, pc, r3
	ldr	r3, [r3, #8]
	add	r3, r3, #56
	mov	r2, #3
	str	r2, [r3]
	ldr	r3, .L89+312
.LPIC130:
	add	r3, pc, r3
	ldr	r3, [r3]
	add	r3, r3, #60
	ldr	r2, .L89+316
.LPIC131:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+320
.LPIC132:
	add	r3, pc, r3
	ldr	r3, [r3, #4]
	add	r3, r3, #60
	ldr	r2, .L89+324
.LPIC133:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+328
.LPIC134:
	add	r3, pc, r3
	ldr	r3, [r3, #8]
	add	r3, r3, #60
	mov	r2, #3
	str	r2, [r3]
	ldr	r3, .L89+332
.LPIC135:
	add	r3, pc, r3
	ldr	r3, [r3]
	add	r3, r3, #64
	ldr	r2, .L89+336
.LPIC136:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+340
.LPIC137:
	add	r3, pc, r3
	ldr	r3, [r3, #4]
	add	r3, r3, #64
	ldr	r2, .L89+344
.LPIC138:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+348
.LPIC139:
	add	r3, pc, r3
	ldr	r3, [r3, #8]
	add	r3, r3, #64
	mov	r2, #3
	str	r2, [r3]
	ldr	r3, .L89+352
.LPIC140:
	add	r3, pc, r3
	ldr	r3, [r3]
	add	r3, r3, #68
	ldr	r2, .L89+356
.LPIC141:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+360
.LPIC142:
	add	r3, pc, r3
	ldr	r3, [r3, #4]
	add	r3, r3, #68
	ldr	r2, .L89+364
.LPIC143:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+368
.LPIC144:
	add	r3, pc, r3
	ldr	r3, [r3, #8]
	add	r3, r3, #68
	mov	r2, #3
	str	r2, [r3]
	ldr	r3, .L89+372
.LPIC145:
	add	r3, pc, r3
	ldr	r3, [r3]
	add	r3, r3, #72
	ldr	r2, .L89+376
.LPIC146:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+380
.LPIC147:
	add	r3, pc, r3
	ldr	r3, [r3, #4]
	add	r3, r3, #72
	ldr	r2, .L89+384
.LPIC148:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+388
.LPIC149:
	add	r3, pc, r3
	ldr	r3, [r3, #8]
	add	r3, r3, #72
	mov	r2, #3
	str	r2, [r3]
	ldr	r3, .L89+392
.LPIC150:
	add	r3, pc, r3
	ldr	r3, [r3]
	add	r3, r3, #76
	ldr	r2, .L89+396
.LPIC151:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+400
.LPIC152:
	add	r3, pc, r3
	ldr	r3, [r3, #4]
	add	r3, r3, #76
	ldr	r2, .L89+404
.LPIC153:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+408
.LPIC154:
	add	r3, pc, r3
	ldr	r3, [r3, #8]
	add	r3, r3, #76
	mov	r2, #3
	str	r2, [r3]
	ldr	r3, .L89+412
.LPIC155:
	add	r3, pc, r3
	ldr	r3, [r3]
	add	r3, r3, #80
	ldr	r2, .L89+416
.LPIC156:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+420
.LPIC157:
	add	r3, pc, r3
	ldr	r3, [r3, #4]
	add	r3, r3, #80
	ldr	r2, .L89+424
.LPIC158:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+428
.LPIC159:
	add	r3, pc, r3
	ldr	r3, [r3, #8]
	add	r3, r3, #80
	mov	r2, #4
	str	r2, [r3]
	ldr	r3, .L89+432
.LPIC160:
	add	r3, pc, r3
	ldr	r3, [r3]
	add	r3, r3, #84
	ldr	r2, .L89+436
.LPIC161:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+440
.LPIC162:
	add	r3, pc, r3
	ldr	r3, [r3, #4]
	add	r3, r3, #84
	ldr	r2, .L89+444
.LPIC163:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+448
.LPIC164:
	add	r3, pc, r3
	ldr	r3, [r3, #8]
	add	r3, r3, #84
	mov	r2, #4
	str	r2, [r3]
	ldr	r3, .L89+452
.LPIC165:
	add	r3, pc, r3
	ldr	r3, [r3]
	add	r3, r3, #88
	ldr	r2, .L89+456
.LPIC166:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+460
.LPIC167:
	add	r3, pc, r3
	ldr	r3, [r3, #4]
	add	r3, r3, #88
	ldr	r2, .L89+464
.LPIC168:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+468
.LPIC169:
	add	r3, pc, r3
	ldr	r3, [r3, #8]
	add	r3, r3, #88
	mov	r2, #4
	str	r2, [r3]
	ldr	r3, .L89+472
.LPIC170:
	add	r3, pc, r3
	ldr	r3, [r3]
	add	r3, r3, #92
	ldr	r2, .L89+476
.LPIC171:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+480
.LPIC172:
	add	r3, pc, r3
	ldr	r3, [r3, #4]
	add	r3, r3, #92
	ldr	r2, .L89+484
.LPIC173:
	add	r2, pc, r2
	str	r2, [r3]
	ldr	r3, .L89+488
.LPIC174:
	add	r3, pc, r3
	ldr	r3, [r3, #8]
	add	r3, r3, #92
	mov	r2, #4
	str	r2, [r3]
	mov	r3, #1
	mov	r0, r3
	pop	{fp, pc}
.L90:
	.align	2
.L89:
	.word	instruction_set-(.LPIC52+8)
	.word	instruction_set-(.LPIC53+8)
	.word	instruction_set-(.LPIC54+8)
	.word	instruction_set-(.LPIC55+8)
	.word	.LC2-(.LPIC56+8)
	.word	instruction_set-(.LPIC57+8)
	.word	ws_stack_push-(.LPIC58+8)
	.word	instruction_set-(.LPIC59+8)
	.word	instruction_set-(.LPIC60+8)
	.word	.LC3-(.LPIC61+8)
	.word	instruction_set-(.LPIC62+8)
	.word	ws_stack_dup-(.LPIC63+8)
	.word	instruction_set-(.LPIC64+8)
	.word	instruction_set-(.LPIC65+8)
	.word	.LC4-(.LPIC66+8)
	.word	instruction_set-(.LPIC67+8)
	.word	ws_stack_copy-(.LPIC68+8)
	.word	instruction_set-(.LPIC69+8)
	.word	instruction_set-(.LPIC70+8)
	.word	.LC5-(.LPIC71+8)
	.word	instruction_set-(.LPIC72+8)
	.word	ws_stack_swap-(.LPIC73+8)
	.word	instruction_set-(.LPIC74+8)
	.word	instruction_set-(.LPIC75+8)
	.word	.LC6-(.LPIC76+8)
	.word	instruction_set-(.LPIC77+8)
	.word	ws_stack_discard-(.LPIC78+8)
	.word	instruction_set-(.LPIC79+8)
	.word	instruction_set-(.LPIC80+8)
	.word	.LC7-(.LPIC81+8)
	.word	instruction_set-(.LPIC82+8)
	.word	ws_stack_slide-(.LPIC83+8)
	.word	instruction_set-(.LPIC84+8)
	.word	instruction_set-(.LPIC85+8)
	.word	.LC8-(.LPIC86+8)
	.word	instruction_set-(.LPIC87+8)
	.word	ws_math_add-(.LPIC88+8)
	.word	instruction_set-(.LPIC89+8)
	.word	instruction_set-(.LPIC90+8)
	.word	.LC9-(.LPIC91+8)
	.word	instruction_set-(.LPIC92+8)
	.word	ws_math_sub-(.LPIC93+8)
	.word	instruction_set-(.LPIC94+8)
	.word	instruction_set-(.LPIC95+8)
	.word	.LC10-(.LPIC96+8)
	.word	instruction_set-(.LPIC97+8)
	.word	ws_math_mult-(.LPIC98+8)
	.word	instruction_set-(.LPIC99+8)
	.word	instruction_set-(.LPIC100+8)
	.word	.LC11-(.LPIC101+8)
	.word	instruction_set-(.LPIC102+8)
	.word	ws_math_div-(.LPIC103+8)
	.word	instruction_set-(.LPIC104+8)
	.word	instruction_set-(.LPIC105+8)
	.word	.LC12-(.LPIC106+8)
	.word	instruction_set-(.LPIC107+8)
	.word	ws_math_mod-(.LPIC108+8)
	.word	instruction_set-(.LPIC109+8)
	.word	instruction_set-(.LPIC110+8)
	.word	.LC13-(.LPIC111+8)
	.word	instruction_set-(.LPIC112+8)
	.word	ws_heap_store-(.LPIC113+8)
	.word	instruction_set-(.LPIC114+8)
	.word	instruction_set-(.LPIC115+8)
	.word	.LC14-(.LPIC116+8)
	.word	instruction_set-(.LPIC117+8)
	.word	ws_heap_retrieve-(.LPIC118+8)
	.word	instruction_set-(.LPIC119+8)
	.word	instruction_set-(.LPIC120+8)
	.word	.LC15-(.LPIC121+8)
	.word	instruction_set-(.LPIC122+8)
	.word	ws_flow_mark-(.LPIC123+8)
	.word	instruction_set-(.LPIC124+8)
	.word	instruction_set-(.LPIC125+8)
	.word	.LC16-(.LPIC126+8)
	.word	instruction_set-(.LPIC127+8)
	.word	ws_flow_call-(.LPIC128+8)
	.word	instruction_set-(.LPIC129+8)
	.word	instruction_set-(.LPIC130+8)
	.word	.LC17-(.LPIC131+8)
	.word	instruction_set-(.LPIC132+8)
	.word	ws_flow_jump-(.LPIC133+8)
	.word	instruction_set-(.LPIC134+8)
	.word	instruction_set-(.LPIC135+8)
	.word	.LC18-(.LPIC136+8)
	.word	instruction_set-(.LPIC137+8)
	.word	ws_flow_jz-(.LPIC138+8)
	.word	instruction_set-(.LPIC139+8)
	.word	instruction_set-(.LPIC140+8)
	.word	.LC19-(.LPIC141+8)
	.word	instruction_set-(.LPIC142+8)
	.word	ws_flow_jn-(.LPIC143+8)
	.word	instruction_set-(.LPIC144+8)
	.word	instruction_set-(.LPIC145+8)
	.word	.LC20-(.LPIC146+8)
	.word	instruction_set-(.LPIC147+8)
	.word	ws_flow_ret-(.LPIC148+8)
	.word	instruction_set-(.LPIC149+8)
	.word	instruction_set-(.LPIC150+8)
	.word	.LC21-(.LPIC151+8)
	.word	instruction_set-(.LPIC152+8)
	.word	ws_flow_exit-(.LPIC153+8)
	.word	instruction_set-(.LPIC154+8)
	.word	instruction_set-(.LPIC155+8)
	.word	.LC22-(.LPIC156+8)
	.word	instruction_set-(.LPIC157+8)
	.word	ws_io_outc-(.LPIC158+8)
	.word	instruction_set-(.LPIC159+8)
	.word	instruction_set-(.LPIC160+8)
	.word	.LC23-(.LPIC161+8)
	.word	instruction_set-(.LPIC162+8)
	.word	ws_io_outn-(.LPIC163+8)
	.word	instruction_set-(.LPIC164+8)
	.word	instruction_set-(.LPIC165+8)
	.word	.LC24-(.LPIC166+8)
	.word	instruction_set-(.LPIC167+8)
	.word	ws_io_inc-(.LPIC168+8)
	.word	instruction_set-(.LPIC169+8)
	.word	instruction_set-(.LPIC170+8)
	.word	.LC25-(.LPIC171+8)
	.word	instruction_set-(.LPIC172+8)
	.word	ws_io_inn-(.LPIC173+8)
	.word	instruction_set-(.LPIC174+8)
	.size	create_instruction_set, .-create_instruction_set
	.align	2
	.global	cleanup_instruction_set
	.syntax unified
	.arm
	.type	cleanup_instruction_set, %function
cleanup_instruction_set:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	ldr	r3, .L93
.LPIC175:
	add	r3, pc, r3
	ldr	r3, [r3, #4]
	mov	r0, r3
	bl	free(PLT)
	ldr	r3, .L93+4
.LPIC176:
	add	r3, pc, r3
	ldr	r3, [r3]
	mov	r0, r3
	bl	free(PLT)
	ldr	r3, .L93+8
.LPIC177:
	add	r3, pc, r3
	ldr	r3, [r3, #8]
	mov	r0, r3
	bl	free(PLT)
	nop
	pop	{fp, pc}
.L94:
	.align	2
.L93:
	.word	instruction_set-(.LPIC175+8)
	.word	instruction_set-(.LPIC176+8)
	.word	instruction_set-(.LPIC177+8)
	.size	cleanup_instruction_set, .-cleanup_instruction_set
	.align	2
	.global	locate_jump_labels
	.syntax unified
	.arm
	.type	locate_jump_labels, %function
locate_jump_labels:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, fp, lr}
	add	fp, sp, #8
	sub	sp, sp, #28
	str	r0, [fp, #-32]
	mov	r3, #0
	str	r3, [fp, #-28]
	ldr	r3, .L103
.LPIC178:
	add	r3, pc, r3
	str	r3, [fp, #-16]
	mov	r3, #0
	str	r3, [fp, #-20]
	b	.L96
.L102:
	ldr	r3, [fp, #-20]
	ldr	r2, [fp, #-32]
	add	r3, r2, r3
	mov	r2, #3
	ldr	r1, [fp, #-16]
	mov	r0, r3
	bl	strncmp(PLT)
	mov	r3, r0
	cmp	r3, #0
	bne	.L97
	ldr	r3, [fp, #-20]
	sub	r3, r3, #1
	ldr	r2, [fp, #-32]
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	cmp	r3, #9
	beq	.L97
	ldr	r3, .L103+4
.LPIC179:
	add	r3, pc, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-28]
	lsl	r3, r3, #2
	add	r4, r2, r3
	mov	r1, #1
	mov	r0, #500
	bl	calloc(PLT)
	mov	r3, r0
	str	r3, [r4]
	ldr	r3, [r4]
	cmp	r3, #0
	beq	.L98
	ldr	r3, [fp, #-20]
	add	r3, r3, #3
	str	r3, [fp, #-20]
	mov	r3, #0
	str	r3, [fp, #-24]
	b	.L99
.L100:
	ldr	r2, [fp, #-20]
	ldr	r3, [fp, #-24]
	add	r3, r2, r3
	mov	r2, r3
	ldr	r3, [fp, #-32]
	add	r2, r3, r2
	ldr	r3, .L103+8
.LPIC180:
	add	r3, pc, r3
	ldr	r1, [r3]
	ldr	r3, [fp, #-28]
	lsl	r3, r3, #2
	add	r3, r1, r3
	ldr	r1, [r3]
	ldr	r3, [fp, #-24]
	add	r3, r1, r3
	ldrb	r2, [r2]	@ zero_extendqisi2
	strb	r2, [r3]
	ldr	r3, [fp, #-24]
	add	r3, r3, #1
	str	r3, [fp, #-24]
.L99:
	ldr	r2, [fp, #-20]
	ldr	r3, [fp, #-24]
	add	r3, r2, r3
	mov	r2, r3
	ldr	r3, [fp, #-32]
	add	r3, r3, r2
	ldrb	r3, [r3]	@ zero_extendqisi2
	cmp	r3, #10
	bne	.L100
	ldr	r2, [fp, #-20]
	ldr	r3, [fp, #-24]
	add	r3, r2, r3
	str	r3, [fp, #-20]
	ldr	r3, .L103+12
.LPIC181:
	add	r3, pc, r3
	ldr	r2, [r3, #4]
	ldr	r3, [fp, #-28]
	lsl	r3, r3, #2
	add	r3, r2, r3
	ldr	r2, [fp, #-20]
	add	r2, r2, #1
	str	r2, [r3]
	ldr	r3, [fp, #-28]
	add	r3, r3, #1
	str	r3, [fp, #-28]
	b	.L97
.L98:
	mov	r3, #0
	b	.L101
.L97:
	ldr	r3, [fp, #-20]
	add	r3, r3, #1
	str	r3, [fp, #-20]
.L96:
	ldr	r3, [fp, #-20]
	ldr	r2, [fp, #-32]
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L102
	ldr	r3, .L103+16
.LPIC182:
	add	r3, pc, r3
	ldr	r2, [fp, #-28]
	str	r2, [r3, #8]
	mov	r3, #1
.L101:
	mov	r0, r3
	sub	sp, fp, #8
	@ sp needed
	pop	{r4, fp, pc}
.L104:
	.align	2
.L103:
	.word	.LC15-(.LPIC178+8)
	.word	label_table-(.LPIC179+8)
	.word	label_table-(.LPIC180+8)
	.word	label_table-(.LPIC181+8)
	.word	label_table-(.LPIC182+8)
	.size	locate_jump_labels, .-locate_jump_labels
	.align	2
	.global	add_ret_addr
	.syntax unified
	.arm
	.type	add_ret_addr, %function
add_ret_addr:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #20
	strd	r0, [fp, #-20]
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L106
.L108:
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L106:
	ldr	r3, [fp, #-8]
	cmp	r3, #19
	bgt	.L107
	ldr	r2, .L111
.LPIC183:
	add	r2, pc, r2
	ldr	r3, [fp, #-8]
	lsl	r3, r3, #3
	add	r3, r2, r3
	ldrd	r2, [r3]
	orrs	r3, r2, r3
	bne	.L108
.L107:
	ldr	r3, [fp, #-8]
	cmp	r3, #19
	bgt	.L109
	ldr	r2, .L111+4
.LPIC184:
	add	r2, pc, r2
	ldr	r3, [fp, #-8]
	lsl	r3, r3, #3
	add	r1, r2, r3
	ldrd	r2, [fp, #-20]
	strd	r2, [r1]
	mov	r3, #1
	b	.L110
.L109:
	mov	r3, #0
.L110:
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
.L112:
	.align	2
.L111:
	.word	instruction_index-(.LPIC183+8)
	.word	instruction_index-(.LPIC184+8)
	.size	add_ret_addr, .-add_ret_addr
	.align	2
	.global	get_last_ret_addr
	.syntax unified
	.arm
	.type	get_last_ret_addr, %function
get_last_ret_addr:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #20
	mov	r3, #19
	str	r3, [fp, #-16]
	b	.L114
.L116:
	ldr	r3, [fp, #-16]
	sub	r3, r3, #1
	str	r3, [fp, #-16]
.L114:
	ldr	r2, .L118
.LPIC185:
	add	r2, pc, r2
	ldr	r3, [fp, #-16]
	lsl	r3, r3, #3
	add	r3, r2, r3
	ldrd	r2, [r3]
	orrs	r3, r2, r3
	bne	.L115
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	bne	.L116
.L115:
	ldr	r2, .L118+4
.LPIC186:
	add	r2, pc, r2
	ldr	r3, [fp, #-16]
	lsl	r3, r3, #3
	add	r3, r2, r3
	ldrd	r2, [r3]
	strd	r2, [fp, #-12]
	ldr	r2, .L118+8
.LPIC187:
	add	r2, pc, r2
	ldr	r3, [fp, #-16]
	lsl	r3, r3, #3
	add	r3, r2, r3
	vmov.i32	d16, #0  @ di
	vstr.64	d16, [r3]	@ int
	ldrd	r2, [fp, #-12]
	mov	r0, r2
	mov	r1, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
.L119:
	.align	2
.L118:
	.word	instruction_index-(.LPIC185+8)
	.word	instruction_index-(.LPIC186+8)
	.word	instruction_index-(.LPIC187+8)
	.size	get_last_ret_addr, .-get_last_ret_addr
	.align	2
	.global	step_through_program
	.syntax unified
	.arm
	.type	step_through_program, %function
step_through_program:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, fp, lr}
	add	fp, sp, #16
	sub	sp, sp, #20
	str	r0, [fp, #-32]
	b	.L121
.L127:
	mov	r3, #0
	str	r3, [fp, #-24]
	b	.L122
.L125:
	ldr	r3, .L130
.LPIC188:
	add	r3, pc, r3
	ldrd	r2, [r3]
	ldr	r3, [fp, #-32]
	add	r0, r3, r2
	ldr	r3, .L130+4
.LPIC189:
	add	r3, pc, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-24]
	lsl	r3, r3, #2
	add	r3, r2, r3
	ldr	r1, [r3]
	ldr	r3, .L130+8
.LPIC190:
	add	r3, pc, r3
	ldr	r2, [r3, #8]
	ldr	r3, [fp, #-24]
	lsl	r3, r3, #2
	add	r3, r2, r3
	ldr	r3, [r3]
	mov	r2, r3
	bl	strncmp(PLT)
	mov	r3, r0
	cmp	r3, #0
	bne	.L123
	ldr	r3, .L130+12
.LPIC191:
	add	r3, pc, r3
	ldr	r2, [r3, #4]
	ldr	r3, [fp, #-24]
	lsl	r3, r3, #2
	add	r3, r2, r3
	ldr	r6, [r3]
	ldr	r3, .L130+16
.LPIC192:
	add	r3, pc, r3
	ldrd	r2, [r3]
	ldr	r3, [fp, #-32]
	add	r0, r3, r2
	ldr	r3, .L130+20
.LPIC193:
	add	r3, pc, r3
	ldr	r2, [r3, #8]
	ldr	r3, [fp, #-24]
	lsl	r3, r3, #2
	add	r3, r2, r3
	ldr	r3, [r3]
	mov	r1, r3
	blx	r6
	b	.L124
.L123:
	ldr	r3, [fp, #-24]
	add	r3, r3, #1
	str	r3, [fp, #-24]
.L122:
	ldr	r3, [fp, #-24]
	cmp	r3, #23
	ble	.L125
.L124:
	ldr	r3, [fp, #-24]
	cmp	r3, #24
	bne	.L121
	ldr	r3, .L130+24
.LPIC194:
	add	r3, pc, r3
	ldrd	r2, [r3]
	adds	r4, r2, #1
	adc	r5, r3, #0
	ldr	r3, .L130+28
.LPIC195:
	add	r3, pc, r3
	strd	r4, [r3]
	bl	getchar(PLT)
.L121:
	ldr	r3, .L130+32
.LPIC196:
	add	r3, pc, r3
	ldrd	r2, [r3]
	cmn	r3, #1
	cmneq	r2, #1
	beq	.L129
	ldr	r3, .L130+36
.LPIC197:
	add	r3, pc, r3
	ldrd	r2, [r3]
	ldr	r3, [fp, #-32]
	add	r3, r3, r2
	ldrb	r3, [r3]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L127
	nop
.L129:
	nop
	sub	sp, fp, #16
	@ sp needed
	pop	{r4, r5, r6, fp, pc}
.L131:
	.align	2
.L130:
	.word	current_instruction_index-(.LPIC188+8)
	.word	instruction_set-(.LPIC189+8)
	.word	instruction_set-(.LPIC190+8)
	.word	instruction_set-(.LPIC191+8)
	.word	current_instruction_index-(.LPIC192+8)
	.word	instruction_set-(.LPIC193+8)
	.word	current_instruction_index-(.LPIC194+8)
	.word	current_instruction_index-(.LPIC195+8)
	.word	current_instruction_index-(.LPIC196+8)
	.word	current_instruction_index-(.LPIC197+8)
	.size	step_through_program, .-step_through_program
	.align	2
	.global	convert_ws_to_number
	.syntax unified
	.arm
	.type	convert_ws_to_number, %function
convert_ws_to_number:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, fp, lr}
	add	fp, sp, #28
	sub	sp, sp, #24
	str	r0, [fp, #-48]
	vmov.i32	d16, #0  @ di
	vstr.64	d16, [fp, #-36]	@ int
	ldr	r3, [fp, #-48]
	cmp	r3, #0
	beq	.L133
	ldr	r0, [fp, #-48]
	bl	strlen(PLT)
	mov	r3, r0
	sub	r3, r3, #1
	str	r3, [fp, #-44]
	mov	r3, #0
	str	r3, [fp, #-40]
	b	.L134
.L136:
	ldr	r3, [fp, #-44]
	ldr	r2, [fp, #-48]
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	cmp	r3, #9
	bne	.L135
	mov	r2, #1
	ldr	r3, [fp, #-40]
	lsl	r3, r2, r3
	asr	r2, r3, #31
	mov	r4, r3
	mov	r5, r2
	ldrd	r2, [fp, #-36]
	adds	r8, r2, r4
	adc	r9, r3, r5
	strd	r8, [fp, #-36]
.L135:
	ldr	r3, [fp, #-44]
	sub	r3, r3, #1
	str	r3, [fp, #-44]
	ldr	r3, [fp, #-40]
	add	r3, r3, #1
	str	r3, [fp, #-40]
.L134:
	ldr	r3, [fp, #-44]
	cmp	r3, #0
	bgt	.L136
	ldr	r3, [fp, #-48]
	ldrb	r3, [r3]	@ zero_extendqisi2
	cmp	r3, #9
	bne	.L133
	ldrd	r2, [fp, #-36]
	rsbs	r6, r2, #0
	rsc	r7, r3, #0
	strd	r6, [fp, #-36]
.L133:
	ldrd	r2, [fp, #-36]
	mov	r0, r2
	mov	r1, r3
	sub	sp, fp, #28
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, fp, pc}
	.size	convert_ws_to_number, .-convert_ws_to_number
	.align	2
	.global	retrieve_label_or_number
	.syntax unified
	.arm
	.type	retrieve_label_or_number, %function
retrieve_label_or_number:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	str	r0, [fp, #-16]
	str	r1, [fp, #-20]
	mov	r1, #1
	movw	r0, #501
	bl	calloc(PLT)
	mov	r3, r0
	mov	r2, r3
	ldr	r3, [fp, #-20]
	str	r2, [r3]
	ldr	r3, [fp, #-20]
	ldr	r3, [r3]
	cmp	r3, #0
	beq	.L139
	ldr	r3, [fp, #-20]
	ldr	r3, [r3]
	mov	r2, #500
	ldr	r1, [fp, #-16]
	mov	r0, r3
	bl	strncpy(PLT)
	ldr	r3, [fp, #-20]
	ldr	r3, [r3]
	mov	r1, #10
	mov	r0, r3
	bl	strchr(PLT)
	str	r0, [fp, #-8]
	ldr	r3, [fp, #-8]
	cmp	r3, #0
	beq	.L140
	ldr	r3, [fp, #-8]
	mov	r2, #0
	strb	r2, [r3]
	ldr	r3, [fp, #-20]
	ldr	r3, [r3]
	mov	r0, r3
	bl	strlen(PLT)
	mov	r3, r0
	b	.L141
.L140:
	ldr	r3, [fp, #-20]
	ldr	r3, [r3]
	mov	r0, r3
	bl	free(PLT)
.L139:
	mov	r3, #0
.L141:
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
	.size	retrieve_label_or_number, .-retrieve_label_or_number
	.align	2
	.global	ws_stack_push
	.syntax unified
	.arm
	.type	ws_stack_push, %function
ws_stack_push:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, fp, lr}
	add	fp, sp, #20
	sub	sp, sp, #24
	str	r0, [fp, #-40]
	str	r1, [fp, #-44]
	ldr	r2, .L147
.LPIC200:
	add	r2, pc, r2
	ldr	r3, .L147+4
	ldr	r3, [r2, r3]
	ldr	r3, [r3]
	str	r3, [fp, #-24]
	mov	r3, #0
	mov	r3, #0
	str	r3, [fp, #-32]
	mov	r3, #0
	str	r3, [fp, #-28]
	ldr	r3, [fp, #-44]
	ldr	r2, [fp, #-40]
	add	r3, r2, r3
	sub	r2, fp, #32
	mov	r1, r2
	mov	r0, r3
	bl	retrieve_label_or_number(PLT)
	str	r0, [fp, #-28]
	ldr	r3, [fp, #-28]
	cmp	r3, #0
	beq	.L146
	ldr	r3, [fp, #-32]
	mov	r0, r3
	bl	convert_ws_to_number(PLT)
	mov	r2, r0
	mov	r3, r1
	mov	r0, r2
	mov	r1, r3
	bl	stack_push(PLT)
	ldr	r2, [fp, #-44]
	ldr	r3, [fp, #-28]
	add	r3, r2, r3
	add	r3, r3, #1
	asr	r2, r3, #31
	mov	r4, r3
	mov	r5, r2
	ldr	r3, .L147+8
.LPIC198:
	add	r3, pc, r3
	ldrd	r2, [r3]
	adds	r6, r4, r2
	adc	r7, r5, r3
	ldr	r3, .L147+12
.LPIC199:
	add	r3, pc, r3
	strd	r6, [r3]
	ldr	r3, [fp, #-32]
	mov	r0, r3
	bl	free(PLT)
	nop
.L146:
	nop
	ldr	r2, .L147+16
.LPIC201:
	add	r2, pc, r2
	ldr	r3, .L147+4
	ldr	r3, [r2, r3]
	ldr	r2, [r3]
	ldr	r3, [fp, #-24]
	eors	r2, r3, r2
	mov	r3, #0
	beq	.L145
	bl	__stack_chk_fail(PLT)
.L145:
	sub	sp, fp, #20
	@ sp needed
	pop	{r4, r5, r6, r7, fp, pc}
.L148:
	.align	2
.L147:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC200+8)
	.word	__stack_chk_guard(GOT)
	.word	current_instruction_index-(.LPIC198+8)
	.word	current_instruction_index-(.LPIC199+8)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC201+8)
	.size	ws_stack_push, .-ws_stack_push
	.align	2
	.global	ws_stack_dup
	.syntax unified
	.arm
	.type	ws_stack_dup, %function
ws_stack_dup:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, fp, lr}
	add	fp, sp, #20
	sub	sp, sp, #8
	str	r0, [fp, #-24]
	str	r1, [fp, #-28]
	mov	r0, #0
	bl	stack_peak(PLT)
	mov	r2, r0
	mov	r3, r1
	mov	r0, r2
	mov	r1, r3
	bl	stack_push(PLT)
	ldr	r3, [fp, #-28]
	asr	r2, r3, #31
	mov	r4, r3
	mov	r5, r2
	ldr	r3, .L151
.LPIC202:
	add	r3, pc, r3
	ldrd	r2, [r3]
	adds	r6, r4, r2
	adc	r7, r5, r3
	ldr	r3, .L151+4
.LPIC203:
	add	r3, pc, r3
	strd	r6, [r3]
	nop
	sub	sp, fp, #20
	@ sp needed
	pop	{r4, r5, r6, r7, fp, pc}
.L152:
	.align	2
.L151:
	.word	current_instruction_index-(.LPIC202+8)
	.word	current_instruction_index-(.LPIC203+8)
	.size	ws_stack_dup, .-ws_stack_dup
	.align	2
	.global	ws_stack_copy
	.syntax unified
	.arm
	.type	ws_stack_copy, %function
ws_stack_copy:
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, fp, lr}
	add	fp, sp, #28
	sub	sp, sp, #32
	str	r0, [fp, #-48]
	str	r1, [fp, #-52]
	ldr	r2, .L158
.LPIC208:
	add	r2, pc, r2
	ldr	r3, .L158+4
	ldr	r3, [r2, r3]
	ldr	r3, [r3]
	str	r3, [fp, #-32]
	mov	r3, #0
	mov	r3, #0
	str	r3, [fp, #-40]
	mov	r3, #0
	str	r3, [fp, #-36]
	ldr	r3, [fp, #-52]
	ldr	r2, [fp, #-48]
	add	r3, r2, r3
	sub	r2, fp, #40
	mov	r1, r2
	mov	r0, r3
	bl	retrieve_label_or_number(PLT)
	str	r0, [fp, #-36]
	ldr	r3, [fp, #-36]
	cmp	r3, #0
	beq	.L154
	ldr	r3, [fp, #-40]
	mov	r0, r3
	bl	convert_ws_to_number(PLT)
	mov	r2, r0
	mov	r3, r1
	mov	r3, r2
	mov	r0, r3
	bl	stack_peak(PLT)
	mov	r2, r0
	mov	r3, r1
	mov	r0, r2
	mov	r1, r3
	bl	stack_push(PLT)
	ldr	r2, [fp, #-52]
	ldr	r3, [fp, #-36]
	add	r3, r2, r3
	add	r3, r3, #1
	asr	r2, r3, #31
	mov	r6, r3
	mov	r7, r2
	ldr	r3, .L158+8
.LPIC204:
	add	r3, pc, r3
	ldrd	r2, [r3]
	adds	r1, r6, r2
	str	r1, [fp, #-60]
	adc	r3, r7, r3
	str	r3, [fp, #-56]
	ldr	r3, .L158+12
.LPIC205:
	add	r3, pc, r3
	ldrd	r0, [fp, #-60]
	strd	r0, [r3]
	ldr	r3, [fp, #-40]
	mov	r0, r3
	bl	free(PLT)
	b	.L153
.L154:
	ldr	r3, [fp, #-52]
	asr	r2, r3, #31
	mov	r4, r3
	mov	r5, r2
	ldr	r3, .L158+16
.LPIC206:
	add	r3, pc, r3
	ldrd	r2, [r3]
	adds	r8, r4, r2
	adc	r9, r5, r3
	ldr	r3, .L158+20
.LPIC207:
	add	r3, pc, r3
	strd	r8, [r3]
	nop
.L153:
	ldr	r2, .L158+24
.LPIC209:
	add	r2, pc, r2
	ldr	r3, .L158+4
	ldr	r3, [r2, r3]
	ldr	r2, [r3]
	ldr	r3, [fp, #-32]
	eors	r2, r3, r2
	mov	r3, #0
	beq	.L157
	bl	__stack_chk_fail(PLT)
.L157:
	sub	sp, fp, #28
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, fp, pc}
.L159:
	.align	2
.L158:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC208+8)
	.word	__stack_chk_guard(GOT)
	.word	current_instruction_index-(.LPIC204+8)
	.word	current_instruction_index-(.LPIC205+8)
	.word	current_instruction_index-(.LPIC206+8)
	.word	current_instruction_index-(.LPIC207+8)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC209+8)
	.size	ws_stack_copy, .-ws_stack_copy
	.align	2
	.global	ws_stack_swap
	.syntax unified
	.arm
	.type	ws_stack_swap, %function
ws_stack_swap:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, fp, lr}
	add	fp, sp, #20
	sub	sp, sp, #24
	str	r0, [fp, #-40]
	str	r1, [fp, #-44]
	bl	stack_pop(PLT)
	strd	r0, [fp, #-36]
	bl	stack_pop(PLT)
	strd	r0, [fp, #-28]
	ldrd	r0, [fp, #-36]
	bl	stack_push(PLT)
	ldrd	r0, [fp, #-28]
	bl	stack_push(PLT)
	ldr	r3, [fp, #-44]
	asr	r2, r3, #31
	mov	r4, r3
	mov	r5, r2
	ldr	r3, .L162
.LPIC210:
	add	r3, pc, r3
	ldrd	r2, [r3]
	adds	r6, r4, r2
	adc	r7, r5, r3
	ldr	r3, .L162+4
.LPIC211:
	add	r3, pc, r3
	strd	r6, [r3]
	nop
	sub	sp, fp, #20
	@ sp needed
	pop	{r4, r5, r6, r7, fp, pc}
.L163:
	.align	2
.L162:
	.word	current_instruction_index-(.LPIC210+8)
	.word	current_instruction_index-(.LPIC211+8)
	.size	ws_stack_swap, .-ws_stack_swap
	.align	2
	.global	ws_stack_discard
	.syntax unified
	.arm
	.type	ws_stack_discard, %function
ws_stack_discard:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, fp, lr}
	add	fp, sp, #20
	sub	sp, sp, #8
	str	r0, [fp, #-24]
	str	r1, [fp, #-28]
	bl	stack_pop(PLT)
	ldr	r3, [fp, #-28]
	asr	r2, r3, #31
	mov	r4, r3
	mov	r5, r2
	ldr	r3, .L166
.LPIC212:
	add	r3, pc, r3
	ldrd	r2, [r3]
	adds	r6, r4, r2
	adc	r7, r5, r3
	ldr	r3, .L166+4
.LPIC213:
	add	r3, pc, r3
	strd	r6, [r3]
	nop
	sub	sp, fp, #20
	@ sp needed
	pop	{r4, r5, r6, r7, fp, pc}
.L167:
	.align	2
.L166:
	.word	current_instruction_index-(.LPIC212+8)
	.word	current_instruction_index-(.LPIC213+8)
	.size	ws_stack_discard, .-ws_stack_discard
	.align	2
	.global	ws_stack_slide
	.syntax unified
	.arm
	.type	ws_stack_slide, %function
ws_stack_slide:
	@ args = 0, pretend = 0, frame = 48
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, fp, lr}
	add	fp, sp, #28
	sub	sp, sp, #48
	str	r0, [fp, #-64]
	str	r1, [fp, #-68]
	ldr	r2, .L175
.LPIC218:
	add	r2, pc, r2
	ldr	r3, .L175+4
	ldr	r3, [r2, r3]
	ldr	r3, [r3]
	str	r3, [fp, #-32]
	mov	r3, #0
	bl	stack_pop(PLT)
	strd	r0, [fp, #-44]
	mov	r3, #0
	str	r3, [fp, #-48]
	mov	r3, #0
	str	r3, [fp, #-56]
	ldr	r3, [fp, #-68]
	ldr	r2, [fp, #-64]
	add	r3, r2, r3
	sub	r2, fp, #56
	mov	r1, r2
	mov	r0, r3
	bl	retrieve_label_or_number(PLT)
	str	r0, [fp, #-48]
	ldr	r3, [fp, #-48]
	cmp	r3, #0
	beq	.L169
	ldr	r3, [fp, #-56]
	mov	r0, r3
	bl	convert_ws_to_number(PLT)
	mov	r2, r0
	mov	r3, r1
	mov	r3, r2
	str	r3, [fp, #-52]
	b	.L170
.L171:
	bl	stack_pop(PLT)
	ldr	r3, [fp, #-52]
	sub	r3, r3, #1
	str	r3, [fp, #-52]
.L170:
	ldr	r3, [fp, #-52]
	cmp	r3, #0
	bgt	.L171
	ldrd	r0, [fp, #-44]
	bl	stack_push(PLT)
	ldr	r2, [fp, #-68]
	ldr	r3, [fp, #-48]
	add	r3, r2, r3
	add	r3, r3, #1
	asr	r2, r3, #31
	mov	r6, r3
	mov	r7, r2
	ldr	r3, .L175+8
.LPIC214:
	add	r3, pc, r3
	ldrd	r2, [r3]
	adds	r1, r6, r2
	str	r1, [fp, #-76]
	adc	r3, r7, r3
	str	r3, [fp, #-72]
	ldr	r3, .L175+12
.LPIC215:
	add	r3, pc, r3
	ldrd	r0, [fp, #-76]
	strd	r0, [r3]
	ldr	r3, [fp, #-56]
	mov	r0, r3
	bl	free(PLT)
	b	.L168
.L169:
	ldr	r3, [fp, #-68]
	asr	r2, r3, #31
	mov	r4, r3
	mov	r5, r2
	ldr	r3, .L175+16
.LPIC216:
	add	r3, pc, r3
	ldrd	r2, [r3]
	adds	r8, r4, r2
	adc	r9, r5, r3
	ldr	r3, .L175+20
.LPIC217:
	add	r3, pc, r3
	strd	r8, [r3]
	nop
.L168:
	ldr	r2, .L175+24
.LPIC219:
	add	r2, pc, r2
	ldr	r3, .L175+4
	ldr	r3, [r2, r3]
	ldr	r2, [r3]
	ldr	r3, [fp, #-32]
	eors	r2, r3, r2
	mov	r3, #0
	beq	.L174
	bl	__stack_chk_fail(PLT)
.L174:
	sub	sp, fp, #28
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, fp, pc}
.L176:
	.align	2
.L175:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC218+8)
	.word	__stack_chk_guard(GOT)
	.word	current_instruction_index-(.LPIC214+8)
	.word	current_instruction_index-(.LPIC215+8)
	.word	current_instruction_index-(.LPIC216+8)
	.word	current_instruction_index-(.LPIC217+8)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC219+8)
	.size	ws_stack_slide, .-ws_stack_slide
	.align	2
	.global	ws_math_add
	.syntax unified
	.arm
	.type	ws_math_add, %function
ws_math_add:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, fp, lr}
	add	fp, sp, #28
	sub	sp, sp, #24
	str	r0, [fp, #-48]
	str	r1, [fp, #-52]
	bl	stack_pop(PLT)
	strd	r0, [fp, #-44]
	bl	stack_pop(PLT)
	strd	r0, [fp, #-36]
	ldrd	r0, [fp, #-36]
	ldrd	r2, [fp, #-44]
	adds	r8, r0, r2
	adc	r9, r1, r3
	mov	r0, r8
	mov	r1, r9
	bl	stack_push(PLT)
	ldr	r3, [fp, #-52]
	asr	r2, r3, #31
	mov	r4, r3
	mov	r5, r2
	ldr	r3, .L179
.LPIC220:
	add	r3, pc, r3
	ldrd	r2, [r3]
	adds	r6, r4, r2
	adc	r7, r5, r3
	ldr	r3, .L179+4
.LPIC221:
	add	r3, pc, r3
	strd	r6, [r3]
	nop
	sub	sp, fp, #28
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, fp, pc}
.L180:
	.align	2
.L179:
	.word	current_instruction_index-(.LPIC220+8)
	.word	current_instruction_index-(.LPIC221+8)
	.size	ws_math_add, .-ws_math_add
	.align	2
	.global	ws_math_sub
	.syntax unified
	.arm
	.type	ws_math_sub, %function
ws_math_sub:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, fp, lr}
	add	fp, sp, #28
	sub	sp, sp, #24
	str	r0, [fp, #-48]
	str	r1, [fp, #-52]
	bl	stack_pop(PLT)
	strd	r0, [fp, #-44]
	bl	stack_pop(PLT)
	strd	r0, [fp, #-36]
	ldrd	r0, [fp, #-36]
	ldrd	r2, [fp, #-44]
	subs	r8, r0, r2
	sbc	r9, r1, r3
	mov	r0, r8
	mov	r1, r9
	bl	stack_push(PLT)
	ldr	r3, [fp, #-52]
	asr	r2, r3, #31
	mov	r4, r3
	mov	r5, r2
	ldr	r3, .L183
.LPIC222:
	add	r3, pc, r3
	ldrd	r2, [r3]
	adds	r6, r4, r2
	adc	r7, r5, r3
	ldr	r3, .L183+4
.LPIC223:
	add	r3, pc, r3
	strd	r6, [r3]
	nop
	sub	sp, fp, #28
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, fp, pc}
.L184:
	.align	2
.L183:
	.word	current_instruction_index-(.LPIC222+8)
	.word	current_instruction_index-(.LPIC223+8)
	.size	ws_math_sub, .-ws_math_sub
	.align	2
	.global	ws_math_mult
	.syntax unified
	.arm
	.type	ws_math_mult, %function
ws_math_mult:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, fp, lr}
	add	fp, sp, #28
	sub	sp, sp, #24
	str	r0, [fp, #-48]
	str	r1, [fp, #-52]
	bl	stack_pop(PLT)
	strd	r0, [fp, #-44]
	bl	stack_pop(PLT)
	strd	r0, [fp, #-36]
	ldr	r3, [fp, #-32]
	ldr	r2, [fp, #-44]
	mul	r2, r2, r3
	ldr	r3, [fp, #-40]
	ldr	r1, [fp, #-36]
	mul	r3, r1, r3
	add	r3, r2, r3
	ldr	r1, [fp, #-36]
	ldr	r2, [fp, #-44]
	umull	r4, r5, r1, r2
	add	r3, r3, r5
	mov	r5, r3
	mov	r0, r4
	mov	r1, r5
	bl	stack_push(PLT)
	ldr	r3, [fp, #-52]
	asr	r2, r3, #31
	mov	r6, r3
	mov	r7, r2
	ldr	r3, .L187
.LPIC224:
	add	r3, pc, r3
	ldrd	r2, [r3]
	adds	r8, r6, r2
	adc	r9, r7, r3
	ldr	r3, .L187+4
.LPIC225:
	add	r3, pc, r3
	strd	r8, [r3]
	nop
	sub	sp, fp, #28
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, fp, pc}
.L188:
	.align	2
.L187:
	.word	current_instruction_index-(.LPIC224+8)
	.word	current_instruction_index-(.LPIC225+8)
	.size	ws_math_mult, .-ws_math_mult
	.align	2
	.global	ws_math_div
	.syntax unified
	.arm
	.type	ws_math_div, %function
ws_math_div:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, fp, lr}
	add	fp, sp, #20
	sub	sp, sp, #24
	str	r0, [fp, #-40]
	str	r1, [fp, #-44]
	bl	stack_pop(PLT)
	strd	r0, [fp, #-36]
	bl	stack_pop(PLT)
	strd	r0, [fp, #-28]
	ldrd	r2, [fp, #-36]
	ldrd	r0, [fp, #-28]
	bl	__aeabi_ldivmod(PLT)
	mov	r2, r0
	mov	r3, r1
	mov	r0, r2
	mov	r1, r3
	bl	stack_push(PLT)
	ldr	r3, [fp, #-44]
	asr	r2, r3, #31
	mov	r4, r3
	mov	r5, r2
	ldr	r3, .L191
.LPIC226:
	add	r3, pc, r3
	ldrd	r2, [r3]
	adds	r6, r4, r2
	adc	r7, r5, r3
	ldr	r3, .L191+4
.LPIC227:
	add	r3, pc, r3
	strd	r6, [r3]
	nop
	sub	sp, fp, #20
	@ sp needed
	pop	{r4, r5, r6, r7, fp, pc}
.L192:
	.align	2
.L191:
	.word	current_instruction_index-(.LPIC226+8)
	.word	current_instruction_index-(.LPIC227+8)
	.size	ws_math_div, .-ws_math_div
	.align	2
	.global	ws_math_mod
	.syntax unified
	.arm
	.type	ws_math_mod, %function
ws_math_mod:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, fp, lr}
	add	fp, sp, #20
	sub	sp, sp, #24
	str	r0, [fp, #-40]
	str	r1, [fp, #-44]
	bl	stack_pop(PLT)
	strd	r0, [fp, #-36]
	bl	stack_pop(PLT)
	strd	r0, [fp, #-28]
	ldrd	r0, [fp, #-28]
	ldrd	r2, [fp, #-36]
	bl	__aeabi_ldivmod(PLT)
	mov	r0, r2
	mov	r1, r3
	bl	stack_push(PLT)
	ldr	r3, [fp, #-44]
	asr	r2, r3, #31
	mov	r4, r3
	mov	r5, r2
	ldr	r3, .L195
.LPIC228:
	add	r3, pc, r3
	ldrd	r2, [r3]
	adds	r6, r4, r2
	adc	r7, r5, r3
	ldr	r3, .L195+4
.LPIC229:
	add	r3, pc, r3
	strd	r6, [r3]
	nop
	sub	sp, fp, #20
	@ sp needed
	pop	{r4, r5, r6, r7, fp, pc}
.L196:
	.align	2
.L195:
	.word	current_instruction_index-(.LPIC228+8)
	.word	current_instruction_index-(.LPIC229+8)
	.size	ws_math_mod, .-ws_math_mod
	.align	2
	.global	ws_heap_store
	.syntax unified
	.arm
	.type	ws_heap_store, %function
ws_heap_store:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, fp, lr}
	add	fp, sp, #20
	sub	sp, sp, #24
	str	r0, [fp, #-40]
	str	r1, [fp, #-44]
	bl	stack_pop(PLT)
	strd	r0, [fp, #-36]
	bl	stack_pop(PLT)
	strd	r0, [fp, #-28]
	ldrd	r2, [fp, #-28]
	ldrd	r0, [fp, #-36]
	bl	heap_put(PLT)
	ldr	r3, [fp, #-44]
	asr	r2, r3, #31
	mov	r4, r3
	mov	r5, r2
	ldr	r3, .L199
.LPIC230:
	add	r3, pc, r3
	ldrd	r2, [r3]
	adds	r6, r4, r2
	adc	r7, r5, r3
	ldr	r3, .L199+4
.LPIC231:
	add	r3, pc, r3
	strd	r6, [r3]
	nop
	sub	sp, fp, #20
	@ sp needed
	pop	{r4, r5, r6, r7, fp, pc}
.L200:
	.align	2
.L199:
	.word	current_instruction_index-(.LPIC230+8)
	.word	current_instruction_index-(.LPIC231+8)
	.size	ws_heap_store, .-ws_heap_store
	.align	2
	.global	ws_heap_retrieve
	.syntax unified
	.arm
	.type	ws_heap_retrieve, %function
ws_heap_retrieve:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, fp, lr}
	add	fp, sp, #20
	sub	sp, sp, #8
	str	r0, [fp, #-24]
	str	r1, [fp, #-28]
	bl	stack_pop(PLT)
	mov	r2, r0
	mov	r3, r1
	mov	r0, r2
	mov	r1, r3
	bl	heap_get(PLT)
	mov	r2, r0
	mov	r3, r1
	mov	r0, r2
	mov	r1, r3
	bl	stack_push(PLT)
	ldr	r3, [fp, #-28]
	asr	r2, r3, #31
	mov	r4, r3
	mov	r5, r2
	ldr	r3, .L203
.LPIC232:
	add	r3, pc, r3
	ldrd	r2, [r3]
	adds	r6, r4, r2
	adc	r7, r5, r3
	ldr	r3, .L203+4
.LPIC233:
	add	r3, pc, r3
	strd	r6, [r3]
	nop
	sub	sp, fp, #20
	@ sp needed
	pop	{r4, r5, r6, r7, fp, pc}
.L204:
	.align	2
.L203:
	.word	current_instruction_index-(.LPIC232+8)
	.word	current_instruction_index-(.LPIC233+8)
	.size	ws_heap_retrieve, .-ws_heap_retrieve
	.align	2
	.global	ws_flow_mark
	.syntax unified
	.arm
	.type	ws_flow_mark, %function
ws_flow_mark:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r4, r5, r6, r7, fp}
	add	fp, sp, #16
	sub	sp, sp, #20
	str	r0, [fp, #-32]
	str	r1, [fp, #-36]
	mov	r3, #1
	str	r3, [fp, #-24]
	b	.L206
.L207:
	ldr	r3, [fp, #-24]
	add	r3, r3, #1
	str	r3, [fp, #-24]
.L206:
	ldr	r3, [fp, #-24]
	ldr	r2, [fp, #-32]
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	cmp	r3, #10
	bne	.L207
	ldr	r3, [fp, #-24]
	add	r3, r3, #1
	asr	r2, r3, #31
	mov	r4, r3
	mov	r5, r2
	ldr	r3, .L209
.LPIC234:
	add	r3, pc, r3
	ldrd	r2, [r3]
	adds	r6, r4, r2
	adc	r7, r5, r3
	ldr	r3, .L209+4
.LPIC235:
	add	r3, pc, r3
	strd	r6, [r3]
	nop
	sub	sp, fp, #16
	@ sp needed
	pop	{r4, r5, r6, r7, fp}
	bx	lr
.L210:
	.align	2
.L209:
	.word	current_instruction_index-(.LPIC234+8)
	.word	current_instruction_index-(.LPIC235+8)
	.size	ws_flow_mark, .-ws_flow_mark
	.align	2
	.global	ws_flow_call
	.syntax unified
	.arm
	.type	ws_flow_call, %function
ws_flow_call:
	@ args = 0, pretend = 0, frame = 56
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, fp, lr}
	add	fp, sp, #28
	sub	sp, sp, #56
	str	r0, [fp, #-48]
	str	r1, [fp, #-52]
	ldr	r2, .L217
.LPIC238:
	add	r2, pc, r2
	ldr	r3, .L217+4
	ldr	r3, [r2, r3]
	ldr	r3, [r3]
	str	r3, [fp, #-32]
	mov	r3, #0
	mov	r3, #0
	str	r3, [fp, #-36]
	ldr	r2, [fp, #-52]
	ldr	r3, [fp, #-48]
	add	r2, r3, r2
	sub	r3, fp, #40
	mov	r1, r3
	mov	r0, r2
	bl	retrieve_label_or_number(PLT)
	str	r0, [fp, #-36]
	ldr	r3, [fp, #-36]
	cmp	r3, #0
	beq	.L212
	ldr	r3, [fp, #-52]
	asr	r2, r3, #31
	str	r3, [fp, #-60]
	str	r2, [fp, #-56]
	ldr	r3, .L217+8
.LPIC236:
	add	r3, pc, r3
	ldrd	r2, [r3]
	ldrd	r0, [fp, #-60]
	mov	ip, r0
	adds	r6, ip, r2
	adc	r7, r1, r3
	ldr	r3, [fp, #-36]
	asr	r2, r3, #31
	str	r3, [fp, #-68]
	str	r2, [fp, #-64]
	ldrd	r2, [fp, #-68]
	mov	r1, r2
	adds	r4, r6, r1
	adc	r5, r7, r3
	adds	r3, r4, #1
	str	r3, [fp, #-76]
	adc	r3, r5, #0
	str	r3, [fp, #-72]
	ldrd	r0, [fp, #-76]
	bl	add_ret_addr(PLT)
	mov	r3, r0
	cmp	r3, #0
	beq	.L213
	ldr	r1, [fp, #-52]
	ldr	r0, [fp, #-48]
	bl	ws_flow_jump(PLT)
.L213:
	ldr	r3, [fp, #-40]
	mov	r0, r3
	bl	free(PLT)
	b	.L211
.L212:
	ldr	r3, [fp, #-52]
	asr	r2, r3, #31
	mov	r8, r3
	mov	r9, r2
	ldr	r3, .L217+12
.LPIC237:
	add	r3, pc, r3
	ldrd	r2, [r3]
	adds	r1, r8, r2
	str	r1, [fp, #-84]
	adc	r3, r9, r3
	str	r3, [fp, #-80]
	ldrd	r0, [fp, #-84]
	bl	add_ret_addr(PLT)
	nop
.L211:
	ldr	r2, .L217+16
.LPIC239:
	add	r2, pc, r2
	ldr	r3, .L217+4
	ldr	r3, [r2, r3]
	ldr	r2, [r3]
	ldr	r3, [fp, #-32]
	eors	r2, r3, r2
	mov	r3, #0
	beq	.L216
	bl	__stack_chk_fail(PLT)
.L216:
	sub	sp, fp, #28
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, fp, pc}
.L218:
	.align	2
.L217:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC238+8)
	.word	__stack_chk_guard(GOT)
	.word	current_instruction_index-(.LPIC236+8)
	.word	current_instruction_index-(.LPIC237+8)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC239+8)
	.size	ws_flow_call, .-ws_flow_call
	.align	2
	.global	ws_flow_jump
	.syntax unified
	.arm
	.type	ws_flow_jump, %function
ws_flow_jump:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, fp, lr}
	add	fp, sp, #28
	sub	sp, sp, #24
	str	r0, [fp, #-48]
	str	r1, [fp, #-52]
	ldr	r2, .L228
.LPIC246:
	add	r2, pc, r2
	ldr	r3, .L228+4
	ldr	r3, [r2, r3]
	ldr	r3, [r3]
	str	r3, [fp, #-32]
	mov	r3, #0
	ldr	r3, [fp, #-52]
	ldr	r2, [fp, #-48]
	add	r3, r2, r3
	sub	r2, fp, #40
	mov	r1, r2
	mov	r0, r3
	bl	retrieve_label_or_number(PLT)
	mov	r3, r0
	cmp	r3, #0
	beq	.L220
	mov	r3, #0
	str	r3, [fp, #-36]
	b	.L221
.L224:
	ldr	r3, .L228+8
.LPIC240:
	add	r3, pc, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-36]
	lsl	r3, r3, #2
	add	r3, r2, r3
	ldr	r3, [r3]
	ldr	r2, [fp, #-40]
	mov	r1, r2
	mov	r0, r3
	bl	strcmp(PLT)
	mov	r3, r0
	cmp	r3, #0
	bne	.L222
	ldr	r3, .L228+12
.LPIC241:
	add	r3, pc, r3
	ldr	r2, [r3, #4]
	ldr	r3, [fp, #-36]
	lsl	r3, r3, #2
	add	r3, r2, r3
	ldr	r3, [r3]
	asr	r2, r3, #31
	mov	r8, r3
	mov	r9, r2
	ldr	r3, .L228+16
.LPIC242:
	add	r3, pc, r3
	strd	r8, [r3]
	b	.L223
.L222:
	ldr	r3, [fp, #-36]
	add	r3, r3, #1
	str	r3, [fp, #-36]
.L221:
	ldr	r3, .L228+20
.LPIC243:
	add	r3, pc, r3
	ldr	r3, [r3, #8]
	ldr	r2, [fp, #-36]
	cmp	r2, r3
	blt	.L224
.L223:
	ldr	r3, [fp, #-40]
	mov	r0, r3
	bl	free(PLT)
	b	.L219
.L220:
	ldr	r3, [fp, #-52]
	asr	r2, r3, #31
	mov	r4, r3
	mov	r5, r2
	ldr	r3, .L228+24
.LPIC244:
	add	r3, pc, r3
	ldrd	r2, [r3]
	adds	r6, r4, r2
	adc	r7, r5, r3
	ldr	r3, .L228+28
.LPIC245:
	add	r3, pc, r3
	strd	r6, [r3]
	nop
.L219:
	ldr	r2, .L228+32
.LPIC247:
	add	r2, pc, r2
	ldr	r3, .L228+4
	ldr	r3, [r2, r3]
	ldr	r2, [r3]
	ldr	r3, [fp, #-32]
	eors	r2, r3, r2
	mov	r3, #0
	beq	.L227
	bl	__stack_chk_fail(PLT)
.L227:
	sub	sp, fp, #28
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, fp, pc}
.L229:
	.align	2
.L228:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC246+8)
	.word	__stack_chk_guard(GOT)
	.word	label_table-(.LPIC240+8)
	.word	label_table-(.LPIC241+8)
	.word	current_instruction_index-(.LPIC242+8)
	.word	label_table-(.LPIC243+8)
	.word	current_instruction_index-(.LPIC244+8)
	.word	current_instruction_index-(.LPIC245+8)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC247+8)
	.size	ws_flow_jump, .-ws_flow_jump
	.align	2
	.global	ws_flow_jz
	.syntax unified
	.arm
	.type	ws_flow_jz, %function
ws_flow_jz:
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, fp, lr}
	add	fp, sp, #28
	sub	sp, sp, #32
	str	r0, [fp, #-48]
	str	r1, [fp, #-52]
	ldr	r2, .L236
.LPIC252:
	add	r2, pc, r2
	ldr	r3, .L236+4
	ldr	r3, [r2, r3]
	ldr	r3, [r3]
	str	r3, [fp, #-32]
	mov	r3, #0
	bl	stack_pop(PLT)
	mov	r2, r0
	mov	r3, r1
	orrs	r3, r2, r3
	bne	.L231
	ldr	r1, [fp, #-52]
	ldr	r0, [fp, #-48]
	bl	ws_flow_jump(PLT)
	b	.L230
.L231:
	ldr	r3, [fp, #-52]
	ldr	r2, [fp, #-48]
	add	r3, r2, r3
	sub	r2, fp, #40
	mov	r1, r2
	mov	r0, r3
	bl	retrieve_label_or_number(PLT)
	str	r0, [fp, #-36]
	ldr	r3, [fp, #-36]
	cmp	r3, #0
	beq	.L233
	ldr	r2, [fp, #-52]
	ldr	r3, [fp, #-36]
	add	r3, r2, r3
	add	r3, r3, #1
	asr	r2, r3, #31
	mov	r6, r3
	mov	r7, r2
	ldr	r3, .L236+8
.LPIC248:
	add	r3, pc, r3
	ldrd	r2, [r3]
	adds	r1, r6, r2
	str	r1, [fp, #-60]
	adc	r3, r7, r3
	str	r3, [fp, #-56]
	ldr	r3, .L236+12
.LPIC249:
	add	r3, pc, r3
	ldrd	r0, [fp, #-60]
	strd	r0, [r3]
	ldr	r3, [fp, #-40]
	mov	r0, r3
	bl	free(PLT)
	b	.L230
.L233:
	ldr	r3, [fp, #-52]
	asr	r2, r3, #31
	mov	r4, r3
	mov	r5, r2
	ldr	r3, .L236+16
.LPIC250:
	add	r3, pc, r3
	ldrd	r2, [r3]
	adds	r8, r4, r2
	adc	r9, r5, r3
	ldr	r3, .L236+20
.LPIC251:
	add	r3, pc, r3
	strd	r8, [r3]
	nop
.L230:
	ldr	r2, .L236+24
.LPIC253:
	add	r2, pc, r2
	ldr	r3, .L236+4
	ldr	r3, [r2, r3]
	ldr	r2, [r3]
	ldr	r3, [fp, #-32]
	eors	r2, r3, r2
	mov	r3, #0
	beq	.L235
	bl	__stack_chk_fail(PLT)
.L235:
	sub	sp, fp, #28
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, fp, pc}
.L237:
	.align	2
.L236:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC252+8)
	.word	__stack_chk_guard(GOT)
	.word	current_instruction_index-(.LPIC248+8)
	.word	current_instruction_index-(.LPIC249+8)
	.word	current_instruction_index-(.LPIC250+8)
	.word	current_instruction_index-(.LPIC251+8)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC253+8)
	.size	ws_flow_jz, .-ws_flow_jz
	.align	2
	.global	ws_flow_jn
	.syntax unified
	.arm
	.type	ws_flow_jn, %function
ws_flow_jn:
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, fp, lr}
	add	fp, sp, #28
	sub	sp, sp, #32
	str	r0, [fp, #-48]
	str	r1, [fp, #-52]
	ldr	r2, .L244
.LPIC258:
	add	r2, pc, r2
	ldr	r3, .L244+4
	ldr	r3, [r2, r3]
	ldr	r3, [r3]
	str	r3, [fp, #-32]
	mov	r3, #0
	bl	stack_pop(PLT)
	mov	r2, r0
	mov	r3, r1
	cmp	r3, #0
	bge	.L239
	ldr	r1, [fp, #-52]
	ldr	r0, [fp, #-48]
	bl	ws_flow_jump(PLT)
	b	.L238
.L239:
	ldr	r3, [fp, #-52]
	ldr	r2, [fp, #-48]
	add	r3, r2, r3
	sub	r2, fp, #40
	mov	r1, r2
	mov	r0, r3
	bl	retrieve_label_or_number(PLT)
	str	r0, [fp, #-36]
	ldr	r3, [fp, #-36]
	cmp	r3, #0
	beq	.L241
	ldr	r2, [fp, #-52]
	ldr	r3, [fp, #-36]
	add	r3, r2, r3
	add	r3, r3, #1
	asr	r2, r3, #31
	mov	r6, r3
	mov	r7, r2
	ldr	r3, .L244+8
.LPIC254:
	add	r3, pc, r3
	ldrd	r2, [r3]
	adds	r1, r6, r2
	str	r1, [fp, #-60]
	adc	r3, r7, r3
	str	r3, [fp, #-56]
	ldr	r3, .L244+12
.LPIC255:
	add	r3, pc, r3
	ldrd	r0, [fp, #-60]
	strd	r0, [r3]
	ldr	r3, [fp, #-40]
	mov	r0, r3
	bl	free(PLT)
	b	.L238
.L241:
	ldr	r3, [fp, #-52]
	asr	r2, r3, #31
	mov	r4, r3
	mov	r5, r2
	ldr	r3, .L244+16
.LPIC256:
	add	r3, pc, r3
	ldrd	r2, [r3]
	adds	r8, r4, r2
	adc	r9, r5, r3
	ldr	r3, .L244+20
.LPIC257:
	add	r3, pc, r3
	strd	r8, [r3]
	nop
.L238:
	ldr	r2, .L244+24
.LPIC259:
	add	r2, pc, r2
	ldr	r3, .L244+4
	ldr	r3, [r2, r3]
	ldr	r2, [r3]
	ldr	r3, [fp, #-32]
	eors	r2, r3, r2
	mov	r3, #0
	beq	.L243
	bl	__stack_chk_fail(PLT)
.L243:
	sub	sp, fp, #28
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, fp, pc}
.L245:
	.align	2
.L244:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC258+8)
	.word	__stack_chk_guard(GOT)
	.word	current_instruction_index-(.LPIC254+8)
	.word	current_instruction_index-(.LPIC255+8)
	.word	current_instruction_index-(.LPIC256+8)
	.word	current_instruction_index-(.LPIC257+8)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC259+8)
	.size	ws_flow_jn, .-ws_flow_jn
	.align	2
	.global	ws_flow_ret
	.syntax unified
	.arm
	.type	ws_flow_ret, %function
ws_flow_ret:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	str	r0, [fp, #-8]
	str	r1, [fp, #-12]
	bl	get_last_ret_addr(PLT)
	mov	r2, r0
	mov	r3, r1
	ldr	r1, .L248
.LPIC260:
	add	r1, pc, r1
	strd	r2, [r1]
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L249:
	.align	2
.L248:
	.word	current_instruction_index-(.LPIC260+8)
	.size	ws_flow_ret, .-ws_flow_ret
	.align	2
	.global	ws_flow_exit
	.syntax unified
	.arm
	.type	ws_flow_exit, %function
ws_flow_exit:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	str	r0, [fp, #-8]
	str	r1, [fp, #-12]
	ldr	r3, .L252
.LPIC261:
	add	r3, pc, r3
	vmov.i32	d16, #0xffffffff  @ di
	vstr.64	d16, [r3]	@ int
	nop
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
.L253:
	.align	2
.L252:
	.word	current_instruction_index-(.LPIC261+8)
	.size	ws_flow_exit, .-ws_flow_exit
	.align	2
	.global	ws_io_outc
	.syntax unified
	.arm
	.type	ws_io_outc, %function
ws_io_outc:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, fp, lr}
	add	fp, sp, #20
	sub	sp, sp, #8
	str	r0, [fp, #-24]
	str	r1, [fp, #-28]
	bl	stack_pop(PLT)
	mov	r2, r0
	mov	r3, r1
	mov	r3, r2
	mov	r0, r3
	bl	putchar(PLT)
	ldr	r3, [fp, #-28]
	asr	r2, r3, #31
	mov	r4, r3
	mov	r5, r2
	ldr	r3, .L256
.LPIC262:
	add	r3, pc, r3
	ldrd	r2, [r3]
	adds	r6, r4, r2
	adc	r7, r5, r3
	ldr	r3, .L256+4
.LPIC263:
	add	r3, pc, r3
	strd	r6, [r3]
	nop
	sub	sp, fp, #20
	@ sp needed
	pop	{r4, r5, r6, r7, fp, pc}
.L257:
	.align	2
.L256:
	.word	current_instruction_index-(.LPIC262+8)
	.word	current_instruction_index-(.LPIC263+8)
	.size	ws_io_outc, .-ws_io_outc
	.section	.rodata
	.align	2
.LC26:
	.ascii	"%lld\000"
	.text
	.align	2
	.global	ws_io_outn
	.syntax unified
	.arm
	.type	ws_io_outn, %function
ws_io_outn:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, fp, lr}
	add	fp, sp, #24
	sub	sp, sp, #12
	str	r0, [fp, #-32]
	str	r1, [fp, #-36]
	ldr	r8, .L260
.LPIC265:
	add	r8, pc, r8
	bl	stack_pop(PLT)
	mov	r2, r0
	mov	r3, r1
	ldr	r1, .L260+4
.LPIC264:
	add	r1, pc, r1
	mov	r0, r1
	bl	printf(PLT)
	ldr	r3, .L260+8
	ldr	r3, [r8, r3]
	ldr	r3, [r3]
	mov	r0, r3
	bl	fflush(PLT)
	ldr	r3, [fp, #-36]
	asr	r2, r3, #31
	mov	r4, r3
	mov	r5, r2
	ldr	r3, .L260+12
.LPIC266:
	add	r3, pc, r3
	ldrd	r2, [r3]
	adds	r6, r4, r2
	adc	r7, r5, r3
	ldr	r3, .L260+16
.LPIC267:
	add	r3, pc, r3
	strd	r6, [r3]
	nop
	sub	sp, fp, #24
	@ sp needed
	pop	{r4, r5, r6, r7, r8, fp, pc}
.L261:
	.align	2
.L260:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC265+8)
	.word	.LC26-(.LPIC264+8)
	.word	stdout(GOT)
	.word	current_instruction_index-(.LPIC266+8)
	.word	current_instruction_index-(.LPIC267+8)
	.size	ws_io_outn, .-ws_io_outn
	.align	2
	.global	ws_io_inc
	.syntax unified
	.arm
	.type	ws_io_inc, %function
ws_io_inc:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, fp, lr}
	add	fp, sp, #28
	sub	sp, sp, #16
	str	r0, [fp, #-40]
	str	r1, [fp, #-44]
	bl	getchar(PLT)
	str	r0, [fp, #-32]
	ldr	r3, [fp, #-32]
	asr	r2, r3, #31
	mov	r8, r3
	mov	r9, r2
	bl	stack_pop(PLT)
	mov	r2, r0
	mov	r3, r1
	mov	r0, r8
	mov	r1, r9
	bl	heap_put(PLT)
	ldr	r3, [fp, #-44]
	asr	r2, r3, #31
	mov	r4, r3
	mov	r5, r2
	ldr	r3, .L264
.LPIC268:
	add	r3, pc, r3
	ldrd	r2, [r3]
	adds	r6, r4, r2
	adc	r7, r5, r3
	ldr	r3, .L264+4
.LPIC269:
	add	r3, pc, r3
	strd	r6, [r3]
	nop
	sub	sp, fp, #28
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, fp, pc}
.L265:
	.align	2
.L264:
	.word	current_instruction_index-(.LPIC268+8)
	.word	current_instruction_index-(.LPIC269+8)
	.size	ws_io_inc, .-ws_io_inc
	.section	.rodata
	.align	2
.LC27:
	.ascii	"%18s\000"
	.text
	.align	2
	.global	ws_io_inn
	.syntax unified
	.arm
	.type	ws_io_inn, %function
ws_io_inn:
	@ args = 0, pretend = 0, frame = 40
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, fp, lr}
	add	fp, sp, #28
	sub	sp, sp, #40
	str	r0, [fp, #-64]
	str	r1, [fp, #-68]
	ldr	r2, .L269
.LPIC273:
	add	r2, pc, r2
	ldr	r3, .L269+4
	ldr	r3, [r2, r3]
	ldr	r3, [r3]
	str	r3, [fp, #-32]
	mov	r3, #0
	sub	r3, fp, #52
	mov	r1, r3
	ldr	r3, .L269+8
.LPIC270:
	add	r3, pc, r3
	mov	r0, r3
	bl	__isoc99_scanf(PLT)
	sub	r1, fp, #56
	sub	r3, fp, #52
	mov	r2, #10
	mov	r0, r3
	bl	strtoll(PLT)
	mov	r8, r0
	mov	r9, r1
	bl	stack_pop(PLT)
	mov	r2, r0
	mov	r3, r1
	mov	r0, r8
	mov	r1, r9
	bl	heap_put(PLT)
	ldr	r3, [fp, #-68]
	asr	r2, r3, #31
	mov	r4, r3
	mov	r5, r2
	ldr	r3, .L269+12
.LPIC271:
	add	r3, pc, r3
	ldrd	r2, [r3]
	adds	r6, r4, r2
	adc	r7, r5, r3
	ldr	r3, .L269+16
.LPIC272:
	add	r3, pc, r3
	strd	r6, [r3]
	nop
	ldr	r2, .L269+20
.LPIC274:
	add	r2, pc, r2
	ldr	r3, .L269+4
	ldr	r3, [r2, r3]
	ldr	r2, [r3]
	ldr	r3, [fp, #-32]
	eors	r2, r3, r2
	mov	r3, #0
	beq	.L268
	bl	__stack_chk_fail(PLT)
.L268:
	sub	sp, fp, #28
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, fp, pc}
.L270:
	.align	2
.L269:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC273+8)
	.word	__stack_chk_guard(GOT)
	.word	.LC27-(.LPIC270+8)
	.word	current_instruction_index-(.LPIC271+8)
	.word	current_instruction_index-(.LPIC272+8)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC274+8)
	.size	ws_io_inn, .-ws_io_inn
	.global	__aeabi_ldivmod
	.ident	"GCC: (GNU) 14.1.1 20240507"
	.section	.note.GNU-stack,"",%progbits
