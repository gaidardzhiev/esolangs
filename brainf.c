#include <stdio.h>
#include <stdlib.h>

#define MEM 65536

typedef struct {
	unsigned char *m;
	size_t s;
	size_t pointer;
} brainfunk;

void init_interpreter(brainfunk *interpreter)
{
	interpreter->m = (unsigned char *)calloc(MEM, sizeof(unsigned char));
	interpreter->s = MEM;
	interpreter->pointer = 0;
}

void expand_memory(brainfunk *interpreter)
{
	size_t new_size = interpreter->s * 2;
	interpreter->m = (unsigned char *)realloc(interpreter->m, new_size);
	if (interpreter->m == NULL) {
		fprintf(stderr, "memory allocation failed\n");
		exit(EXIT_FAILURE);
	}
	interpreter->s = new_size;
}

void interpret(const char *code)
{
	brainfunk interpreter;
	init_interpreter(&interpreter);
	const char *pc = code;
	size_t loop;

	while (*pc) {
		switch (*pc) {
		case '>':
			interpreter.pointer++;
			if (interpreter.pointer >= interpreter.s) {
				expand_memory(&interpreter);
			}
			break;
		case '<':
			if (interpreter.pointer == 0) {
				fprintf(stderr, "pointer underflow\n");
				exit(EXIT_FAILURE);
			}
			interpreter.pointer--;
			break;
		case '+':
			interpreter.m[interpreter.pointer]++;
			break;
		case '-':
			interpreter.m[interpreter.pointer]--;
			break;
		case '.':
			putchar(interpreter.m[interpreter.pointer]);
			break;
		case ',':
			interpreter.m[interpreter.pointer] = getchar();
			break;
		case '[':
			if (interpreter.m[interpreter.pointer] == 0) {
				loop = 1;
				while (loop > 0) {
					pc++;
					if (*pc == '[') loop++;
					if (*pc == ']') loop--;
				}
			}
			break;
		case ']':
			if (interpreter.m[interpreter.pointer] != 0) {
				loop = 1;
				while (loop > 0) {
					pc--;
					if (*pc == '[') loop--;
					if (*pc == ']') loop++;
				}
			}
			break;
		}
		pc++;
	}

	free(interpreter.m);
}

int main(int argc, char *argv[])
{
	if (argc < 2) {
		fprintf(stderr, "usage: %s <file.bf>\n", argv[0]);
		return EXIT_FAILURE;
	}

	FILE *file = fopen(argv[1], "r");
	if (!file) {
		perror("failed to open file");
		return EXIT_FAILURE;
	}

	fseek(file, 0, SEEK_END);
	long length = ftell(file);
	fseek(file, 0, SEEK_SET);

	char *code = (char *)malloc(length + 1);
	fread(code, 1, length, file);
	code[length] = '\0';

	fclose(file);

	interpret(code);
	free(code);

	return EXIT_SUCCESS;
}
