	.text
	.globl	stack
	.bss
	.align 4
	.type	stack, @object
	.size	stack, 12
stack:
	.zero	12
	.globl	heap
	.align 4
	.type	heap, @object
	.size	heap, 12
heap:
	.zero	12
	.globl	label_table
	.align 4
	.type	label_table, @object
	.size	label_table, 12
label_table:
	.zero	12
	.globl	instruction_set
	.align 4
	.type	instruction_set, @object
	.size	instruction_set, 12
instruction_set:
	.zero	12
	.globl	instruction_index
	.align 32
	.type	instruction_index, @object
	.size	instruction_index, 160
instruction_index:
	.zero	160
	.globl	current_instruction_index
	.align 8
	.type	current_instruction_index, @object
	.size	current_instruction_index, 8
current_instruction_index:
	.zero	8
	.section	.rodata
.LC0:
	.string	"usage: %s *.ws\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB6:
	.cfi_startproc
	leal	4(%esp), %ecx
	.cfi_def_cfa 1, 0
	andl	$-16, %esp
	pushl	-4(%ecx)
	pushl	%ebp
	movl	%esp, %ebp
	.cfi_escape 0x10,0x5,0x2,0x75,0
	pushl	%ebx
	pushl	%ecx
	.cfi_escape 0xf,0x3,0x75,0x78,0x6
	.cfi_escape 0x10,0x3,0x2,0x75,0x7c
	subl	$32, %esp
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	movl	%ecx, %eax
	movl	4(%eax), %edx
	movl	%edx, -28(%ebp)
	movl	%gs:20, %edx
	movl	%edx, -12(%ebp)
	xorl	%edx, %edx
	cmpl	$2, (%eax)
	jne	.L2
	movl	-28(%ebp), %eax
	addl	$4, %eax
	movl	(%eax), %eax
	subl	$8, %esp
	leal	-16(%ebp), %edx
	pushl	%edx
	pushl	%eax
	call	read_source_file
	addl	$16, %esp
	testl	%eax, %eax
	je	.L3
	movl	-16(%ebp), %eax
	subl	$12, %esp
	pushl	%eax
	call	remove_comments
	addl	$16, %esp
	call	create_stack
	testb	%al, %al
	je	.L3
	call	create_heap
	testb	%al, %al
	je	.L4
	call	create_label_table
	testb	%al, %al
	je	.L5
	call	create_instruction_set
	testb	%al, %al
	je	.L6
	movl	-16(%ebp), %eax
	subl	$12, %esp
	pushl	%eax
	call	locate_jump_labels
	addl	$16, %esp
	testb	%al, %al
	je	.L7
	movl	-16(%ebp), %eax
	subl	$12, %esp
	pushl	%eax
	call	step_through_program
	addl	$16, %esp
	movl	-16(%ebp), %eax
	subl	$12, %esp
	pushl	%eax
	call	free@PLT
	addl	$16, %esp
	call	cleanup_stack
	call	cleanup_heap
	call	cleanup_label_table
	call	cleanup_instruction_set
	movl	$0, %eax
	jmp	.L9
.L7:
	call	cleanup_instruction_set
.L6:
	call	cleanup_label_table
.L5:
	call	cleanup_heap
.L4:
	call	cleanup_stack
	jmp	.L3
.L2:
	movl	-28(%ebp), %eax
	movl	(%eax), %eax
	subl	$8, %esp
	pushl	%eax
	leal	.LC0@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printf@PLT
	addl	$16, %esp
.L3:
	movl	$1, %eax
.L9:
	movl	-12(%ebp), %edx
	subl	%gs:20, %edx
	je	.L10
	call	__stack_chk_fail_local
.L10:
	leal	-8(%ebp), %esp
	popl	%ecx
	.cfi_restore 1
	.cfi_def_cfa 1, 0
	popl	%ebx
	.cfi_restore 3
	popl	%ebp
	.cfi_restore 5
	leal	-4(%ecx), %esp
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE6:
	.size	main, .-main
	.section	.rodata
.LC1:
	.string	"r"
	.text
	.globl	read_source_file
	.type	read_source_file, @function
read_source_file:
.LFB7:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$20, %esp
	.cfi_offset 3, -12
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	subl	$8, %esp
	leal	.LC1@GOTOFF(%ebx), %eax
	pushl	%eax
	pushl	8(%ebp)
	call	fopen@PLT
	addl	$16, %esp
	movl	%eax, -16(%ebp)
	cmpl	$0, -16(%ebp)
	je	.L12
	subl	$4, %esp
	pushl	$2
	pushl	$0
	pushl	-16(%ebp)
	call	fseek@PLT
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L13
	subl	$12, %esp
	pushl	-16(%ebp)
	call	ftell@PLT
	addl	$16, %esp
	movl	%eax, -12(%ebp)
	cmpl	$-1, -12(%ebp)
	je	.L13
	subl	$12, %esp
	pushl	-16(%ebp)
	call	rewind@PLT
	addl	$16, %esp
	movl	-12(%ebp), %eax
	addl	$1, %eax
	subl	$8, %esp
	pushl	$1
	pushl	%eax
	call	calloc@PLT
	addl	$16, %esp
	movl	%eax, %edx
	movl	12(%ebp), %eax
	movl	%edx, (%eax)
	movl	12(%ebp), %eax
	movl	(%eax), %eax
	testl	%eax, %eax
	je	.L13
	movl	-12(%ebp), %eax
	addl	$1, %eax
	movl	%eax, %edx
	movl	12(%ebp), %eax
	movl	(%eax), %eax
	pushl	-16(%ebp)
	pushl	%edx
	pushl	$1
	pushl	%eax
	call	fread@PLT
	addl	$16, %esp
	testl	%eax, %eax
	je	.L14
	subl	$12, %esp
	pushl	-16(%ebp)
	call	fclose@PLT
	addl	$16, %esp
	movl	-12(%ebp), %eax
	jmp	.L15
