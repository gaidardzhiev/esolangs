	.text
	.globl	stack
	.bss
	.align 16
	.type	stack, @object
	.size	stack, 24
stack:
	.zero	24
	.globl	heap
	.align 16
	.type	heap, @object
	.size	heap, 24
heap:
	.zero	24
	.globl	label_table
	.align 16
	.type	label_table, @object
	.size	label_table, 24
label_table:
	.zero	24
	.globl	instruction_set
	.align 16
	.type	instruction_set, @object
	.size	instruction_set, 24
instruction_set:
	.zero	24
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
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	cmpl	$2, -20(%rbp)
	jne	.L2
	movq	-32(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	-16(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	read_source_file
	testq	%rax, %rax
	je	.L3
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	remove_comments
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
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	locate_jump_labels
	testb	%al, %al
	je	.L7
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	step_through_program
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
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
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, %rsi
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
.L3:
	movl	$1, %eax
.L9:
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L10
	call	__stack_chk_fail@PLT
.L10:
	leave
	.cfi_def_cfa 7, 8
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
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	-24(%rbp), %rax
	leaq	.LC1(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	fopen@PLT
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	je	.L12
	movq	-16(%rbp), %rax
	movl	$2, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	fseek@PLT
	testl	%eax, %eax
	jne	.L13
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	ftell@PLT
	movq	%rax, -8(%rbp)
	cmpq	$-1, -8(%rbp)
	je	.L13
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	rewind@PLT
	movq	-8(%rbp), %rax
	addq	$1, %rax
	movl	$1, %esi
	movq	%rax, %rdi
	call	calloc@PLT
	movq	%rax, %rdx
	movq	-32(%rbp), %rax
	movq	%rdx, (%rax)
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L13
	movq	-8(%rbp), %rax
	addq	$1, %rax
	movq	%rax, %rsi
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	-16(%rbp), %rdx
	movq	%rdx, %rcx
	movq	%rsi, %rdx
	movl	$1, %esi
	movq	%rax, %rdi
	call	fread@PLT
	testq	%rax, %rax
	je	.L14
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	fclose@PLT
	movq	-8(%rbp), %rax
	jmp	.L15
.L14:
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	free@PLT
.L13:
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	fclose@PLT
.L12:
	movl	$0, %eax
.L15:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	read_source_file, .-read_source_file
	.globl	remove_comments
	.type	remove_comments, @function
remove_comments:
.LFB8:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	$0, -8(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L17
.L19:
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$9, %al
	je	.L18
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$10, %al
	je	.L18
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$32, %al
	je	.L18
	movl	-4(%rbp), %eax
	cltq
	leaq	1(%rax), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	movl	-4(%rbp), %eax
	cltq
	leaq	1(%rax), %rcx
	movq	-24(%rbp), %rax
	addq	%rax, %rcx
	movl	-4(%rbp), %eax
	movslq	%eax, %rsi
	movq	-24(%rbp), %rax
	addq	%rsi, %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	memmove@PLT
	subl	$1, -4(%rbp)
	addl	$1, -8(%rbp)
.L18:
	addl	$1, -4(%rbp)
.L17:
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L19
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	movl	-8(%rbp), %eax
	cltq
	subq	%rax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movb	$0, (%rax)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	remove_comments, .-remove_comments
	.globl	create_stack
	.type	create_stack, @function
create_stack:
.LFB9:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$8, %esi
	movl	$2048, %edi
	call	calloc@PLT
	movq	%rax, 16+stack(%rip)
	movq	16+stack(%rip), %rax
	testq	%rax, %rax
	je	.L22
	movq	$2048, stack(%rip)
	movq	$2048, 8+stack(%rip)
	movl	$1, %eax
	jmp	.L23
.L22:
	movl	$0, %eax
.L23:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	create_stack, .-create_stack
	.globl	stack_push
	.type	stack_push, @function
stack_push:
.LFB10:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	8+stack(%rip), %rax
	testq	%rax, %rax
	jle	.L25
	movq	8+stack(%rip), %rax
	subq	$1, %rax
	movq	%rax, 8+stack(%rip)
	movq	16+stack(%rip), %rax
	movq	8+stack(%rip), %rdx
	salq	$3, %rdx
	addq	%rax, %rdx
	movq	-8(%rbp), %rax
	movq	%rax, (%rdx)
	movl	$1, %eax
	jmp	.L26
.L25:
	movl	$0, %eax
.L26:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	stack_push, .-stack_push
	.globl	stack_pop
	.type	stack_pop, @function
stack_pop:
.LFB11:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	8+stack(%rip), %rdx
	movq	stack(%rip), %rax
	cmpq	%rax, %rdx
	jge	.L28
	movq	8+stack(%rip), %rax
	addq	$1, %rax
	movq	%rax, 8+stack(%rip)
	movq	16+stack(%rip), %rax
	movq	8+stack(%rip), %rdx
	salq	$3, %rdx
	subq	$8, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	jmp	.L29
.L28:
	movl	$0, %eax
.L29:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	stack_pop, .-stack_pop
	.globl	stack_peak
	.type	stack_peak, @function
stack_peak:
.LFB12:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -4(%rbp)
	movq	8+stack(%rip), %rdx
	movl	-4(%rbp), %eax
	cltq
	addq	%rax, %rdx
	movq	stack(%rip), %rax
	cmpq	%rax, %rdx
	jge	.L31
	movq	16+stack(%rip), %rax
	movq	8+stack(%rip), %rcx
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	addq	%rcx, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	jmp	.L32
.L31:
	movl	$0, %eax
.L32:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	stack_peak, .-stack_peak
	.globl	cleanup_stack
	.type	cleanup_stack, @function
cleanup_stack:
.LFB13:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	16+stack(%rip), %rax
	movq	%rax, %rdi
	call	free@PLT
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	cleanup_stack, .-cleanup_stack
	.globl	create_heap
	.type	create_heap, @function
create_heap:
.LFB14:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$8, %esi
	movl	$2048, %edi
	call	calloc@PLT
	movq	%rax, heap(%rip)
	movq	heap(%rip), %rax
	testq	%rax, %rax
	je	.L36
	movl	$8, %esi
	movl	$2048, %edi
	call	calloc@PLT
	movq	%rax, 8+heap(%rip)
	movq	8+heap(%rip), %rax
	testq	%rax, %rax
	je	.L37
	movq	$0, 16+heap(%rip)
	movl	$1, %eax
	jmp	.L38
.L37:
	movq	heap(%rip), %rax
	movq	%rax, %rdi
	call	free@PLT
.L36:
	movl	$0, %eax
.L38:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	create_heap, .-create_heap
	.globl	heap_put
	.type	heap_put, @function
heap_put:
.LFB15:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movl	$0, -8(%rbp)
	jmp	.L40
.L43:
	movq	heap(%rip), %rax
	movl	-8(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	cmpq	%rax, -32(%rbp)
	jne	.L41
	movq	8+heap(%rip), %rax
	movl	-8(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rax, %rdx
	movq	-24(%rbp), %rax
	movq	%rax, (%rdx)
	movl	$1, %eax
	jmp	.L42
.L41:
	addl	$1, -8(%rbp)
.L40:
	movl	-8(%rbp), %eax
	movslq	%eax, %rdx
	movq	16+heap(%rip), %rax
	cmpq	%rax, %rdx
	jl	.L43
	movq	16+heap(%rip), %rax
	cmpq	$2047, %rax
	jg	.L44
	movq	16+heap(%rip), %rax
	movl	%eax, -4(%rbp)
	movq	heap(%rip), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rax, %rdx
	movq	-32(%rbp), %rax
	movq	%rax, (%rdx)
	movq	8+heap(%rip), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rax, %rdx
	movq	-24(%rbp), %rax
	movq	%rax, (%rdx)
	movq	16+heap(%rip), %rax
	addq	$1, %rax
	movq	%rax, 16+heap(%rip)
	movl	$1, %eax
	jmp	.L42
.L44:
	movl	$0, %eax
.L42:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.size	heap_put, .-heap_put
	.globl	heap_get
	.type	heap_get, @function
heap_get:
.LFB16:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L46
.L49:
	movq	heap(%rip), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	cmpq	%rax, -24(%rbp)
	jne	.L47
	movq	8+heap(%rip), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	jmp	.L48
.L47:
	addl	$1, -4(%rbp)
.L46:
	cmpl	$2047, -4(%rbp)
	jle	.L49
	movl	$0, %eax
.L48:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.size	heap_get, .-heap_get
	.globl	cleanup_heap
	.type	cleanup_heap, @function
cleanup_heap:
.LFB17:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	heap(%rip), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	8+heap(%rip), %rax
	movq	%rax, %rdi
	call	free@PLT
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.size	cleanup_heap, .-cleanup_heap
	.globl	create_label_table
	.type	create_label_table, @function
create_label_table:
.LFB18:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$8, %esi
	movl	$200, %edi
	call	calloc@PLT
	movq	%rax, label_table(%rip)
	movq	label_table(%rip), %rax
	testq	%rax, %rax
	je	.L53
	movl	$4, %esi
	movl	$200, %edi
	call	calloc@PLT
	movq	%rax, 8+label_table(%rip)
	movq	8+label_table(%rip), %rax
	testq	%rax, %rax
	je	.L54
	movl	$1, %eax
	jmp	.L55
.L54:
	movq	label_table(%rip), %rax
	movq	%rax, %rdi
	call	free@PLT
.L53:
	movl	$0, %eax
.L55:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE18:
	.size	create_label_table, .-create_label_table
	.globl	cleanup_label_table
	.type	cleanup_label_table, @function
cleanup_label_table:
.LFB19:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	$0, -4(%rbp)
	jmp	.L57
.L59:
	movq	label_table(%rip), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	free@PLT
	addl	$1, -4(%rbp)
.L57:
	cmpl	$199, -4(%rbp)
	jg	.L58
	movq	8+label_table(%rip), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$2, %rdx
	addq	%rdx, %rax
	movl	(%rax), %eax
	testl	%eax, %eax
	jne	.L59
.L58:
	movq	label_table(%rip), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	8+label_table(%rip), %rax
	movq	%rax, %rdi
	call	free@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
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
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$8, %esi
	movl	$24, %edi
	call	calloc@PLT
	movq	%rax, instruction_set(%rip)
	movl	$4, %esi
	movl	$24, %edi
	call	calloc@PLT
	movq	%rax, 16+instruction_set(%rip)
	movl	$8, %esi
	movl	$24, %edi
	call	calloc@PLT
	movq	%rax, 8+instruction_set(%rip)
	movq	instruction_set(%rip), %rax
	leaq	.LC2(%rip), %rdx
	movq	%rdx, (%rax)
	movq	8+instruction_set(%rip), %rax
	leaq	ws_stack_push(%rip), %rdx
	movq	%rdx, (%rax)
	movq	16+instruction_set(%rip), %rax
	movl	$2, (%rax)
	movq	instruction_set(%rip), %rax
	addq	$8, %rax
	leaq	.LC3(%rip), %rdx
	movq	%rdx, (%rax)
	movq	8+instruction_set(%rip), %rax
	addq	$8, %rax
	leaq	ws_stack_dup(%rip), %rdx
	movq	%rdx, (%rax)
	movq	16+instruction_set(%rip), %rax
	addq	$4, %rax
	movl	$3, (%rax)
	movq	instruction_set(%rip), %rax
	addq	$16, %rax
	leaq	.LC4(%rip), %rdx
	movq	%rdx, (%rax)
	movq	8+instruction_set(%rip), %rax
	addq	$16, %rax
	leaq	ws_stack_copy(%rip), %rdx
	movq	%rdx, (%rax)
	movq	16+instruction_set(%rip), %rax
	addq	$8, %rax
	movl	$3, (%rax)
	movq	instruction_set(%rip), %rax
	addq	$24, %rax
	leaq	.LC5(%rip), %rdx
	movq	%rdx, (%rax)
	movq	8+instruction_set(%rip), %rax
	addq	$24, %rax
	leaq	ws_stack_swap(%rip), %rdx
	movq	%rdx, (%rax)
	movq	16+instruction_set(%rip), %rax
	addq	$12, %rax
	movl	$3, (%rax)
	movq	instruction_set(%rip), %rax
	addq	$32, %rax
	leaq	.LC6(%rip), %rdx
	movq	%rdx, (%rax)
	movq	8+instruction_set(%rip), %rax
	addq	$32, %rax
	leaq	ws_stack_discard(%rip), %rdx
	movq	%rdx, (%rax)
	movq	16+instruction_set(%rip), %rax
	addq	$16, %rax
	movl	$3, (%rax)
	movq	instruction_set(%rip), %rax
	addq	$40, %rax
	leaq	.LC7(%rip), %rdx
	movq	%rdx, (%rax)
	movq	8+instruction_set(%rip), %rax
	addq	$40, %rax
	leaq	ws_stack_slide(%rip), %rdx
	movq	%rdx, (%rax)
	movq	16+instruction_set(%rip), %rax
	addq	$20, %rax
	movl	$3, (%rax)
	movq	instruction_set(%rip), %rax
	addq	$48, %rax
	leaq	.LC8(%rip), %rdx
	movq	%rdx, (%rax)
	movq	8+instruction_set(%rip), %rax
	addq	$48, %rax
	leaq	ws_math_add(%rip), %rdx
	movq	%rdx, (%rax)
	movq	16+instruction_set(%rip), %rax
	addq	$24, %rax
	movl	$4, (%rax)
	movq	instruction_set(%rip), %rax
	addq	$56, %rax
	leaq	.LC9(%rip), %rdx
	movq	%rdx, (%rax)
	movq	8+instruction_set(%rip), %rax
	addq	$56, %rax
	leaq	ws_math_sub(%rip), %rdx
	movq	%rdx, (%rax)
	movq	16+instruction_set(%rip), %rax
	addq	$28, %rax
	movl	$4, (%rax)
	movq	instruction_set(%rip), %rax
	addq	$64, %rax
	leaq	.LC10(%rip), %rdx
	movq	%rdx, (%rax)
	movq	8+instruction_set(%rip), %rax
	addq	$64, %rax
	leaq	ws_math_mult(%rip), %rdx
	movq	%rdx, (%rax)
	movq	16+instruction_set(%rip), %rax
	addq	$32, %rax
	movl	$4, (%rax)
	movq	instruction_set(%rip), %rax
	addq	$72, %rax
	leaq	.LC11(%rip), %rdx
	movq	%rdx, (%rax)
	movq	8+instruction_set(%rip), %rax
	addq	$72, %rax
	leaq	ws_math_div(%rip), %rdx
	movq	%rdx, (%rax)
	movq	16+instruction_set(%rip), %rax
	addq	$36, %rax
	movl	$4, (%rax)
	movq	instruction_set(%rip), %rax
	addq	$80, %rax
	leaq	.LC12(%rip), %rdx
	movq	%rdx, (%rax)
	movq	8+instruction_set(%rip), %rax
	addq	$80, %rax
	leaq	ws_math_mod(%rip), %rdx
	movq	%rdx, (%rax)
	movq	16+instruction_set(%rip), %rax
	addq	$40, %rax
	movl	$4, (%rax)
	movq	instruction_set(%rip), %rax
	addq	$88, %rax
	leaq	.LC13(%rip), %rdx
	movq	%rdx, (%rax)
	movq	8+instruction_set(%rip), %rax
	addq	$88, %rax
	leaq	ws_heap_store(%rip), %rdx
	movq	%rdx, (%rax)
	movq	16+instruction_set(%rip), %rax
	addq	$44, %rax
	movl	$3, (%rax)
	movq	instruction_set(%rip), %rax
	addq	$96, %rax
	leaq	.LC14(%rip), %rdx
	movq	%rdx, (%rax)
	movq	8+instruction_set(%rip), %rax
	addq	$96, %rax
	leaq	ws_heap_retrieve(%rip), %rdx
	movq	%rdx, (%rax)
	movq	16+instruction_set(%rip), %rax
	addq	$48, %rax
	movl	$3, (%rax)
	movq	instruction_set(%rip), %rax
	addq	$104, %rax
	leaq	.LC15(%rip), %rdx
	movq	%rdx, (%rax)
	movq	8+instruction_set(%rip), %rax
	addq	$104, %rax
	leaq	ws_flow_mark(%rip), %rdx
	movq	%rdx, (%rax)
	movq	16+instruction_set(%rip), %rax
	addq	$52, %rax
	movl	$3, (%rax)
	movq	instruction_set(%rip), %rax
	addq	$112, %rax
	leaq	.LC16(%rip), %rdx
	movq	%rdx, (%rax)
	movq	8+instruction_set(%rip), %rax
	addq	$112, %rax
	leaq	ws_flow_call(%rip), %rdx
	movq	%rdx, (%rax)
	movq	16+instruction_set(%rip), %rax
	addq	$56, %rax
	movl	$3, (%rax)
	movq	instruction_set(%rip), %rax
	addq	$120, %rax
	leaq	.LC17(%rip), %rdx
	movq	%rdx, (%rax)
	movq	8+instruction_set(%rip), %rax
	addq	$120, %rax
	leaq	ws_flow_jump(%rip), %rdx
	movq	%rdx, (%rax)
	movq	16+instruction_set(%rip), %rax
	addq	$60, %rax
	movl	$3, (%rax)
	movq	instruction_set(%rip), %rax
	subq	$-128, %rax
	leaq	.LC18(%rip), %rdx
	movq	%rdx, (%rax)
	movq	8+instruction_set(%rip), %rax
	subq	$-128, %rax
	leaq	ws_flow_jz(%rip), %rdx
	movq	%rdx, (%rax)
	movq	16+instruction_set(%rip), %rax
	addq	$64, %rax
	movl	$3, (%rax)
	movq	instruction_set(%rip), %rax
	addq	$136, %rax
	leaq	.LC19(%rip), %rdx
	movq	%rdx, (%rax)
	movq	8+instruction_set(%rip), %rax
	addq	$136, %rax
	leaq	ws_flow_jn(%rip), %rdx
	movq	%rdx, (%rax)
	movq	16+instruction_set(%rip), %rax
	addq	$68, %rax
	movl	$3, (%rax)
	movq	instruction_set(%rip), %rax
	addq	$144, %rax
	leaq	.LC20(%rip), %rdx
	movq	%rdx, (%rax)
	movq	8+instruction_set(%rip), %rax
	addq	$144, %rax
	leaq	ws_flow_ret(%rip), %rdx
	movq	%rdx, (%rax)
	movq	16+instruction_set(%rip), %rax
	addq	$72, %rax
	movl	$3, (%rax)
	movq	instruction_set(%rip), %rax
	addq	$152, %rax
	leaq	.LC21(%rip), %rdx
	movq	%rdx, (%rax)
	movq	8+instruction_set(%rip), %rax
	addq	$152, %rax
	leaq	ws_flow_exit(%rip), %rdx
	movq	%rdx, (%rax)
	movq	16+instruction_set(%rip), %rax
	addq	$76, %rax
	movl	$3, (%rax)
	movq	instruction_set(%rip), %rax
	addq	$160, %rax
	leaq	.LC22(%rip), %rdx
	movq	%rdx, (%rax)
	movq	8+instruction_set(%rip), %rax
	addq	$160, %rax
	leaq	ws_io_outc(%rip), %rdx
	movq	%rdx, (%rax)
	movq	16+instruction_set(%rip), %rax
	addq	$80, %rax
	movl	$4, (%rax)
	movq	instruction_set(%rip), %rax
	addq	$168, %rax
	leaq	.LC23(%rip), %rdx
	movq	%rdx, (%rax)
	movq	8+instruction_set(%rip), %rax
	addq	$168, %rax
	leaq	ws_io_outn(%rip), %rdx
	movq	%rdx, (%rax)
	movq	16+instruction_set(%rip), %rax
	addq	$84, %rax
	movl	$4, (%rax)
	movq	instruction_set(%rip), %rax
	addq	$176, %rax
	leaq	.LC24(%rip), %rdx
	movq	%rdx, (%rax)
	movq	8+instruction_set(%rip), %rax
	addq	$176, %rax
	leaq	ws_io_inc(%rip), %rdx
	movq	%rdx, (%rax)
	movq	16+instruction_set(%rip), %rax
	addq	$88, %rax
	movl	$4, (%rax)
	movq	instruction_set(%rip), %rax
	addq	$184, %rax
	leaq	.LC25(%rip), %rdx
	movq	%rdx, (%rax)
	movq	8+instruction_set(%rip), %rax
	addq	$184, %rax
	leaq	ws_io_inn(%rip), %rdx
	movq	%rdx, (%rax)
	movq	16+instruction_set(%rip), %rax
	addq	$92, %rax
	movl	$4, (%rax)
	movl	$1, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE20:
	.size	create_instruction_set, .-create_instruction_set
	.globl	cleanup_instruction_set
	.type	cleanup_instruction_set, @function
cleanup_instruction_set:
.LFB21:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	8+instruction_set(%rip), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	instruction_set(%rip), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	16+instruction_set(%rip), %rax
	movq	%rax, %rdi
	call	free@PLT
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE21:
	.size	cleanup_instruction_set, .-cleanup_instruction_set
	.globl	locate_jump_labels
	.type	locate_jump_labels, @function
locate_jump_labels:
.LFB22:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$56, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -56(%rbp)
	movl	$0, -36(%rbp)
	leaq	.LC15(%rip), %rax
	movq	%rax, -24(%rbp)
	movl	$0, -28(%rbp)
	jmp	.L66
.L72:
	movl	-28(%rbp), %eax
	movslq	%eax, %rdx
	movq	-56(%rbp), %rax
	leaq	(%rdx,%rax), %rcx
	movq	-24(%rbp), %rax
	movl	$3, %edx
	movq	%rax, %rsi
	movq	%rcx, %rdi
	call	strncmp@PLT
	testl	%eax, %eax
	jne	.L67
	movl	-28(%rbp), %eax
	cltq
	leaq	-1(%rax), %rdx
	movq	-56(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$9, %al
	je	.L67
	movq	label_table(%rip), %rax
	movl	-36(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	leaq	(%rax,%rdx), %rbx
	movl	$1, %esi
	movl	$500, %edi
	call	calloc@PLT
	movq	%rax, (%rbx)
	movq	(%rbx), %rax
	testq	%rax, %rax
	je	.L68
	addl	$3, -28(%rbp)
	movl	$0, -32(%rbp)
	jmp	.L69
.L70:
	movl	-28(%rbp), %edx
	movl	-32(%rbp), %eax
	addl	%edx, %eax
	movslq	%eax, %rdx
	movq	-56(%rbp), %rax
	addq	%rdx, %rax
	movq	label_table(%rip), %rdx
	movl	-36(%rbp), %ecx
	movslq	%ecx, %rcx
	salq	$3, %rcx
	addq	%rcx, %rdx
	movq	(%rdx), %rcx
	movl	-32(%rbp), %edx
	movslq	%edx, %rdx
	addq	%rcx, %rdx
	movzbl	(%rax), %eax
	movb	%al, (%rdx)
	addl	$1, -32(%rbp)
.L69:
	movl	-28(%rbp), %edx
	movl	-32(%rbp), %eax
	addl	%edx, %eax
	movslq	%eax, %rdx
	movq	-56(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$10, %al
	jne	.L70
	movl	-32(%rbp), %eax
	addl	%eax, -28(%rbp)
	movq	8+label_table(%rip), %rax
	movl	-36(%rbp), %edx
	movslq	%edx, %rdx
	salq	$2, %rdx
	addq	%rdx, %rax
	movl	-28(%rbp), %edx
	addl	$1, %edx
	movl	%edx, (%rax)
	addl	$1, -36(%rbp)
	jmp	.L67
.L68:
	movl	$0, %eax
	jmp	.L71
.L67:
	addl	$1, -28(%rbp)
.L66:
	movl	-28(%rbp), %eax
	movslq	%eax, %rdx
	movq	-56(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L72
	movl	-36(%rbp), %eax
	movl	%eax, 16+label_table(%rip)
	movl	$1, %eax
.L71:
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE22:
	.size	locate_jump_labels, .-locate_jump_labels
	.globl	add_ret_addr
	.type	add_ret_addr, @function
add_ret_addr:
.LFB23:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L74
.L76:
	addl	$1, -4(%rbp)
.L74:
	cmpl	$19, -4(%rbp)
	jg	.L75
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	instruction_index(%rip), %rax
	movq	(%rdx,%rax), %rax
	testq	%rax, %rax
	jne	.L76
.L75:
	cmpl	$19, -4(%rbp)
	jg	.L77
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rcx
	leaq	instruction_index(%rip), %rdx
	movq	-24(%rbp), %rax
	movq	%rax, (%rcx,%rdx)
	movl	$1, %eax
	jmp	.L78
.L77:
	movl	$0, %eax
.L78:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE23:
	.size	add_ret_addr, .-add_ret_addr
	.globl	get_last_ret_addr
	.type	get_last_ret_addr, @function
get_last_ret_addr:
.LFB24:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$19, -12(%rbp)
	jmp	.L80
.L82:
	subl	$1, -12(%rbp)
.L80:
	movl	-12(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	instruction_index(%rip), %rax
	movq	(%rdx,%rax), %rax
	testq	%rax, %rax
	jne	.L81
	cmpl	$0, -12(%rbp)
	jne	.L82
.L81:
	movl	-12(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	instruction_index(%rip), %rax
	movq	(%rdx,%rax), %rax
	movq	%rax, -8(%rbp)
	movl	-12(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	instruction_index(%rip), %rax
	movq	$0, (%rdx,%rax)
	movq	-8(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE24:
	.size	get_last_ret_addr, .-get_last_ret_addr
	.globl	step_through_program
	.type	step_through_program, @function
step_through_program:
.LFB25:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	jmp	.L85
.L91:
	movl	$0, -4(%rbp)
	jmp	.L86
.L89:
	movq	16+instruction_set(%rip), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$2, %rdx
	addq	%rdx, %rax
	movl	(%rax), %eax
	movslq	%eax, %rdx
	movq	instruction_set(%rip), %rax
	movl	-4(%rbp), %ecx
	movslq	%ecx, %rcx
	salq	$3, %rcx
	addq	%rcx, %rax
	movq	(%rax), %rax
	movq	current_instruction_index(%rip), %rcx
	movq	%rcx, %rsi
	movq	-24(%rbp), %rcx
	addq	%rsi, %rcx
	movq	%rax, %rsi
	movq	%rcx, %rdi
	call	strncmp@PLT
	testl	%eax, %eax
	jne	.L87
	movq	8+instruction_set(%rip), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rdx
	movq	16+instruction_set(%rip), %rax
	movl	-4(%rbp), %ecx
	movslq	%ecx, %rcx
	salq	$2, %rcx
	addq	%rcx, %rax
	movl	(%rax), %eax
	movq	current_instruction_index(%rip), %rcx
	movq	%rcx, %rsi
	movq	-24(%rbp), %rcx
	addq	%rsi, %rcx
	movl	%eax, %esi
	movq	%rcx, %rdi
	call	*%rdx
	jmp	.L88
.L87:
	addl	$1, -4(%rbp)
.L86:
	cmpl	$23, -4(%rbp)
	jle	.L89
.L88:
	cmpl	$24, -4(%rbp)
	jne	.L85
	movq	current_instruction_index(%rip), %rax
	addq	$1, %rax
	movq	%rax, current_instruction_index(%rip)
	call	getchar@PLT
.L85:
	movq	current_instruction_index(%rip), %rax
	cmpq	$-1, %rax
	je	.L93
	movq	current_instruction_index(%rip), %rax
	movq	%rax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L91
	nop
.L93:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE25:
	.size	step_through_program, .-step_through_program
	.globl	convert_ws_to_number
	.type	convert_ws_to_number, @function
convert_ws_to_number:
.LFB26:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	$0, -8(%rbp)
	cmpq	$0, -24(%rbp)
	je	.L95
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	subl	$1, %eax
	movl	%eax, -16(%rbp)
	movl	$0, -12(%rbp)
	jmp	.L96
.L98:
	movl	-16(%rbp), %eax
	movslq	%eax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$9, %al
	jne	.L97
	movl	-12(%rbp), %eax
	movl	$1, %edx
	movl	%eax, %ecx
	sall	%cl, %edx
	movl	%edx, %eax
	cltq
	addq	%rax, -8(%rbp)
.L97:
	subl	$1, -16(%rbp)
	addl	$1, -12(%rbp)
.L96:
	cmpl	$0, -16(%rbp)
	jg	.L98
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$9, %al
	jne	.L95
	negq	-8(%rbp)
.L95:
	movq	-8(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE26:
	.size	convert_ws_to_number, .-convert_ws_to_number
	.globl	retrieve_label_or_number
	.type	retrieve_label_or_number, @function
retrieve_label_or_number:
.LFB27:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movl	$1, %esi
	movl	$501, %edi
	call	calloc@PLT
	movq	%rax, %rdx
	movq	-32(%rbp), %rax
	movq	%rdx, (%rax)
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L101
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	-24(%rbp), %rcx
	movl	$500, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	strncpy@PLT
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movl	$10, %esi
	movq	%rax, %rdi
	call	strchr@PLT
	movq	%rax, -8(%rbp)
	cmpq	$0, -8(%rbp)
	je	.L102
	movq	-8(%rbp), %rax
	movb	$0, (%rax)
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	jmp	.L103
.L102:
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	free@PLT
.L101:
	movl	$0, %eax
.L103:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE27:
	.size	retrieve_label_or_number, .-retrieve_label_or_number
	.globl	ws_stack_push
	.type	ws_stack_push, @function
ws_stack_push:
.LFB28:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movl	%esi, -44(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	$0, -16(%rbp)
	movl	$0, -20(%rbp)
	movl	-44(%rbp), %eax
	movslq	%eax, %rdx
	movq	-40(%rbp), %rax
	addq	%rax, %rdx
	leaq	-16(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	retrieve_label_or_number
	movl	%eax, -20(%rbp)
	cmpl	$0, -20(%rbp)
	je	.L108
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	convert_ws_to_number
	movq	%rax, %rdi
	call	stack_push
	movl	-44(%rbp), %edx
	movl	-20(%rbp), %eax
	addl	%edx, %eax
	addl	$1, %eax
	movslq	%eax, %rdx
	movq	current_instruction_index(%rip), %rax
	addq	%rdx, %rax
	movq	%rax, current_instruction_index(%rip)
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	nop
.L108:
	nop
	movq	-8(%rbp), %rax
	subq	%fs:40, %rax
	je	.L107
	call	__stack_chk_fail@PLT
.L107:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE28:
	.size	ws_stack_push, .-ws_stack_push
	.globl	ws_stack_dup
	.type	ws_stack_dup, @function
ws_stack_dup:
.LFB29:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	$0, %edi
	call	stack_peak
	movq	%rax, %rdi
	call	stack_push
	movl	-12(%rbp), %eax
	movslq	%eax, %rdx
	movq	current_instruction_index(%rip), %rax
	addq	%rdx, %rax
	movq	%rax, current_instruction_index(%rip)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE29:
	.size	ws_stack_dup, .-ws_stack_dup
	.globl	ws_stack_copy
	.type	ws_stack_copy, @function
ws_stack_copy:
.LFB30:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movl	%esi, -44(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	$0, -16(%rbp)
	movl	$0, -20(%rbp)
	movl	-44(%rbp), %eax
	movslq	%eax, %rdx
	movq	-40(%rbp), %rax
	addq	%rax, %rdx
	leaq	-16(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	retrieve_label_or_number
	movl	%eax, -20(%rbp)
	cmpl	$0, -20(%rbp)
	je	.L112
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	convert_ws_to_number
	movl	%eax, %edi
	call	stack_peak
	movq	%rax, %rdi
	call	stack_push
	movl	-44(%rbp), %edx
	movl	-20(%rbp), %eax
	addl	%edx, %eax
	addl	$1, %eax
	movslq	%eax, %rdx
	movq	current_instruction_index(%rip), %rax
	addq	%rdx, %rax
	movq	%rax, current_instruction_index(%rip)
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	jmp	.L111
.L112:
	movl	-44(%rbp), %eax
	movslq	%eax, %rdx
	movq	current_instruction_index(%rip), %rax
	addq	%rdx, %rax
	movq	%rax, current_instruction_index(%rip)
	nop
.L111:
	movq	-8(%rbp), %rax
	subq	%fs:40, %rax
	je	.L115
	call	__stack_chk_fail@PLT
.L115:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE30:
	.size	ws_stack_copy, .-ws_stack_copy
	.globl	ws_stack_swap
	.type	ws_stack_swap, @function
ws_stack_swap:
.LFB31:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	call	stack_pop
	movq	%rax, -16(%rbp)
	call	stack_pop
	movq	%rax, -8(%rbp)
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	stack_push
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	stack_push
	movl	-28(%rbp), %eax
	movslq	%eax, %rdx
	movq	current_instruction_index(%rip), %rax
	addq	%rdx, %rax
	movq	%rax, current_instruction_index(%rip)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE31:
	.size	ws_stack_swap, .-ws_stack_swap
	.globl	ws_stack_discard
	.type	ws_stack_discard, @function
ws_stack_discard:
.LFB32:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	call	stack_pop
	movl	-12(%rbp), %eax
	movslq	%eax, %rdx
	movq	current_instruction_index(%rip), %rax
	addq	%rdx, %rax
	movq	%rax, current_instruction_index(%rip)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE32:
	.size	ws_stack_discard, .-ws_stack_discard
	.globl	ws_stack_slide
	.type	ws_stack_slide, @function
ws_stack_slide:
.LFB33:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movl	%esi, -44(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	call	stack_pop
	movq	%rax, -16(%rbp)
	movl	$0, -28(%rbp)
	movq	$0, -24(%rbp)
	movl	-44(%rbp), %eax
	movslq	%eax, %rdx
	movq	-40(%rbp), %rax
	addq	%rax, %rdx
	leaq	-24(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	retrieve_label_or_number
	movl	%eax, -28(%rbp)
	cmpl	$0, -28(%rbp)
	je	.L121
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	convert_ws_to_number
	movl	%eax, -32(%rbp)
	jmp	.L122
.L123:
	call	stack_pop
	subl	$1, -32(%rbp)
.L122:
	cmpl	$0, -32(%rbp)
	jg	.L123
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	stack_push
	movl	-44(%rbp), %edx
	movl	-28(%rbp), %eax
	addl	%edx, %eax
	addl	$1, %eax
	movslq	%eax, %rdx
	movq	current_instruction_index(%rip), %rax
	addq	%rdx, %rax
	movq	%rax, current_instruction_index(%rip)
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	jmp	.L120
.L121:
	movl	-44(%rbp), %eax
	movslq	%eax, %rdx
	movq	current_instruction_index(%rip), %rax
	addq	%rdx, %rax
	movq	%rax, current_instruction_index(%rip)
	nop
.L120:
	movq	-8(%rbp), %rax
	subq	%fs:40, %rax
	je	.L126
	call	__stack_chk_fail@PLT
.L126:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE33:
	.size	ws_stack_slide, .-ws_stack_slide
	.globl	ws_math_add
	.type	ws_math_add, @function
ws_math_add:
.LFB34:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	call	stack_pop
	movq	%rax, -16(%rbp)
	call	stack_pop
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rdx
	movq	-16(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, %rdi
	call	stack_push
	movl	-28(%rbp), %eax
	movslq	%eax, %rdx
	movq	current_instruction_index(%rip), %rax
	addq	%rdx, %rax
	movq	%rax, current_instruction_index(%rip)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE34:
	.size	ws_math_add, .-ws_math_add
	.globl	ws_math_sub
	.type	ws_math_sub, @function
ws_math_sub:
.LFB35:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	call	stack_pop
	movq	%rax, -16(%rbp)
	call	stack_pop
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	subq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	stack_push
	movl	-28(%rbp), %eax
	movslq	%eax, %rdx
	movq	current_instruction_index(%rip), %rax
	addq	%rdx, %rax
	movq	%rax, current_instruction_index(%rip)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE35:
	.size	ws_math_sub, .-ws_math_sub
	.globl	ws_math_mult
	.type	ws_math_mult, @function
ws_math_mult:
.LFB36:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	call	stack_pop
	movq	%rax, -16(%rbp)
	call	stack_pop
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	imulq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	stack_push
	movl	-28(%rbp), %eax
	movslq	%eax, %rdx
	movq	current_instruction_index(%rip), %rax
	addq	%rdx, %rax
	movq	%rax, current_instruction_index(%rip)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE36:
	.size	ws_math_mult, .-ws_math_mult
	.globl	ws_math_div
	.type	ws_math_div, @function
ws_math_div:
.LFB37:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	call	stack_pop
	movq	%rax, -16(%rbp)
	call	stack_pop
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	cqto
	idivq	-16(%rbp)
	movq	%rax, %rdi
	call	stack_push
	movl	-28(%rbp), %eax
	movslq	%eax, %rdx
	movq	current_instruction_index(%rip), %rax
	addq	%rdx, %rax
	movq	%rax, current_instruction_index(%rip)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE37:
	.size	ws_math_div, .-ws_math_div
	.globl	ws_math_mod
	.type	ws_math_mod, @function
ws_math_mod:
.LFB38:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	call	stack_pop
	movq	%rax, -16(%rbp)
	call	stack_pop
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	cqto
	idivq	-16(%rbp)
	movq	%rdx, %rax
	movq	%rax, %rdi
	call	stack_push
	movl	-28(%rbp), %eax
	movslq	%eax, %rdx
	movq	current_instruction_index(%rip), %rax
	addq	%rdx, %rax
	movq	%rax, current_instruction_index(%rip)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE38:
	.size	ws_math_mod, .-ws_math_mod
	.globl	ws_heap_store
	.type	ws_heap_store, @function
ws_heap_store:
.LFB39:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	call	stack_pop
	movq	%rax, -16(%rbp)
	call	stack_pop
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rdx
	movq	-16(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	heap_put
	movl	-28(%rbp), %eax
	movslq	%eax, %rdx
	movq	current_instruction_index(%rip), %rax
	addq	%rdx, %rax
	movq	%rax, current_instruction_index(%rip)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE39:
	.size	ws_heap_store, .-ws_heap_store
	.globl	ws_heap_retrieve
	.type	ws_heap_retrieve, @function
ws_heap_retrieve:
.LFB40:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	call	stack_pop
	movq	%rax, %rdi
	call	heap_get
	movq	%rax, %rdi
	call	stack_push
	movl	-12(%rbp), %eax
	movslq	%eax, %rdx
	movq	current_instruction_index(%rip), %rax
	addq	%rdx, %rax
	movq	%rax, current_instruction_index(%rip)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE40:
	.size	ws_heap_retrieve, .-ws_heap_retrieve
	.globl	ws_flow_mark
	.type	ws_flow_mark, @function
ws_flow_mark:
.LFB41:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	movl	$1, -4(%rbp)
	jmp	.L142
.L143:
	addl	$1, -4(%rbp)
.L142:
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$10, %al
	jne	.L143
	movl	-4(%rbp), %eax
	addl	$1, %eax
	movslq	%eax, %rdx
	movq	current_instruction_index(%rip), %rax
	addq	%rdx, %rax
	movq	%rax, current_instruction_index(%rip)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE41:
	.size	ws_flow_mark, .-ws_flow_mark
	.globl	ws_flow_call
	.type	ws_flow_call, @function
ws_flow_call:
.LFB42:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movl	%esi, -44(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$0, -20(%rbp)
	movl	-44(%rbp), %eax
	movslq	%eax, %rdx
	movq	-40(%rbp), %rax
	addq	%rax, %rdx
	leaq	-16(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	retrieve_label_or_number
	movl	%eax, -20(%rbp)
	cmpl	$0, -20(%rbp)
	je	.L146
	movl	-44(%rbp), %eax
	movslq	%eax, %rdx
	movq	current_instruction_index(%rip), %rax
	addq	%rax, %rdx
	movl	-20(%rbp), %eax
	cltq
	addq	%rdx, %rax
	addq	$1, %rax
	movq	%rax, %rdi
	call	add_ret_addr
	testb	%al, %al
	je	.L147
	movl	-44(%rbp), %edx
	movq	-40(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	ws_flow_jump
.L147:
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	jmp	.L145
.L146:
	movl	-44(%rbp), %eax
	movslq	%eax, %rdx
	movq	current_instruction_index(%rip), %rax
	addq	%rdx, %rax
	movq	%rax, %rdi
	call	add_ret_addr
	nop
.L145:
	movq	-8(%rbp), %rax
	subq	%fs:40, %rax
	je	.L150
	call	__stack_chk_fail@PLT
.L150:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE42:
	.size	ws_flow_call, .-ws_flow_call
	.globl	ws_flow_jump
	.type	ws_flow_jump, @function
ws_flow_jump:
.LFB43:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movl	%esi, -44(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	-44(%rbp), %eax
	movslq	%eax, %rdx
	movq	-40(%rbp), %rax
	addq	%rax, %rdx
	leaq	-16(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	retrieve_label_or_number
	testl	%eax, %eax
	je	.L152
	movl	$0, -20(%rbp)
	jmp	.L153
.L156:
	movq	-16(%rbp), %rdx
	movq	label_table(%rip), %rax
	movl	-20(%rbp), %ecx
	movslq	%ecx, %rcx
	salq	$3, %rcx
	addq	%rcx, %rax
	movq	(%rax), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L154
	movq	8+label_table(%rip), %rax
	movl	-20(%rbp), %edx
	movslq	%edx, %rdx
	salq	$2, %rdx
	addq	%rdx, %rax
	movl	(%rax), %eax
	cltq
	movq	%rax, current_instruction_index(%rip)
	jmp	.L155
.L154:
	addl	$1, -20(%rbp)
.L153:
	movl	16+label_table(%rip), %eax
	cmpl	%eax, -20(%rbp)
	jl	.L156
.L155:
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	jmp	.L151
.L152:
	movl	-44(%rbp), %eax
	movslq	%eax, %rdx
	movq	current_instruction_index(%rip), %rax
	addq	%rdx, %rax
	movq	%rax, current_instruction_index(%rip)
	nop
.L151:
	movq	-8(%rbp), %rax
	subq	%fs:40, %rax
	je	.L159
	call	__stack_chk_fail@PLT
.L159:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE43:
	.size	ws_flow_jump, .-ws_flow_jump
	.globl	ws_flow_jz
	.type	ws_flow_jz, @function
ws_flow_jz:
.LFB44:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movl	%esi, -44(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	call	stack_pop
	testq	%rax, %rax
	jne	.L161
	movl	-44(%rbp), %edx
	movq	-40(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	ws_flow_jump
	jmp	.L160
.L161:
	movl	-44(%rbp), %eax
	movslq	%eax, %rdx
	movq	-40(%rbp), %rax
	addq	%rax, %rdx
	leaq	-16(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	retrieve_label_or_number
	movl	%eax, -20(%rbp)
	cmpl	$0, -20(%rbp)
	je	.L163
	movl	-44(%rbp), %edx
	movl	-20(%rbp), %eax
	addl	%edx, %eax
	addl	$1, %eax
	movslq	%eax, %rdx
	movq	current_instruction_index(%rip), %rax
	addq	%rdx, %rax
	movq	%rax, current_instruction_index(%rip)
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	jmp	.L160
.L163:
	movl	-44(%rbp), %eax
	movslq	%eax, %rdx
	movq	current_instruction_index(%rip), %rax
	addq	%rdx, %rax
	movq	%rax, current_instruction_index(%rip)
	nop
.L160:
	movq	-8(%rbp), %rax
	subq	%fs:40, %rax
	je	.L165
	call	__stack_chk_fail@PLT
.L165:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE44:
	.size	ws_flow_jz, .-ws_flow_jz
	.globl	ws_flow_jn
	.type	ws_flow_jn, @function
ws_flow_jn:
.LFB45:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movl	%esi, -44(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	call	stack_pop
	testq	%rax, %rax
	jns	.L167
	movl	-44(%rbp), %edx
	movq	-40(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	ws_flow_jump
	jmp	.L166
.L167:
	movl	-44(%rbp), %eax
	movslq	%eax, %rdx
	movq	-40(%rbp), %rax
	addq	%rax, %rdx
	leaq	-16(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	retrieve_label_or_number
	movl	%eax, -20(%rbp)
	cmpl	$0, -20(%rbp)
	je	.L169
	movl	-44(%rbp), %edx
	movl	-20(%rbp), %eax
	addl	%edx, %eax
	addl	$1, %eax
	movslq	%eax, %rdx
	movq	current_instruction_index(%rip), %rax
	addq	%rdx, %rax
	movq	%rax, current_instruction_index(%rip)
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	jmp	.L166
.L169:
	movl	-44(%rbp), %eax
	movslq	%eax, %rdx
	movq	current_instruction_index(%rip), %rax
	addq	%rdx, %rax
	movq	%rax, current_instruction_index(%rip)
	nop
.L166:
	movq	-8(%rbp), %rax
	subq	%fs:40, %rax
	je	.L171
	call	__stack_chk_fail@PLT
.L171:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE45:
	.size	ws_flow_jn, .-ws_flow_jn
	.globl	ws_flow_ret
	.type	ws_flow_ret, @function
ws_flow_ret:
.LFB46:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	call	get_last_ret_addr
	movq	%rax, current_instruction_index(%rip)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE46:
	.size	ws_flow_ret, .-ws_flow_ret
	.globl	ws_flow_exit
	.type	ws_flow_exit, @function
ws_flow_exit:
.LFB47:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movq	$-1, current_instruction_index(%rip)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE47:
	.size	ws_flow_exit, .-ws_flow_exit
	.globl	ws_io_outc
	.type	ws_io_outc, @function
ws_io_outc:
.LFB48:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	call	stack_pop
	movl	%eax, %edi
	call	putchar@PLT
	movl	-12(%rbp), %eax
	movslq	%eax, %rdx
	movq	current_instruction_index(%rip), %rax
	addq	%rdx, %rax
	movq	%rax, current_instruction_index(%rip)
	nop
	leave
	.cfi_def_cfa 7, 8
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
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	call	stack_pop
	movq	%rax, %rsi
	leaq	.LC26(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush@PLT
	movl	-12(%rbp), %eax
	movslq	%eax, %rdx
	movq	current_instruction_index(%rip), %rax
	addq	%rdx, %rax
	movq	%rax, current_instruction_index(%rip)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE49:
	.size	ws_io_outn, .-ws_io_outn
	.globl	ws_io_inc
	.type	ws_io_inc, @function
ws_io_inc:
.LFB50:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	call	getchar@PLT
	movl	%eax, -4(%rbp)
	call	stack_pop
	movq	%rax, %rdx
	movl	-4(%rbp), %eax
	cltq
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	heap_put
	movl	-28(%rbp), %eax
	movslq	%eax, %rdx
	movq	current_instruction_index(%rip), %rax
	addq	%rdx, %rax
	movq	%rax, current_instruction_index(%rip)
	nop
	leave
	.cfi_def_cfa 7, 8
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
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$72, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -72(%rbp)
	movl	%esi, -76(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -24(%rbp)
	xorl	%eax, %eax
	leaq	-48(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC27(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	call	stack_pop
	movq	%rax, %rbx
	leaq	-56(%rbp), %rcx
	leaq	-48(%rbp), %rax
	movl	$10, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	strtoll@PLT
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	heap_put
	movl	-76(%rbp), %eax
	movslq	%eax, %rdx
	movq	current_instruction_index(%rip), %rax
	addq	%rdx, %rax
	movq	%rax, current_instruction_index(%rip)
	nop
	movq	-24(%rbp), %rax
	subq	%fs:40, %rax
	je	.L184
	call	__stack_chk_fail@PLT
.L184:
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE51:
	.size	ws_io_inn, .-ws_io_inn
	.section	.note.GNU-stack,"",@progbits