.L14:
	movl	12(%ebp), %eax
	movl	(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	free@PLT
	addl	$16, %esp
.L13:
	subl	$12, %esp
	pushl	-16(%ebp)
	call	fclose@PLT
	addl	$16, %esp
.L12:
	movl	$0, %eax
.L15:
	movl	-4(%ebp), %ebx
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE7:
	.size	read_source_file, .-read_source_file
	.globl	remove_comments
	.type	remove_comments, @function
remove_comments:
.LFB8:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%esi
	pushl	%ebx
	subl	$16, %esp
	.cfi_offset 6, -12
	.cfi_offset 3, -16
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	movl	$0, -16(%ebp)
	movl	$0, -12(%ebp)
	jmp	.L17
.L19:
	movl	-12(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	cmpb	$9, %al
	je	.L18
	movl	-12(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	cmpb	$10, %al
	je	.L18
	movl	-12(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	cmpb	$32, %al
	je	.L18
	movl	-12(%ebp), %eax
	leal	1(%eax), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	subl	$12, %esp
	pushl	%eax
	call	strlen@PLT
	addl	$16, %esp
	movl	-12(%ebp), %edx
	leal	1(%edx), %ecx
	movl	8(%ebp), %edx
	addl	%edx, %ecx
	movl	-12(%ebp), %esi
	movl	8(%ebp), %edx
	addl	%esi, %edx
	subl	$4, %esp
	pushl	%eax
	pushl	%ecx
	pushl	%edx
	call	memmove@PLT
	addl	$16, %esp
	subl	$1, -12(%ebp)
	addl	$1, -16(%ebp)
.L18:
	addl	$1, -12(%ebp)
.L17:
	movl	-12(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	jne	.L19
	subl	$12, %esp
	pushl	8(%ebp)
	call	strlen@PLT
	addl	$16, %esp
	movl	%eax, %edx
	movl	-16(%ebp), %eax
	subl	%eax, %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movb	$0, (%eax)
	nop
	leal	-8(%ebp), %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE8:
	.size	remove_comments, .-remove_comments
	.globl	create_stack
	.type	create_stack, @function
create_stack:
.LFB9:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$4, %esp
	.cfi_offset 3, -12
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	subl	$8, %esp
	pushl	$8
	pushl	$2048
	call	calloc@PLT
	addl	$16, %esp
	movl	%eax, 8+stack@GOTOFF(%ebx)
	movl	8+stack@GOTOFF(%ebx), %eax
	testl	%eax, %eax
	je	.L22
	movl	$2048, stack@GOTOFF(%ebx)
	movl	$2048, 4+stack@GOTOFF(%ebx)
	movl	$1, %eax
	jmp	.L23
.L22:
	movl	$0, %eax
.L23:
	movl	-4(%ebp), %ebx
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE9:
	.size	create_stack, .-create_stack
	.globl	stack_push
	.type	stack_push, @function
stack_push:
.LFB10:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	call	__x86.get_pc_thunk.ax
	addl	$_GLOBAL_OFFSET_TABLE_, %eax
	movl	8(%ebp), %edx
	movl	%edx, -8(%ebp)
	movl	12(%ebp), %edx
	movl	%edx, -4(%ebp)
	movl	4+stack@GOTOFF(%eax), %edx
	testl	%edx, %edx
	jle	.L25
	movl	4+stack@GOTOFF(%eax), %edx
	subl	$1, %edx
	movl	%edx, 4+stack@GOTOFF(%eax)
	movl	8+stack@GOTOFF(%eax), %edx
	movl	4+stack@GOTOFF(%eax), %eax
	sall	$3, %eax
	leal	(%edx,%eax), %ecx
	movl	-8(%ebp), %eax
	movl	-4(%ebp), %edx
	movl	%eax, (%ecx)
	movl	%edx, 4(%ecx)
	movl	$1, %eax
	jmp	.L26
.L25:
	movl	$0, %eax
.L26:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE10:
	.size	stack_push, .-stack_push
	.globl	stack_pop
	.type	stack_pop, @function
stack_pop:
.LFB11:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	call	__x86.get_pc_thunk.ax
	addl	$_GLOBAL_OFFSET_TABLE_, %eax
	movl	4+stack@GOTOFF(%eax), %ecx
	movl	stack@GOTOFF(%eax), %edx
	cmpl	%edx, %ecx
	jge	.L28
	movl	4+stack@GOTOFF(%eax), %edx
	addl	$1, %edx
	movl	%edx, 4+stack@GOTOFF(%eax)
	movl	8+stack@GOTOFF(%eax), %edx
	movl	4+stack@GOTOFF(%eax), %eax
	addl	$536870911, %eax
	sall	$3, %eax
	addl	%edx, %eax
	movl	4(%eax), %edx
	movl	(%eax), %eax
	jmp	.L29
.L28:
	movl	$0, %eax
	movl	$0, %edx
.L29:
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE11:
	.size	stack_pop, .-stack_pop
	.globl	stack_peak
	.type	stack_peak, @function
stack_peak:
.LFB12:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	call	__x86.get_pc_thunk.ax
	addl	$_GLOBAL_OFFSET_TABLE_, %eax
	movl	4+stack@GOTOFF(%eax), %ecx
	movl	8(%ebp), %edx
	addl	%edx, %ecx
	movl	stack@GOTOFF(%eax), %edx
	cmpl	%edx, %ecx
	jge	.L31
	movl	8+stack@GOTOFF(%eax), %edx
	movl	4+stack@GOTOFF(%eax), %ecx
	movl	8(%ebp), %eax
	addl	%ecx, %eax
	sall	$3, %eax
	addl	%edx, %eax
	movl	4(%eax), %edx
	movl	(%eax), %eax
	jmp	.L32
.L31:
	movl	$0, %eax
	movl	$0, %edx
.L32:
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE12:
	.size	stack_peak, .-stack_peak
	.globl	cleanup_stack
	.type	cleanup_stack, @function
cleanup_stack:
.LFB13:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$4, %esp
	.cfi_offset 3, -12
	call	__x86.get_pc_thunk.ax
	addl	$_GLOBAL_OFFSET_TABLE_, %eax
	movl	8+stack@GOTOFF(%eax), %edx
	subl	$12, %esp
	pushl	%edx
	movl	%eax, %ebx
	call	free@PLT
	addl	$16, %esp
	nop
	movl	-4(%ebp), %ebx
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE13:
	.size	cleanup_stack, .-cleanup_stack
	.globl	create_heap
	.type	create_heap, @function
create_heap:
.LFB14:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$4, %esp
	.cfi_offset 3, -12
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	subl	$8, %esp
	pushl	$8
	pushl	$2048
	call	calloc@PLT
	addl	$16, %esp
	movl	%eax, heap@GOTOFF(%ebx)
	movl	heap@GOTOFF(%ebx), %eax
	testl	%eax, %eax
	je	.L36
	subl	$8, %esp
	pushl	$8
	pushl	$2048
	call	calloc@PLT
	addl	$16, %esp
	movl	%eax, 4+heap@GOTOFF(%ebx)
	movl	4+heap@GOTOFF(%ebx), %eax
	testl	%eax, %eax
	je	.L37
	movl	$0, 8+heap@GOTOFF(%ebx)
	movl	$1, %eax
	jmp	.L38
.L37:
	movl	heap@GOTOFF(%ebx), %eax
	subl	$12, %esp
	pushl	%eax
	call	free@PLT
	addl	$16, %esp
.L36:
	movl	$0, %eax
.L38:
	movl	-4(%ebp), %ebx
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE14:
	.size	create_heap, .-create_heap
	.globl	heap_put
	.type	heap_put, @function
heap_put:
.LFB15:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$36, %esp
	.cfi_offset 3, -12
	call	__x86.get_pc_thunk.ax
	addl	$_GLOBAL_OFFSET_TABLE_, %eax
	movl	8(%ebp), %edx
	movl	%edx, -32(%ebp)
	movl	12(%ebp), %edx
	movl	%edx, -28(%ebp)
	movl	16(%ebp), %edx
	movl	%edx, -40(%ebp)
	movl	20(%ebp), %edx
	movl	%edx, -36(%ebp)
	movl	$0, -16(%ebp)
	jmp	.L40
.L43:
	movl	heap@GOTOFF(%eax), %edx
	movl	-16(%ebp), %ecx
	sall	$3, %ecx
	addl	%ecx, %edx
	movl	(%edx), %ecx
	movl	4(%edx), %ebx
	movl	%ecx, %edx
	movl	%ebx, %ecx
	xorl	-40(%ebp), %edx
	xorl	-36(%ebp), %ecx
	orl	%ecx, %edx
	jne	.L41
	movl	4+heap@GOTOFF(%eax), %eax
	movl	-16(%ebp), %edx
	sall	$3, %edx
	leal	(%eax,%edx), %ecx
	movl	-32(%ebp), %eax
	movl	-28(%ebp), %edx
	movl	%eax, (%ecx)
	movl	%edx, 4(%ecx)
	movl	$1, %eax
	jmp	.L42
.L41:
	addl	$1, -16(%ebp)
.L40:
	movl	8+heap@GOTOFF(%eax), %edx
	cmpl	%edx, -16(%ebp)
	jl	.L43
	movl	8+heap@GOTOFF(%eax), %edx
	cmpl	$2047, %edx
	jg	.L44
	movl	8+heap@GOTOFF(%eax), %edx
	movl	%edx, -12(%ebp)
	movl	heap@GOTOFF(%eax), %edx
	movl	-12(%ebp), %ecx
	sall	$3, %ecx
	addl	%ecx, %edx
	movl	-40(%ebp), %ecx
	movl	-36(%ebp), %ebx
	movl	%ecx, (%edx)
	movl	%ebx, 4(%edx)
	movl	4+heap@GOTOFF(%eax), %edx
	movl	-12(%ebp), %ecx
	sall	$3, %ecx
	addl	%ecx, %edx
	movl	-32(%ebp), %ecx
	movl	-28(%ebp), %ebx
	movl	%ecx, (%edx)
	movl	%ebx, 4(%edx)
	movl	8+heap@GOTOFF(%eax), %edx
	addl	$1, %edx
	movl	%edx, 8+heap@GOTOFF(%eax)
	movl	$1, %eax
	jmp	.L42
.L44:
	movl	$0, %eax
.L42:
	movl	-4(%ebp), %ebx
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE15:
	.size	heap_put, .-heap_put
	.globl	heap_get
	.type	heap_get, @function
heap_get:
.LFB16:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$28, %esp
	.cfi_offset 3, -12
	call	__x86.get_pc_thunk.cx
	addl	$_GLOBAL_OFFSET_TABLE_, %ecx
	movl	8(%ebp), %eax
	movl	%eax, -32(%ebp)
	movl	12(%ebp), %eax
	movl	%eax, -28(%ebp)
	movl	$0, -12(%ebp)
	jmp	.L46
.L49:
	movl	heap@GOTOFF(%ecx), %eax
	movl	-12(%ebp), %edx
	sall	$3, %edx
	addl	%edx, %eax
	movl	4(%eax), %edx
	movl	(%eax), %eax
	movl	%eax, %ebx
	movl	%ebx, %eax
	xorl	-32(%ebp), %eax
	xorl	-28(%ebp), %edx
	orl	%edx, %eax
	jne	.L47
	movl	4+heap@GOTOFF(%ecx), %eax
	movl	-12(%ebp), %edx
	sall	$3, %edx
	addl	%edx, %eax
	movl	4(%eax), %edx
	movl	(%eax), %eax
	jmp	.L48
.L47:
	addl	$1, -12(%ebp)
.L46:
	cmpl	$2047, -12(%ebp)
	jle	.L49
	movl	$0, %eax
	movl	$0, %edx
.L48:
	movl	-4(%ebp), %ebx
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE16:
	.size	heap_get, .-heap_get
	.globl	cleanup_heap
	.type	cleanup_heap, @function
cleanup_heap:
.LFB17:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$4, %esp
	.cfi_offset 3, -12
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	movl	heap@GOTOFF(%ebx), %eax
	subl	$12, %esp
	pushl	%eax
	call	free@PLT
	addl	$16, %esp
	movl	4+heap@GOTOFF(%ebx), %eax
	subl	$12, %esp
	pushl	%eax
	call	free@PLT
	addl	$16, %esp
	nop
	movl	-4(%ebp), %ebx
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE17:
	.size	cleanup_heap, .-cleanup_heap
	.globl	create_label_table
	.type	create_label_table, @function
create_label_table:
.LFB18:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$4, %esp
	.cfi_offset 3, -12
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	subl	$8, %esp
	pushl	$4
	pushl	$200
	call	calloc@PLT
	addl	$16, %esp
	movl	%eax, label_table@GOTOFF(%ebx)
	movl	label_table@GOTOFF(%ebx), %eax
	testl	%eax, %eax
	je	.L53
	subl	$8, %esp
	pushl	$4
	pushl	$200
	call	calloc@PLT
	addl	$16, %esp
	movl	%eax, 4+label_table@GOTOFF(%ebx)
	movl	4+label_table@GOTOFF(%ebx), %eax
	testl	%eax, %eax
	je	.L54
	movl	$1, %eax
	jmp	.L55
.L54:
	movl	label_table@GOTOFF(%ebx), %eax
	subl	$12, %esp
	pushl	%eax
	call	free@PLT
	addl	$16, %esp
.L53:
	movl	$0, %eax
.L55:
	movl	-4(%ebp), %ebx
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE18:
	.size	create_label_table, .-create_label_table
	.globl	cleanup_label_table
	.type	cleanup_label_table, @function
cleanup_label_table:
.LFB19:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$20, %esp
	.cfi_offset 3, -12
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	movl	$0, -12(%ebp)
	jmp	.L57
.L59:
	movl	label_table@GOTOFF(%ebx), %eax
	movl	-12(%ebp), %edx
	sall	$2, %edx
	addl	%edx, %eax
	movl	(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	free@PLT
	addl	$16, %esp
	addl	$1, -12(%ebp)
.L57:
	cmpl	$199, -12(%ebp)
	jg	.L58
	movl	4+label_table@GOTOFF(%ebx), %eax
	movl	-12(%ebp), %edx
	sall	$2, %edx
	addl	%edx, %eax
	movl	(%eax), %eax
	testl	%eax, %eax
	jne	.L59
.L58:
	movl	label_table@GOTOFF(%ebx), %eax
	subl	$12, %esp
	pushl	%eax
	call	free@PLT
	addl	$16, %esp
	movl	4+label_table@GOTOFF(%ebx), %eax
	subl	$12, %esp
	pushl	%eax
	call	free@PLT
	addl	$16, %esp
	nop
	movl	-4(%ebp), %ebx
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE19:
	.size	cleanup_label_table, .-cleanup_label_table
	.section	.rodata
.LC2:
	.string	"  "
.LC3:
	.string	" \n "
.LC4:
	.string	" \t "
.LC5:
	.string	" \n\t"
.LC6:
	.string	" \n\n"
.LC7:
	.string	" \t\n"
.LC8:
	.string	"\t   "
.LC9:
	.string	"\t  \t"
.LC10:
	.string	"\t  \n"
.LC11:
	.string	"\t \t "
.LC12:
	.string	"\t \t\t"
.LC13:
	.string	"\t\t "
.LC14:
	.string	"\t\t\t"
.LC15:
	.string	"\n  "
.LC16:
	.string	"\n \t"
.LC17:
	.string	"\n \n"
.LC18:
	.string	"\n\t "
.LC19:
	.string	"\n\t\t"
.LC20:
	.string	"\n\t\n"
.LC21:
	.string	"\n\n\n"
.LC22:
	.string	"\t\n  "
.LC23:
	.string	"\t\n \t"
.LC24:
	.string	"\t\n\t "
.LC25:
	.string	"\t\n\t\t"
	.text
	.globl	create_instruction_set
	.type	create_instruction_set, @function
create_instruction_set:
.LFB20:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$4, %esp
	.cfi_offset 3, -12
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	subl	$8, %esp
	pushl	$4
	pushl	$24
	call	calloc@PLT
	addl	$16, %esp
	movl	%eax, instruction_set@GOTOFF(%ebx)
	subl	$8, %esp
	pushl	$4
	pushl	$24
	call	calloc@PLT
	addl	$16, %esp
	movl	%eax, 8+instruction_set@GOTOFF(%ebx)
	subl	$8, %esp
	pushl	$4
	pushl	$24
	call	calloc@PLT
	addl	$16, %esp
	movl	%eax, 4+instruction_set@GOTOFF(%ebx)
	movl	instruction_set@GOTOFF(%ebx), %eax
	leal	.LC2@GOTOFF(%ebx), %edx
	movl	%edx, (%eax)
	movl	4+instruction_set@GOTOFF(%ebx), %eax
	leal	ws_stack_push@GOTOFF(%ebx), %edx
	movl	%edx, (%eax)
	movl	8+instruction_set@GOTOFF(%ebx), %eax
	movl	$2, (%eax)
	movl	instruction_set@GOTOFF(%ebx), %eax
	leal	4(%eax), %edx
	leal	.LC3@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	4+instruction_set@GOTOFF(%ebx), %eax
	leal	4(%eax), %edx
	leal	ws_stack_dup@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	8+instruction_set@GOTOFF(%ebx), %eax
	addl	$4, %eax
	movl	$3, (%eax)
	movl	instruction_set@GOTOFF(%ebx), %eax
	leal	8(%eax), %edx
	leal	.LC4@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	4+instruction_set@GOTOFF(%ebx), %eax
	leal	8(%eax), %edx
	leal	ws_stack_copy@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	8+instruction_set@GOTOFF(%ebx), %eax
	addl	$8, %eax
	movl	$3, (%eax)
	movl	instruction_set@GOTOFF(%ebx), %eax
	leal	12(%eax), %edx
	leal	.LC5@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	4+instruction_set@GOTOFF(%ebx), %eax
	leal	12(%eax), %edx
	leal	ws_stack_swap@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	8+instruction_set@GOTOFF(%ebx), %eax
	addl	$12, %eax
	movl	$3, (%eax)
	movl	instruction_set@GOTOFF(%ebx), %eax
	leal	16(%eax), %edx
	leal	.LC6@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	4+instruction_set@GOTOFF(%ebx), %eax
	leal	16(%eax), %edx
	leal	ws_stack_discard@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	8+instruction_set@GOTOFF(%ebx), %eax
	addl	$16, %eax
	movl	$3, (%eax)
	movl	instruction_set@GOTOFF(%ebx), %eax
	leal	20(%eax), %edx
	leal	.LC7@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	4+instruction_set@GOTOFF(%ebx), %eax
	leal	20(%eax), %edx
	leal	ws_stack_slide@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	8+instruction_set@GOTOFF(%ebx), %eax
	addl	$20, %eax
	movl	$3, (%eax)
	movl	instruction_set@GOTOFF(%ebx), %eax
	leal	24(%eax), %edx
	leal	.LC8@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	4+instruction_set@GOTOFF(%ebx), %eax
	leal	24(%eax), %edx
	leal	ws_math_add@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	8+instruction_set@GOTOFF(%ebx), %eax
	addl	$24, %eax
	movl	$4, (%eax)
	movl	instruction_set@GOTOFF(%ebx), %eax
	leal	28(%eax), %edx
	leal	.LC9@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	4+instruction_set@GOTOFF(%ebx), %eax
	leal	28(%eax), %edx
	leal	ws_math_sub@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	8+instruction_set@GOTOFF(%ebx), %eax
	addl	$28, %eax
	movl	$4, (%eax)
	movl	instruction_set@GOTOFF(%ebx), %eax
	leal	32(%eax), %edx
	leal	.LC10@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	4+instruction_set@GOTOFF(%ebx), %eax
	leal	32(%eax), %edx
	leal	ws_math_mult@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	8+instruction_set@GOTOFF(%ebx), %eax
	addl	$32, %eax
	movl	$4, (%eax)
	movl	instruction_set@GOTOFF(%ebx), %eax
	leal	36(%eax), %edx
	leal	.LC11@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	4+instruction_set@GOTOFF(%ebx), %eax
	leal	36(%eax), %edx
	leal	ws_math_div@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	8+instruction_set@GOTOFF(%ebx), %eax
	addl	$36, %eax
	movl	$4, (%eax)
	movl	instruction_set@GOTOFF(%ebx), %eax
	leal	40(%eax), %edx
	leal	.LC12@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	4+instruction_set@GOTOFF(%ebx), %eax
	leal	40(%eax), %edx
	leal	ws_math_mod@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	8+instruction_set@GOTOFF(%ebx), %eax
	addl	$40, %eax
	movl	$4, (%eax)
	movl	instruction_set@GOTOFF(%ebx), %eax
	leal	44(%eax), %edx
	leal	.LC13@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	4+instruction_set@GOTOFF(%ebx), %eax
	leal	44(%eax), %edx
	leal	ws_heap_store@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	8+instruction_set@GOTOFF(%ebx), %eax
	addl	$44, %eax
	movl	$3, (%eax)
	movl	instruction_set@GOTOFF(%ebx), %eax
	leal	48(%eax), %edx
	leal	.LC14@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	4+instruction_set@GOTOFF(%ebx), %eax
	leal	48(%eax), %edx
	leal	ws_heap_retrieve@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	8+instruction_set@GOTOFF(%ebx), %eax
	addl	$48, %eax
	movl	$3, (%eax)
	movl	instruction_set@GOTOFF(%ebx), %eax
	leal	52(%eax), %edx
	leal	.LC15@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	4+instruction_set@GOTOFF(%ebx), %eax
	leal	52(%eax), %edx
	leal	ws_flow_mark@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	8+instruction_set@GOTOFF(%ebx), %eax
	addl	$52, %eax
	movl	$3, (%eax)
	movl	instruction_set@GOTOFF(%ebx), %eax
	leal	56(%eax), %edx
	leal	.LC16@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	4+instruction_set@GOTOFF(%ebx), %eax
	leal	56(%eax), %edx
	leal	ws_flow_call@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	8+instruction_set@GOTOFF(%ebx), %eax
	addl	$56, %eax
	movl	$3, (%eax)
	movl	instruction_set@GOTOFF(%ebx), %eax
	leal	60(%eax), %edx
	leal	.LC17@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	4+instruction_set@GOTOFF(%ebx), %eax
	leal	60(%eax), %edx
	leal	ws_flow_jump@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	8+instruction_set@GOTOFF(%ebx), %eax
	addl	$60, %eax
	movl	$3, (%eax)
	movl	instruction_set@GOTOFF(%ebx), %eax
	leal	64(%eax), %edx
	leal	.LC18@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	4+instruction_set@GOTOFF(%ebx), %eax
	leal	64(%eax), %edx
	leal	ws_flow_jz@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	8+instruction_set@GOTOFF(%ebx), %eax
	addl	$64, %eax
	movl	$3, (%eax)
	movl	instruction_set@GOTOFF(%ebx), %eax
	leal	68(%eax), %edx
	leal	.LC19@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	4+instruction_set@GOTOFF(%ebx), %eax
	leal	68(%eax), %edx
	leal	ws_flow_jn@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	8+instruction_set@GOTOFF(%ebx), %eax
	addl	$68, %eax
	movl	$3, (%eax)
	movl	instruction_set@GOTOFF(%ebx), %eax
	leal	72(%eax), %edx
	leal	.LC20@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	4+instruction_set@GOTOFF(%ebx), %eax
	leal	72(%eax), %edx
	leal	ws_flow_ret@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	8+instruction_set@GOTOFF(%ebx), %eax
	addl	$72, %eax
	movl	$3, (%eax)
	movl	instruction_set@GOTOFF(%ebx), %eax
	leal	76(%eax), %edx
	leal	.LC21@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	4+instruction_set@GOTOFF(%ebx), %eax
	leal	76(%eax), %edx
	leal	ws_flow_exit@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	8+instruction_set@GOTOFF(%ebx), %eax
	addl	$76, %eax
	movl	$3, (%eax)
	movl	instruction_set@GOTOFF(%ebx), %eax
	leal	80(%eax), %edx
	leal	.LC22@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	4+instruction_set@GOTOFF(%ebx), %eax
	leal	80(%eax), %edx
	leal	ws_io_outc@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	8+instruction_set@GOTOFF(%ebx), %eax
	addl	$80, %eax
	movl	$4, (%eax)
	movl	instruction_set@GOTOFF(%ebx), %eax
	leal	84(%eax), %edx
	leal	.LC23@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	4+instruction_set@GOTOFF(%ebx), %eax
	leal	84(%eax), %edx
	leal	ws_io_outn@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	8+instruction_set@GOTOFF(%ebx), %eax
	addl	$84, %eax
	movl	$4, (%eax)
	movl	instruction_set@GOTOFF(%ebx), %eax
	leal	88(%eax), %edx
	leal	.LC24@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	4+instruction_set@GOTOFF(%ebx), %eax
	leal	88(%eax), %edx
	leal	ws_io_inc@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	8+instruction_set@GOTOFF(%ebx), %eax
	addl	$88, %eax
	movl	$4, (%eax)
	movl	instruction_set@GOTOFF(%ebx), %eax
	leal	92(%eax), %edx
	leal	.LC25@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	4+instruction_set@GOTOFF(%ebx), %eax
	leal	92(%eax), %edx
	leal	ws_io_inn@GOTOFF(%ebx), %eax
	movl	%eax, (%edx)
	movl	8+instruction_set@GOTOFF(%ebx), %eax
	addl	$92, %eax
	movl	$4, (%eax)
	movl	$1, %eax
	movl	-4(%ebp), %ebx
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE20:
	.size	create_instruction_set, .-create_instruction_set
	.globl	cleanup_instruction_set
	.type	cleanup_instruction_set, @function
cleanup_instruction_set:
.LFB21:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$4, %esp
	.cfi_offset 3, -12
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	movl	4+instruction_set@GOTOFF(%ebx), %eax
	subl	$12, %esp
	pushl	%eax
	call	free@PLT
	addl	$16, %esp
	movl	instruction_set@GOTOFF(%ebx), %eax
	subl	$12, %esp
	pushl	%eax
	call	free@PLT
	addl	$16, %esp
	movl	8+instruction_set@GOTOFF(%ebx), %eax
	subl	$12, %esp
	pushl	%eax
	call	free@PLT
	addl	$16, %esp
	nop
	movl	-4(%ebp), %ebx
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE21:
	.size	cleanup_instruction_set, .-cleanup_instruction_set
	.globl	locate_jump_labels
	.type	locate_jump_labels, @function
locate_jump_labels:
.LFB22:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%esi
	pushl	%ebx
	subl	$16, %esp
	.cfi_offset 6, -12
	.cfi_offset 3, -16
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	movl	$0, -24(%ebp)
	leal	.LC15@GOTOFF(%ebx), %eax
	movl	%eax, -12(%ebp)
	movl	$0, -16(%ebp)
	jmp	.L66
.L72:
	movl	-16(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	subl	$4, %esp
	pushl	$3
	pushl	-12(%ebp)
	pushl	%eax
	call	strncmp@PLT
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L67
	movl	-16(%ebp), %eax
	leal	-1(%eax), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	cmpb	$9, %al
	je	.L67
	movl	label_table@GOTOFF(%ebx), %eax
	movl	-24(%ebp), %edx
	sall	$2, %edx
	leal	(%eax,%edx), %esi
	subl	$8, %esp
	pushl	$1
	pushl	$500
	call	calloc@PLT
	addl	$16, %esp
	movl	%eax, (%esi)
	movl	(%esi), %eax
	testl	%eax, %eax
	je	.L68
	addl	$3, -16(%ebp)
	movl	$0, -20(%ebp)
	jmp	.L69
.L70:
	movl	-16(%ebp), %edx
	movl	-20(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movl	label_table@GOTOFF(%ebx), %edx
	movl	-24(%ebp), %ecx
	sall	$2, %ecx
	addl	%ecx, %edx
	movl	(%edx), %ecx
	movl	-20(%ebp), %edx
	addl	%ecx, %edx
	movzbl	(%eax), %eax
	movb	%al, (%edx)
	addl	$1, -20(%ebp)
.L69:
	movl	-16(%ebp), %edx
	movl	-20(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	cmpb	$10, %al
	jne	.L70
	movl	-20(%ebp), %eax
	addl	%eax, -16(%ebp)
	movl	4+label_table@GOTOFF(%ebx), %eax
	movl	-24(%ebp), %edx
	sall	$2, %edx
	addl	%edx, %eax
	movl	-16(%ebp), %edx
	addl	$1, %edx
	movl	%edx, (%eax)
	addl	$1, -24(%ebp)
	jmp	.L67
.L68:
	movl	$0, %eax
	jmp	.L71
.L67:
	addl	$1, -16(%ebp)
.L66:
	movl	-16(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	jne	.L72
	movl	-24(%ebp), %eax
	movl	%eax, 8+label_table@GOTOFF(%ebx)
	movl	$1, %eax
.L71:
	leal	-8(%ebp), %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE22:
	.size	locate_jump_labels, .-locate_jump_labels
	.globl	add_ret_addr
	.type	add_ret_addr, @function
add_ret_addr:
.LFB23:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$28, %esp
	.cfi_offset 3, -12
	call	__x86.get_pc_thunk.cx
	addl	$_GLOBAL_OFFSET_TABLE_, %ecx
	movl	8(%ebp), %eax
	movl	%eax, -32(%ebp)
	movl	12(%ebp), %eax
	movl	%eax, -28(%ebp)
	movl	$0, -12(%ebp)
	jmp	.L74
.L76:
	addl	$1, -12(%ebp)
.L74:
	cmpl	$19, -12(%ebp)
	jg	.L75
	movl	-12(%ebp), %eax
	movl	4+instruction_index@GOTOFF(%ecx,%eax,8), %edx
	movl	instruction_index@GOTOFF(%ecx,%eax,8), %eax
	movl	%eax, %ebx
	movl	%ebx, %eax
	orl	%edx, %eax
	jne	.L76
.L75:
	cmpl	$19, -12(%ebp)
	jg	.L77
	movl	-12(%ebp), %ebx
	movl	-32(%ebp), %eax
	movl	-28(%ebp), %edx
	movl	%eax, instruction_index@GOTOFF(%ecx,%ebx,8)
	movl	%edx, 4+instruction_index@GOTOFF(%ecx,%ebx,8)
	movl	$1, %eax
	jmp	.L78
.L77:
	movl	$0, %eax
.L78:
	movl	-4(%ebp), %ebx
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE23:
	.size	add_ret_addr, .-add_ret_addr
	.globl	get_last_ret_addr
	.type	get_last_ret_addr, @function
get_last_ret_addr:
.LFB24:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$20, %esp
	.cfi_offset 3, -12
	call	__x86.get_pc_thunk.cx
	addl	$_GLOBAL_OFFSET_TABLE_, %ecx
	movl	$19, -20(%ebp)
	jmp	.L80
.L82:
	subl	$1, -20(%ebp)
.L80:
	movl	-20(%ebp), %eax
	movl	4+instruction_index@GOTOFF(%ecx,%eax,8), %edx
	movl	instruction_index@GOTOFF(%ecx,%eax,8), %eax
	movl	%eax, %ebx
	movl	%ebx, %eax
	orl	%edx, %eax
	jne	.L81
	cmpl	$0, -20(%ebp)
	jne	.L82
.L81:
	movl	-20(%ebp), %eax
	movl	4+instruction_index@GOTOFF(%ecx,%eax,8), %edx
	movl	instruction_index@GOTOFF(%ecx,%eax,8), %eax
	movl	%eax, -16(%ebp)
	movl	%edx, -12(%ebp)
	movl	-20(%ebp), %eax
	movl	$0, instruction_index@GOTOFF(%ecx,%eax,8)
	movl	$0, 4+instruction_index@GOTOFF(%ecx,%eax,8)
	movl	-16(%ebp), %eax
	movl	-12(%ebp), %edx
	movl	-4(%ebp), %ebx
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE24:
	.size	get_last_ret_addr, .-get_last_ret_addr
	.globl	step_through_program
	.type	step_through_program, @function
step_through_program:
.LFB25:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%esi
	pushl	%ebx
	subl	$16, %esp
	.cfi_offset 6, -12
	.cfi_offset 3, -16
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	jmp	.L85
.L91:
	movl	$0, -12(%ebp)
	jmp	.L86
.L89:
	movl	8+instruction_set@GOTOFF(%ebx), %eax
	movl	-12(%ebp), %edx
	sall	$2, %edx
	addl	%edx, %eax
	movl	(%eax), %eax
	movl	%eax, %esi
	movl	instruction_set@GOTOFF(%ebx), %eax
	movl	-12(%ebp), %edx
	sall	$2, %edx
	addl	%edx, %eax
	movl	(%eax), %ecx
	movl	current_instruction_index@GOTOFF(%ebx), %eax
	movl	4+current_instruction_index@GOTOFF(%ebx), %edx
	movl	%eax, %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	subl	$4, %esp
	pushl	%esi
	pushl	%ecx
	pushl	%eax
	call	strncmp@PLT
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L87
	movl	4+instruction_set@GOTOFF(%ebx), %eax
	movl	-12(%ebp), %edx
	sall	$2, %edx
	addl	%edx, %eax
	movl	(%eax), %ecx
	movl	8+instruction_set@GOTOFF(%ebx), %eax
	movl	-12(%ebp), %edx
	sall	$2, %edx
	addl	%edx, %eax
	movl	(%eax), %esi
	movl	current_instruction_index@GOTOFF(%ebx), %eax
	movl	4+current_instruction_index@GOTOFF(%ebx), %edx
	movl	%eax, %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	subl	$8, %esp
	pushl	%esi
	pushl	%eax
	call	*%ecx
	addl	$16, %esp
	jmp	.L88
.L87:
	addl	$1, -12(%ebp)
.L86:
	cmpl	$23, -12(%ebp)
	jle	.L89
.L88:
	cmpl	$24, -12(%ebp)
	jne	.L85
	movl	current_instruction_index@GOTOFF(%ebx), %eax
	movl	4+current_instruction_index@GOTOFF(%ebx), %edx
	addl	$1, %eax
	adcl	$0, %edx
	movl	%eax, current_instruction_index@GOTOFF(%ebx)
	movl	%edx, 4+current_instruction_index@GOTOFF(%ebx)
	call	getchar@PLT
.L85:
	movl	current_instruction_index@GOTOFF(%ebx), %eax
	movl	4+current_instruction_index@GOTOFF(%ebx), %edx
	movl	%eax, %ecx
	movl	%edx, %eax
	andl	%ecx, %eax
	cmpl	$-1, %eax
	je	.L93
	movl	current_instruction_index@GOTOFF(%ebx), %eax
	movl	4+current_instruction_index@GOTOFF(%ebx), %edx
	movl	%eax, %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	jne	.L91
	nop
.L93:
	nop
	leal	-8(%ebp), %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE25:
	.size	step_through_program, .-step_through_program
	.globl	convert_ws_to_number
	.type	convert_ws_to_number, @function
convert_ws_to_number:
.LFB26:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$20, %esp
	.cfi_offset 3, -12
	call	__x86.get_pc_thunk.ax
	addl	$_GLOBAL_OFFSET_TABLE_, %eax
	movl	$0, -16(%ebp)
	movl	$0, -12(%ebp)
	cmpl	$0, 8(%ebp)
	je	.L95
	subl	$12, %esp
	pushl	8(%ebp)
	movl	%eax, %ebx
	call	strlen@PLT
	addl	$16, %esp
	subl	$1, %eax
	movl	%eax, -24(%ebp)
	movl	$0, -20(%ebp)
	jmp	.L96
.L98:
	movl	-24(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	cmpb	$9, %al
	jne	.L97
	movl	-20(%ebp), %eax
	movl	$1, %edx
	movl	%eax, %ecx
	sall	%cl, %edx
	movl	%edx, %eax
	cltd
	addl	%eax, -16(%ebp)
	adcl	%edx, -12(%ebp)
.L97:
	subl	$1, -24(%ebp)
	addl	$1, -20(%ebp)
.L96:
	cmpl	$0, -24(%ebp)
	jg	.L98
	movl	8(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	$9, %al
	jne	.L95
	negl	-16(%ebp)
	adcl	$0, -12(%ebp)
	negl	-12(%ebp)
.L95:
	movl	-16(%ebp), %eax
	movl	-12(%ebp), %edx
	movl	-4(%ebp), %ebx
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE26:
	.size	convert_ws_to_number, .-convert_ws_to_number
	.globl	retrieve_label_or_number
	.type	retrieve_label_or_number, @function
retrieve_label_or_number:
.LFB27:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$20, %esp
	.cfi_offset 3, -12
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	subl	$8, %esp
	pushl	$1
	pushl	$501
	call	calloc@PLT
	addl	$16, %esp
	movl	%eax, %edx
	movl	12(%ebp), %eax
	movl	%edx, (%eax)
	movl	12(%ebp), %eax
	movl	(%eax), %eax
	testl	%eax, %eax
	je	.L101
	movl	12(%ebp), %eax
	movl	(%eax), %eax
	subl	$4, %esp
	pushl	$500
	pushl	8(%ebp)
	pushl	%eax
	call	strncpy@PLT
	addl	$16, %esp
	movl	12(%ebp), %eax
	movl	(%eax), %eax
	subl	$8, %esp
	pushl	$10
	pushl	%eax
	call	strchr@PLT
	addl	$16, %esp
	movl	%eax, -12(%ebp)
	cmpl	$0, -12(%ebp)
	je	.L102
	movl	-12(%ebp), %eax
	movb	$0, (%eax)
	movl	12(%ebp), %eax
	movl	(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	strlen@PLT
	addl	$16, %esp
	jmp	.L103
.L102:
	movl	12(%ebp), %eax
	movl	(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	free@PLT
	addl	$16, %esp
.L101:
	movl	$0, %eax
.L103:
	movl	-4(%ebp), %ebx
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE27:
	.size	retrieve_label_or_number, .-retrieve_label_or_number
	.globl	ws_stack_push
	.type	ws_stack_push, @function
ws_stack_push:
.LFB28:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$44, %esp
	.cfi_offset 7, -12
	.cfi_offset 6, -16
	.cfi_offset 3, -20
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	movl	8(%ebp), %eax
	movl	%eax, -44(%ebp)
	movl	%gs:20, %eax
	movl	%eax, -28(%ebp)
	xorl	%eax, %eax
	movl	$0, -36(%ebp)
	movl	$0, -32(%ebp)
	movl	12(%ebp), %edx
	movl	-44(%ebp), %eax
	addl	%eax, %edx
	subl	$8, %esp
	leal	-36(%ebp), %eax
	pushl	%eax
	pushl	%edx
	call	retrieve_label_or_number
	addl	$16, %esp
	movl	%eax, -32(%ebp)
	cmpl	$0, -32(%ebp)
	je	.L108
	movl	-36(%ebp), %eax
	subl	$12, %esp
	pushl	%eax
	call	convert_ws_to_number
	addl	$16, %esp
	subl	$8, %esp
	pushl	%edx
	pushl	%eax
	call	stack_push
	addl	$16, %esp
	movl	12(%ebp), %edx
	movl	-32(%ebp), %eax
	addl	%edx, %eax
	addl	$1, %eax
	movl	%eax, %esi
	movl	%eax, %edi
	sarl	$31, %edi
	movl	current_instruction_index@GOTOFF(%ebx), %eax
	movl	4+current_instruction_index@GOTOFF(%ebx), %edx
	addl	%esi, %eax
	adcl	%edi, %edx
	movl	%eax, current_instruction_index@GOTOFF(%ebx)
	movl	%edx, 4+current_instruction_index@GOTOFF(%ebx)
	movl	-36(%ebp), %eax
	subl	$12, %esp
	pushl	%eax
	call	free@PLT
	addl	$16, %esp
	nop
.L108:
	nop
	movl	-28(%ebp), %eax
	subl	%gs:20, %eax
	je	.L107
	call	__stack_chk_fail_local
.L107:
	leal	-12(%ebp), %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%edi
	.cfi_restore 7
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE28:
	.size	ws_stack_push, .-ws_stack_push
	.globl	ws_stack_dup
	.type	ws_stack_dup, @function
ws_stack_dup:
.LFB29:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%esi
	pushl	%ebx
	.cfi_offset 6, -12
	.cfi_offset 3, -16
	call	__x86.get_pc_thunk.si
	addl	$_GLOBAL_OFFSET_TABLE_, %esi
	subl	$4, %esp
	pushl	$0
	call	stack_peak
	addl	$8, %esp
	pushl	%edx
	pushl	%eax
	call	stack_push
	addl	$8, %esp
	movl	12(%ebp), %eax
	movl	%eax, %ecx
	movl	%eax, %ebx
	sarl	$31, %ebx
	movl	current_instruction_index@GOTOFF(%esi), %eax
	movl	4+current_instruction_index@GOTOFF(%esi), %edx
	addl	%ecx, %eax
	adcl	%ebx, %edx
	movl	%eax, current_instruction_index@GOTOFF(%esi)
	movl	%edx, 4+current_instruction_index@GOTOFF(%esi)
	nop
	leal	-8(%ebp), %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE29:
	.size	ws_stack_dup, .-ws_stack_dup
	.globl	ws_stack_copy
	.type	ws_stack_copy, @function
ws_stack_copy:
.LFB30:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$44, %esp
	.cfi_offset 7, -12
	.cfi_offset 6, -16
	.cfi_offset 3, -20
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	movl	8(%ebp), %eax
	movl	%eax, -44(%ebp)
	movl	%gs:20, %eax
	movl	%eax, -28(%ebp)
	xorl	%eax, %eax
	movl	$0, -36(%ebp)
	movl	$0, -32(%ebp)
	movl	12(%ebp), %edx
	movl	-44(%ebp), %eax
	addl	%eax, %edx
	subl	$8, %esp
	leal	-36(%ebp), %eax
	pushl	%eax
	pushl	%edx
	call	retrieve_label_or_number
	addl	$16, %esp
	movl	%eax, -32(%ebp)
	cmpl	$0, -32(%ebp)
	je	.L112
	movl	-36(%ebp), %eax
	subl	$12, %esp
	pushl	%eax
	call	convert_ws_to_number
	addl	$16, %esp
	subl	$12, %esp
	pushl	%eax
	call	stack_peak
	addl	$16, %esp
	subl	$8, %esp
	pushl	%edx
	pushl	%eax
	call	stack_push
	addl	$16, %esp
	movl	12(%ebp), %edx
	movl	-32(%ebp), %eax
	addl	%edx, %eax
	addl	$1, %eax
	movl	%eax, %esi
	movl	%eax, %edi
	sarl	$31, %edi
	movl	current_instruction_index@GOTOFF(%ebx), %eax
	movl	4+current_instruction_index@GOTOFF(%ebx), %edx
	addl	%esi, %eax
	adcl	%edi, %edx
	movl	%eax, current_instruction_index@GOTOFF(%ebx)
	movl	%edx, 4+current_instruction_index@GOTOFF(%ebx)
	movl	-36(%ebp), %eax
	subl	$12, %esp
	pushl	%eax
	call	free@PLT
	addl	$16, %esp
	jmp	.L111
.L112:
	movl	12(%ebp), %eax
	movl	%eax, %esi
	movl	%eax, %edi
	sarl	$31, %edi
	movl	current_instruction_index@GOTOFF(%ebx), %eax
	movl	4+current_instruction_index@GOTOFF(%ebx), %edx
	addl	%esi, %eax
	adcl	%edi, %edx
	movl	%eax, current_instruction_index@GOTOFF(%ebx)
	movl	%edx, 4+current_instruction_index@GOTOFF(%ebx)
	nop
.L111:
	movl	-28(%ebp), %eax
	subl	%gs:20, %eax
	je	.L115
	call	__stack_chk_fail_local
.L115:
	leal	-12(%ebp), %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%edi
	.cfi_restore 7
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE30:
	.size	ws_stack_copy, .-ws_stack_copy
	.globl	ws_stack_swap
	.type	ws_stack_swap, @function
ws_stack_swap:
.LFB31:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%esi
	pushl	%ebx
	subl	$16, %esp
	.cfi_offset 6, -12
	.cfi_offset 3, -16
	call	__x86.get_pc_thunk.si
	addl	$_GLOBAL_OFFSET_TABLE_, %esi
	call	stack_pop
	movl	%eax, -24(%ebp)
	movl	%edx, -20(%ebp)
	call	stack_pop
	movl	%eax, -16(%ebp)
	movl	%edx, -12(%ebp)
	pushl	-20(%ebp)
	pushl	-24(%ebp)
	call	stack_push
	addl	$8, %esp
	pushl	-12(%ebp)
	pushl	-16(%ebp)
	call	stack_push
	addl	$8, %esp
	movl	12(%ebp), %eax
	movl	%eax, %ecx
	movl	%eax, %ebx
	sarl	$31, %ebx
	movl	current_instruction_index@GOTOFF(%esi), %eax
	movl	4+current_instruction_index@GOTOFF(%esi), %edx
	addl	%ecx, %eax
	adcl	%ebx, %edx
	movl	%eax, current_instruction_index@GOTOFF(%esi)
	movl	%edx, 4+current_instruction_index@GOTOFF(%esi)
	nop
	leal	-8(%ebp), %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE31:
	.size	ws_stack_swap, .-ws_stack_swap
	.globl	ws_stack_discard
	.type	ws_stack_discard, @function
ws_stack_discard:
.LFB32:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%esi
	pushl	%ebx
	.cfi_offset 6, -12
	.cfi_offset 3, -16
	call	__x86.get_pc_thunk.si
	addl	$_GLOBAL_OFFSET_TABLE_, %esi
	call	stack_pop
	movl	12(%ebp), %eax
	movl	%eax, %ecx
	movl	%eax, %ebx
	sarl	$31, %ebx
	movl	current_instruction_index@GOTOFF(%esi), %eax
	movl	4+current_instruction_index@GOTOFF(%esi), %edx
	addl	%ecx, %eax
	adcl	%ebx, %edx
	movl	%eax, current_instruction_index@GOTOFF(%esi)
	movl	%edx, 4+current_instruction_index@GOTOFF(%esi)
	nop
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE32:
	.size	ws_stack_discard, .-ws_stack_discard
	.globl	ws_stack_slide
	.type	ws_stack_slide, @function
ws_stack_slide:
.LFB33:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$60, %esp
	.cfi_offset 7, -12
	.cfi_offset 6, -16
	.cfi_offset 3, -20
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	movl	8(%ebp), %eax
	movl	%eax, -60(%ebp)
	movl	%gs:20, %eax
	movl	%eax, -28(%ebp)
	xorl	%eax, %eax
	call	stack_pop
	movl	%eax, -40(%ebp)
	movl	%edx, -36(%ebp)
	movl	$0, -44(%ebp)
	movl	$0, -52(%ebp)
	movl	12(%ebp), %edx
	movl	-60(%ebp), %eax
	addl	%eax, %edx
	subl	$8, %esp
	leal	-52(%ebp), %eax
	pushl	%eax
	pushl	%edx
	call	retrieve_label_or_number
	addl	$16, %esp
	movl	%eax, -44(%ebp)
	cmpl	$0, -44(%ebp)
	je	.L121
	movl	-52(%ebp), %eax
	subl	$12, %esp
	pushl	%eax
	call	convert_ws_to_number
	addl	$16, %esp
	movl	%eax, -48(%ebp)
	jmp	.L122
.L123:
	call	stack_pop
	subl	$1, -48(%ebp)
.L122:
	cmpl	$0, -48(%ebp)
	jg	.L123
	subl	$8, %esp
	pushl	-36(%ebp)
	pushl	-40(%ebp)
	call	stack_push
	addl	$16, %esp
	movl	12(%ebp), %edx
	movl	-44(%ebp), %eax
	addl	%edx, %eax
	addl	$1, %eax
	movl	%eax, %esi
	movl	%eax, %edi
	sarl	$31, %edi
	movl	current_instruction_index@GOTOFF(%ebx), %eax
	movl	4+current_instruction_index@GOTOFF(%ebx), %edx
	addl	%esi, %eax
	adcl	%edi, %edx
	movl	%eax, current_instruction_index@GOTOFF(%ebx)
	movl	%edx, 4+current_instruction_index@GOTOFF(%ebx)
	movl	-52(%ebp), %eax
	subl	$12, %esp
	pushl	%eax
	call	free@PLT
	addl	$16, %esp
	jmp	.L120
.L121:
	movl	12(%ebp), %eax
	movl	%eax, %esi
	movl	%eax, %edi
	sarl	$31, %edi
	movl	current_instruction_index@GOTOFF(%ebx), %eax
	movl	4+current_instruction_index@GOTOFF(%ebx), %edx
	addl	%esi, %eax
	adcl	%edi, %edx
	movl	%eax, current_instruction_index@GOTOFF(%ebx)
	movl	%edx, 4+current_instruction_index@GOTOFF(%ebx)
	nop
.L120:
	movl	-28(%ebp), %eax
	subl	%gs:20, %eax
	je	.L126
	call	__stack_chk_fail_local
.L126:
	leal	-12(%ebp), %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%edi
	.cfi_restore 7
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE33:
	.size	ws_stack_slide, .-ws_stack_slide
	.globl	ws_math_add
	.type	ws_math_add, @function
ws_math_add:
.LFB34:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%esi
	pushl	%ebx
	subl	$16, %esp
	.cfi_offset 6, -12
	.cfi_offset 3, -16
	call	__x86.get_pc_thunk.si
	addl	$_GLOBAL_OFFSET_TABLE_, %esi
	call	stack_pop
	movl	%eax, -24(%ebp)
	movl	%edx, -20(%ebp)
	call	stack_pop
	movl	%eax, -16(%ebp)
	movl	%edx, -12(%ebp)
	movl	-16(%ebp), %ecx
	movl	-12(%ebp), %ebx
	movl	-24(%ebp), %eax
	movl	-20(%ebp), %edx
	addl	%ecx, %eax
	adcl	%ebx, %edx
	pushl	%edx
	pushl	%eax
	call	stack_push
	addl	$8, %esp
	movl	12(%ebp), %eax
	movl	%eax, %ecx
	movl	%eax, %ebx
	sarl	$31, %ebx
	movl	current_instruction_index@GOTOFF(%esi), %eax
	movl	4+current_instruction_index@GOTOFF(%esi), %edx
	addl	%ecx, %eax
	adcl	%ebx, %edx
	movl	%eax, current_instruction_index@GOTOFF(%esi)
	movl	%edx, 4+current_instruction_index@GOTOFF(%esi)
	nop
	leal	-8(%ebp), %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE34:
	.size	ws_math_add, .-ws_math_add
	.globl	ws_math_sub
	.type	ws_math_sub, @function
ws_math_sub:
.LFB35:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%esi
	pushl	%ebx
	subl	$16, %esp
	.cfi_offset 6, -12
	.cfi_offset 3, -16
	call	__x86.get_pc_thunk.si
	addl	$_GLOBAL_OFFSET_TABLE_, %esi
	call	stack_pop
	movl	%eax, -24(%ebp)
	movl	%edx, -20(%ebp)
	call	stack_pop
	movl	%eax, -16(%ebp)
	movl	%edx, -12(%ebp)
	movl	-16(%ebp), %eax
	movl	-12(%ebp), %edx
	subl	-24(%ebp), %eax
	sbbl	-20(%ebp), %edx
	pushl	%edx
	pushl	%eax
	call	stack_push
	addl	$8, %esp
	movl	12(%ebp), %eax
	movl	%eax, %ecx
	movl	%eax, %ebx
	sarl	$31, %ebx
	movl	current_instruction_index@GOTOFF(%esi), %eax
	movl	4+current_instruction_index@GOTOFF(%esi), %edx
	addl	%ecx, %eax
	adcl	%ebx, %edx
	movl	%eax, current_instruction_index@GOTOFF(%esi)
	movl	%edx, 4+current_instruction_index@GOTOFF(%esi)
	nop
	leal	-8(%ebp), %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE35:
	.size	ws_math_sub, .-ws_math_sub
	.globl	ws_math_mult
	.type	ws_math_mult, @function
ws_math_mult:
.LFB36:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%esi
	pushl	%ebx
	subl	$16, %esp
	.cfi_offset 6, -12
	.cfi_offset 3, -16
	call	__x86.get_pc_thunk.si
	addl	$_GLOBAL_OFFSET_TABLE_, %esi
	call	stack_pop
	movl	%eax, -24(%ebp)
	movl	%edx, -20(%ebp)
	call	stack_pop
	movl	%eax, -16(%ebp)
	movl	%edx, -12(%ebp)
	movl	-12(%ebp), %eax
	imull	-24(%ebp), %eax
	movl	%eax, %edx
	movl	-20(%ebp), %eax
	imull	-16(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	-24(%ebp), %eax
	mull	-16(%ebp)
	addl	%edx, %ecx
	movl	%ecx, %edx
	pushl	%edx
	pushl	%eax
	call	stack_push
	addl	$8, %esp
	movl	12(%ebp), %eax
	movl	%eax, %ecx
	movl	%eax, %ebx
	sarl	$31, %ebx
	movl	current_instruction_index@GOTOFF(%esi), %eax
	movl	4+current_instruction_index@GOTOFF(%esi), %edx
	addl	%ecx, %eax
	adcl	%ebx, %edx
	movl	%eax, current_instruction_index@GOTOFF(%esi)
	movl	%edx, 4+current_instruction_index@GOTOFF(%esi)
	nop
	leal	-8(%ebp), %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE36:
	.size	ws_math_mult, .-ws_math_mult
	.globl	__divdi3
	.globl	ws_math_div
	.type	ws_math_div, @function
ws_math_div:
.LFB37:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$28, %esp
	.cfi_offset 7, -12
	.cfi_offset 6, -16
	.cfi_offset 3, -20
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	call	stack_pop
	movl	%eax, -40(%ebp)
	movl	%edx, -36(%ebp)
	call	stack_pop
	movl	%eax, -32(%ebp)
	movl	%edx, -28(%ebp)
	pushl	-36(%ebp)
	pushl	-40(%ebp)
	pushl	-28(%ebp)
	pushl	-32(%ebp)
	call	__divdi3@PLT
	addl	$16, %esp
	subl	$8, %esp
	pushl	%edx
	pushl	%eax
	call	stack_push
	addl	$16, %esp
	movl	12(%ebp), %eax
	movl	%eax, %esi
	movl	%eax, %edi
	sarl	$31, %edi
	movl	current_instruction_index@GOTOFF(%ebx), %eax
	movl	4+current_instruction_index@GOTOFF(%ebx), %edx
	addl	%esi, %eax
	adcl	%edi, %edx
	movl	%eax, current_instruction_index@GOTOFF(%ebx)
	movl	%edx, 4+current_instruction_index@GOTOFF(%ebx)
	nop
	leal	-12(%ebp), %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%edi
	.cfi_restore 7
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE37:
	.size	ws_math_div, .-ws_math_div
	.globl	__moddi3
	.globl	ws_math_mod
	.type	ws_math_mod, @function
ws_math_mod:
.LFB38:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$28, %esp
	.cfi_offset 7, -12
	.cfi_offset 6, -16
	.cfi_offset 3, -20
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	call	stack_pop
	movl	%eax, -40(%ebp)
	movl	%edx, -36(%ebp)
	call	stack_pop
	movl	%eax, -32(%ebp)
	movl	%edx, -28(%ebp)
	movl	-32(%ebp), %eax
	movl	-28(%ebp), %edx
	pushl	-36(%ebp)
	pushl	-40(%ebp)
	pushl	%edx
	pushl	%eax
	call	__moddi3@PLT
	addl	$16, %esp
	subl	$8, %esp
	pushl	%edx
	pushl	%eax
	call	stack_push
	addl	$16, %esp
	movl	12(%ebp), %eax
	movl	%eax, %esi
	movl	%eax, %edi
	sarl	$31, %edi
	movl	current_instruction_index@GOTOFF(%ebx), %eax
	movl	4+current_instruction_index@GOTOFF(%ebx), %edx
	addl	%esi, %eax
	adcl	%edi, %edx
	movl	%eax, current_instruction_index@GOTOFF(%ebx)
	movl	%edx, 4+current_instruction_index@GOTOFF(%ebx)
	nop
	leal	-12(%ebp), %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%edi
	.cfi_restore 7
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE38:
	.size	ws_math_mod, .-ws_math_mod
	.globl	ws_heap_store
	.type	ws_heap_store, @function
ws_heap_store:
.LFB39:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%esi
	pushl	%ebx
	subl	$16, %esp
	.cfi_offset 6, -12
	.cfi_offset 3, -16
	call	__x86.get_pc_thunk.si
	addl	$_GLOBAL_OFFSET_TABLE_, %esi
	call	stack_pop
	movl	%eax, -24(%ebp)
	movl	%edx, -20(%ebp)
	call	stack_pop
	movl	%eax, -16(%ebp)
	movl	%edx, -12(%ebp)
	pushl	-12(%ebp)
	pushl	-16(%ebp)
	pushl	-20(%ebp)
	pushl	-24(%ebp)
	call	heap_put
	addl	$16, %esp
	movl	12(%ebp), %eax
	movl	%eax, %ecx
	movl	%eax, %ebx
	sarl	$31, %ebx
	movl	current_instruction_index@GOTOFF(%esi), %eax
	movl	4+current_instruction_index@GOTOFF(%esi), %edx
	addl	%ecx, %eax
	adcl	%ebx, %edx
	movl	%eax, current_instruction_index@GOTOFF(%esi)
	movl	%edx, 4+current_instruction_index@GOTOFF(%esi)
	nop
	leal	-8(%ebp), %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE39:
	.size	ws_heap_store, .-ws_heap_store
	.globl	ws_heap_retrieve
	.type	ws_heap_retrieve, @function
ws_heap_retrieve:
.LFB40:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%esi
	pushl	%ebx
	.cfi_offset 6, -12
	.cfi_offset 3, -16
	call	__x86.get_pc_thunk.si
	addl	$_GLOBAL_OFFSET_TABLE_, %esi
	call	stack_pop
	pushl	%edx
	pushl	%eax
	call	heap_get
	addl	$8, %esp
	pushl	%edx
	pushl	%eax
	call	stack_push
	addl	$8, %esp
	movl	12(%ebp), %eax
	movl	%eax, %ecx
	movl	%eax, %ebx
	sarl	$31, %ebx
	movl	current_instruction_index@GOTOFF(%esi), %eax
	movl	4+current_instruction_index@GOTOFF(%esi), %edx
	addl	%ecx, %eax
	adcl	%ebx, %edx
	movl	%eax, current_instruction_index@GOTOFF(%esi)
	movl	%edx, 4+current_instruction_index@GOTOFF(%esi)
	nop
	leal	-8(%ebp), %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE40:
	.size	ws_heap_retrieve, .-ws_heap_retrieve
	.globl	ws_flow_mark
	.type	ws_flow_mark, @function
ws_flow_mark:
.LFB41:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%esi
	pushl	%ebx
	subl	$16, %esp
	.cfi_offset 6, -12
	.cfi_offset 3, -16
	call	__x86.get_pc_thunk.si
	addl	$_GLOBAL_OFFSET_TABLE_, %esi
	movl	$1, -12(%ebp)
	jmp	.L142
.L143:
	addl	$1, -12(%ebp)
.L142:
	movl	-12(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	cmpb	$10, %al
	jne	.L143
	movl	-12(%ebp), %eax
	addl	$1, %eax
	movl	%eax, %ecx
	movl	%eax, %ebx
	sarl	$31, %ebx
	movl	current_instruction_index@GOTOFF(%esi), %eax
	movl	4+current_instruction_index@GOTOFF(%esi), %edx
	addl	%ecx, %eax
	adcl	%ebx, %edx
	movl	%eax, current_instruction_index@GOTOFF(%esi)
	movl	%edx, 4+current_instruction_index@GOTOFF(%esi)
	nop
	addl	$16, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE41:
	.size	ws_flow_mark, .-ws_flow_mark
	.globl	ws_flow_call
	.type	ws_flow_call, @function
ws_flow_call:
.LFB42:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$44, %esp
	.cfi_offset 7, -12
	.cfi_offset 6, -16
	.cfi_offset 3, -20
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	movl	8(%ebp), %eax
	movl	%eax, -44(%ebp)
	movl	%gs:20, %eax
	movl	%eax, -28(%ebp)
	xorl	%eax, %eax
	movl	$0, -32(%ebp)
	movl	12(%ebp), %edx
	movl	-44(%ebp), %eax
	addl	%eax, %edx
	subl	$8, %esp
	leal	-36(%ebp), %eax
	pushl	%eax
	pushl	%edx
	call	retrieve_label_or_number
	addl	$16, %esp
	movl	%eax, -32(%ebp)
	cmpl	$0, -32(%ebp)
	je	.L146
	movl	12(%ebp), %eax
	movl	%eax, %esi
	movl	%eax, %edi
	sarl	$31, %edi
	movl	current_instruction_index@GOTOFF(%ebx), %eax
	movl	4+current_instruction_index@GOTOFF(%ebx), %edx
	addl	%eax, %esi
	adcl	%edx, %edi
	movl	-32(%ebp), %eax
	cltd
	addl	%esi, %eax
	adcl	%edi, %edx
	addl	$1, %eax
	adcl	$0, %edx
	subl	$8, %esp
	pushl	%edx
	pushl	%eax
	call	add_ret_addr
	addl	$16, %esp
	testb	%al, %al
	je	.L147
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	-44(%ebp)
	call	ws_flow_jump
	addl	$16, %esp
.L147:
	movl	-36(%ebp), %eax
	subl	$12, %esp
	pushl	%eax
	call	free@PLT
	addl	$16, %esp
	jmp	.L145
.L146:
	movl	12(%ebp), %eax
	movl	%eax, %esi
	movl	%eax, %edi
	sarl	$31, %edi
	movl	current_instruction_index@GOTOFF(%ebx), %eax
	movl	4+current_instruction_index@GOTOFF(%ebx), %edx
	addl	%esi, %eax
	adcl	%edi, %edx
	subl	$8, %esp
	pushl	%edx
	pushl	%eax
	call	add_ret_addr
	addl	$16, %esp
	nop
.L145:
	movl	-28(%ebp), %eax
	subl	%gs:20, %eax
	je	.L150
	call	__stack_chk_fail_local
.L150:
	leal	-12(%ebp), %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%edi
	.cfi_restore 7
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE42:
	.size	ws_flow_call, .-ws_flow_call
	.globl	ws_flow_jump
	.type	ws_flow_jump, @function
ws_flow_jump:
.LFB43:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$44, %esp
	.cfi_offset 7, -12
	.cfi_offset 6, -16
	.cfi_offset 3, -20
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	movl	8(%ebp), %eax
	movl	%eax, -44(%ebp)
	movl	%gs:20, %eax
	movl	%eax, -28(%ebp)
	xorl	%eax, %eax
	movl	12(%ebp), %edx
	movl	-44(%ebp), %eax
	addl	%eax, %edx
	subl	$8, %esp
	leal	-36(%ebp), %eax
	pushl	%eax
	pushl	%edx
	call	retrieve_label_or_number
	addl	$16, %esp
	testl	%eax, %eax
	je	.L152
	movl	$0, -32(%ebp)
	jmp	.L153
.L156:
	movl	-36(%ebp), %edx
	movl	label_table@GOTOFF(%ebx), %eax
	movl	-32(%ebp), %ecx
	sall	$2, %ecx
	addl	%ecx, %eax
	movl	(%eax), %eax
	subl	$8, %esp
	pushl	%edx
	pushl	%eax
	call	strcmp@PLT
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L154
	movl	4+label_table@GOTOFF(%ebx), %eax
	movl	-32(%ebp), %edx
	sall	$2, %edx
	addl	%edx, %eax
	movl	(%eax), %eax
	cltd
	movl	%eax, current_instruction_index@GOTOFF(%ebx)
	movl	%edx, 4+current_instruction_index@GOTOFF(%ebx)
	jmp	.L155
.L154:
	addl	$1, -32(%ebp)
.L153:
	movl	8+label_table@GOTOFF(%ebx), %eax
	cmpl	%eax, -32(%ebp)
	jl	.L156
.L155:
	movl	-36(%ebp), %eax
	subl	$12, %esp
	pushl	%eax
	call	free@PLT
	addl	$16, %esp
	jmp	.L151
.L152:
	movl	12(%ebp), %eax
	movl	%eax, %esi
	movl	%eax, %edi
	sarl	$31, %edi
	movl	current_instruction_index@GOTOFF(%ebx), %eax
	movl	4+current_instruction_index@GOTOFF(%ebx), %edx
	addl	%esi, %eax
	adcl	%edi, %edx
	movl	%eax, current_instruction_index@GOTOFF(%ebx)
	movl	%edx, 4+current_instruction_index@GOTOFF(%ebx)
	nop
.L151:
	movl	-28(%ebp), %eax
	subl	%gs:20, %eax
	je	.L159
	call	__stack_chk_fail_local
.L159:
	leal	-12(%ebp), %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%edi
	.cfi_restore 7
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE43:
	.size	ws_flow_jump, .-ws_flow_jump
	.globl	ws_flow_jz
	.type	ws_flow_jz, @function
ws_flow_jz:
.LFB44:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$44, %esp
	.cfi_offset 7, -12
	.cfi_offset 6, -16
	.cfi_offset 3, -20
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	movl	8(%ebp), %eax
	movl	%eax, -44(%ebp)
	movl	%gs:20, %eax
	movl	%eax, -28(%ebp)
	xorl	%eax, %eax
	call	stack_pop
	movl	%eax, %ecx
	movl	%ecx, %eax
	orl	%edx, %eax
	jne	.L161
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	-44(%ebp)
	call	ws_flow_jump
	addl	$16, %esp
	jmp	.L160
.L161:
	movl	12(%ebp), %edx
	movl	-44(%ebp), %eax
	addl	%eax, %edx
	subl	$8, %esp
	leal	-36(%ebp), %eax
	pushl	%eax
	pushl	%edx
	call	retrieve_label_or_number
	addl	$16, %esp
	movl	%eax, -32(%ebp)
	cmpl	$0, -32(%ebp)
	je	.L163
	movl	12(%ebp), %edx
	movl	-32(%ebp), %eax
	addl	%edx, %eax
	addl	$1, %eax
	movl	%eax, %esi
	movl	%eax, %edi
	sarl	$31, %edi
	movl	current_instruction_index@GOTOFF(%ebx), %eax
	movl	4+current_instruction_index@GOTOFF(%ebx), %edx
	addl	%esi, %eax
	adcl	%edi, %edx
	movl	%eax, current_instruction_index@GOTOFF(%ebx)
	movl	%edx, 4+current_instruction_index@GOTOFF(%ebx)
	movl	-36(%ebp), %eax
	subl	$12, %esp
	pushl	%eax
	call	free@PLT
	addl	$16, %esp
	jmp	.L160
.L163:
	movl	12(%ebp), %eax
	movl	%eax, %esi
	movl	%eax, %edi
	sarl	$31, %edi
	movl	current_instruction_index@GOTOFF(%ebx), %eax
	movl	4+current_instruction_index@GOTOFF(%ebx), %edx
	addl	%esi, %eax
	adcl	%edi, %edx
	movl	%eax, current_instruction_index@GOTOFF(%ebx)
	movl	%edx, 4+current_instruction_index@GOTOFF(%ebx)
	nop
.L160:
	movl	-28(%ebp), %eax
	subl	%gs:20, %eax
	je	.L165
	call	__stack_chk_fail_local
.L165:
	leal	-12(%ebp), %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%edi
	.cfi_restore 7
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE44:
	.size	ws_flow_jz, .-ws_flow_jz
	.globl	ws_flow_jn
	.type	ws_flow_jn, @function
ws_flow_jn:
.LFB45:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$44, %esp
	.cfi_offset 7, -12
	.cfi_offset 6, -16
	.cfi_offset 3, -20
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	movl	8(%ebp), %eax
	movl	%eax, -44(%ebp)
	movl	%gs:20, %eax
	movl	%eax, -28(%ebp)
	xorl	%eax, %eax
	call	stack_pop
	testl	%edx, %edx
	jns	.L167
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	-44(%ebp)
	call	ws_flow_jump
	addl	$16, %esp
	jmp	.L166
.L167:
	movl	12(%ebp), %edx
	movl	-44(%ebp), %eax
	addl	%eax, %edx
	subl	$8, %esp
	leal	-36(%ebp), %eax
	pushl	%eax
	pushl	%edx
	call	retrieve_label_or_number
	addl	$16, %esp
	movl	%eax, -32(%ebp)
	cmpl	$0, -32(%ebp)
	je	.L169
	movl	12(%ebp), %edx
	movl	-32(%ebp), %eax
	addl	%edx, %eax
	addl	$1, %eax
	movl	%eax, %esi
	movl	%eax, %edi
	sarl	$31, %edi
	movl	current_instruction_index@GOTOFF(%ebx), %eax
	movl	4+current_instruction_index@GOTOFF(%ebx), %edx
	addl	%esi, %eax
	adcl	%edi, %edx
	movl	%eax, current_instruction_index@GOTOFF(%ebx)
	movl	%edx, 4+current_instruction_index@GOTOFF(%ebx)
	movl	-36(%ebp), %eax
	subl	$12, %esp
	pushl	%eax
	call	free@PLT
	addl	$16, %esp
	jmp	.L166
.L169:
	movl	12(%ebp), %eax
	movl	%eax, %esi
	movl	%eax, %edi
	sarl	$31, %edi
	movl	current_instruction_index@GOTOFF(%ebx), %eax
	movl	4+current_instruction_index@GOTOFF(%ebx), %edx
	addl	%esi, %eax
	adcl	%edi, %edx
	movl	%eax, current_instruction_index@GOTOFF(%ebx)
	movl	%edx, 4+current_instruction_index@GOTOFF(%ebx)
	nop
.L166:
	movl	-28(%ebp), %eax
	subl	%gs:20, %eax
	je	.L171
	call	__stack_chk_fail_local
.L171:
	leal	-12(%ebp), %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%edi
	.cfi_restore 7
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE45:
	.size	ws_flow_jn, .-ws_flow_jn
	.globl	ws_flow_ret
	.type	ws_flow_ret, @function
ws_flow_ret:
.LFB46:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$4, %esp
	.cfi_offset 3, -12
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	call	get_last_ret_addr
	movl	%eax, current_instruction_index@GOTOFF(%ebx)
	movl	%edx, 4+current_instruction_index@GOTOFF(%ebx)
	nop
	movl	-4(%ebp), %ebx
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE46:
	.size	ws_flow_ret, .-ws_flow_ret
	.globl	ws_flow_exit
	.type	ws_flow_exit, @function
ws_flow_exit:
.LFB47:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	call	__x86.get_pc_thunk.ax
	addl	$_GLOBAL_OFFSET_TABLE_, %eax
	movl	$-1, current_instruction_index@GOTOFF(%eax)
	movl	$-1, 4+current_instruction_index@GOTOFF(%eax)
	nop
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE47:
	.size	ws_flow_exit, .-ws_flow_exit
	.globl	ws_io_outc
	.type	ws_io_outc, @function
ws_io_outc:
.LFB48:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$12, %esp
	.cfi_offset 7, -12
	.cfi_offset 6, -16
	.cfi_offset 3, -20
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	call	stack_pop
	subl	$12, %esp
	pushl	%eax
	call	putchar@PLT
	addl	$16, %esp
	movl	12(%ebp), %eax
	movl	%eax, %esi
	movl	%eax, %edi
	sarl	$31, %edi
	movl	current_instruction_index@GOTOFF(%ebx), %eax
	movl	4+current_instruction_index@GOTOFF(%ebx), %edx
	addl	%esi, %eax
	adcl	%edi, %edx
	movl	%eax, current_instruction_index@GOTOFF(%ebx)
	movl	%edx, 4+current_instruction_index@GOTOFF(%ebx)
	nop
	leal	-12(%ebp), %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%edi
	.cfi_restore 7
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE48:
	.size	ws_io_outc, .-ws_io_outc
	.section	.rodata
.LC26:
	.string	"%lld"
	.text
	.globl	ws_io_outn
	.type	ws_io_outn, @function
ws_io_outn:
.LFB49:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$12, %esp
	.cfi_offset 7, -12
	.cfi_offset 6, -16
	.cfi_offset 3, -20
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	call	stack_pop
	subl	$4, %esp
	pushl	%edx
	pushl	%eax
	leal	.LC26@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printf@PLT
	addl	$16, %esp
	movl	stdout@GOT(%ebx), %eax
	movl	(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	fflush@PLT
	addl	$16, %esp
	movl	12(%ebp), %eax
	movl	%eax, %esi
	movl	%eax, %edi
	sarl	$31, %edi
	movl	current_instruction_index@GOTOFF(%ebx), %eax
	movl	4+current_instruction_index@GOTOFF(%ebx), %edx
	addl	%esi, %eax
	adcl	%edi, %edx
	movl	%eax, current_instruction_index@GOTOFF(%ebx)
	movl	%edx, 4+current_instruction_index@GOTOFF(%ebx)
	nop
	leal	-12(%ebp), %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%edi
	.cfi_restore 7
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE49:
	.size	ws_io_outn, .-ws_io_outn
	.globl	ws_io_inc
	.type	ws_io_inc, @function
ws_io_inc:
.LFB50:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%esi
	pushl	%ebx
	subl	$16, %esp
	.cfi_offset 6, -12
	.cfi_offset 3, -16
	call	__x86.get_pc_thunk.si
	addl	$_GLOBAL_OFFSET_TABLE_, %esi
	movl	%esi, %ebx
	call	getchar@PLT
	movl	%eax, -12(%ebp)
	call	stack_pop
	movl	-12(%ebp), %ecx
	movl	%ecx, %ebx
	sarl	$31, %ebx
	pushl	%edx
	pushl	%eax
	pushl	%ebx
	pushl	%ecx
	call	heap_put
	addl	$16, %esp
	movl	12(%ebp), %eax
	movl	%eax, %ecx
	movl	%eax, %ebx
	sarl	$31, %ebx
	movl	current_instruction_index@GOTOFF(%esi), %eax
	movl	4+current_instruction_index@GOTOFF(%esi), %edx
	addl	%ecx, %eax
	adcl	%ebx, %edx
	movl	%eax, current_instruction_index@GOTOFF(%esi)
	movl	%edx, 4+current_instruction_index@GOTOFF(%esi)
	nop
	leal	-8(%ebp), %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE50:
	.size	ws_io_inc, .-ws_io_inc
	.section	.rodata
.LC27:
	.string	"%18s"
	.text
	.globl	ws_io_inn
	.type	ws_io_inn, @function
ws_io_inn:
.LFB51:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$60, %esp
	.cfi_offset 7, -12
	.cfi_offset 6, -16
	.cfi_offset 3, -20
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	movl	8(%ebp), %eax
	movl	%eax, -60(%ebp)
	movl	%gs:20, %eax
	movl	%eax, -28(%ebp)
	xorl	%eax, %eax
	subl	$8, %esp
	leal	-47(%ebp), %eax
	pushl	%eax
	leal	.LC27@GOTOFF(%ebx), %eax
	pushl	%eax
	call	__isoc99_scanf@PLT
	addl	$16, %esp
	call	stack_pop
	movl	%eax, %esi
	movl	%edx, %edi
	subl	$4, %esp
	pushl	$10
	leal	-52(%ebp), %eax
	pushl	%eax
	leal	-47(%ebp), %eax
	pushl	%eax
	call	strtoll@PLT
	addl	$16, %esp
	pushl	%edi
	pushl	%esi
	pushl	%edx
	pushl	%eax
	call	heap_put
	addl	$16, %esp
	movl	12(%ebp), %eax
	movl	%eax, %esi
	movl	%eax, %edi
	sarl	$31, %edi
	movl	current_instruction_index@GOTOFF(%ebx), %eax
	movl	4+current_instruction_index@GOTOFF(%ebx), %edx
	addl	%esi, %eax
	adcl	%edi, %edx
	movl	%eax, current_instruction_index@GOTOFF(%ebx)
	movl	%edx, 4+current_instruction_index@GOTOFF(%ebx)
	nop
	movl	-28(%ebp), %eax
	subl	%gs:20, %eax
	je	.L184
	call	__stack_chk_fail_local
.L184:
	leal	-12(%ebp), %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%edi
	.cfi_restore 7
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE51:
	.size	ws_io_inn, .-ws_io_inn
	.section	.text.__x86.get_pc_thunk.ax,"axG",@progbits,__x86.get_pc_thunk.ax,comdat
	.globl	__x86.get_pc_thunk.ax
	.hidden	__x86.get_pc_thunk.ax
	.type	__x86.get_pc_thunk.ax, @function
__x86.get_pc_thunk.ax:
.LFB52:
	.cfi_startproc
	movl	(%esp), %eax
	ret
	.cfi_endproc
.LFE52:
	.section	.text.__x86.get_pc_thunk.cx,"axG",@progbits,__x86.get_pc_thunk.cx,comdat
	.globl	__x86.get_pc_thunk.cx
	.hidden	__x86.get_pc_thunk.cx
	.type	__x86.get_pc_thunk.cx, @function
__x86.get_pc_thunk.cx:
.LFB53:
	.cfi_startproc
	movl	(%esp), %ecx
	ret
	.cfi_endproc
.LFE53:
	.section	.text.__x86.get_pc_thunk.bx,"axG",@progbits,__x86.get_pc_thunk.bx,comdat
	.globl	__x86.get_pc_thunk.bx
	.hidden	__x86.get_pc_thunk.bx
	.type	__x86.get_pc_thunk.bx, @function
__x86.get_pc_thunk.bx:
.LFB54:
	.cfi_startproc
	movl	(%esp), %ebx
	ret
	.cfi_endproc
.LFE54:
	.section	.text.__x86.get_pc_thunk.si,"axG",@progbits,__x86.get_pc_thunk.si,comdat
	.globl	__x86.get_pc_thunk.si
	.hidden	__x86.get_pc_thunk.si
	.type	__x86.get_pc_thunk.si, @function
__x86.get_pc_thunk.si:
.LFB55:
	.cfi_startproc
	movl	(%esp), %esi
	ret
	.cfi_endproc
