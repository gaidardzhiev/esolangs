#include <stdio.h>
#include <stdlib.h>

#define MEM 65536

typedef struct {
	unsigned char *m;
	size_t s;
	size_t p;
} b;

void ii(b *i) {
	i->m = (unsigned char *)calloc(MEM, sizeof(unsigned char));
	i->s = MEM;
	i->p = 0;
}

void exm(b *i) {
	size_t ns = i->s * 2;
	i->m = (unsigned char *)realloc(i->m, ns);
	if (i->m == NULL) {
		fprintf(stderr, "memory allocation failed\n");
		exit(EXIT_FAILURE);
	}
	i->s = ns;
}

void p(const char *code) {
	b i;
	ii(&i);
	const char *pc = code;
	size_t loop;

	while (*pc) {
		switch (*pc) {
		case '>':
			i.p++;
			if (i.p >= i.s) {
				exm(&i);
			}
			break;
		case '<':
			if (i.p == 0) {
				fprintf(stderr, "pointer underflow\n");
				exit(EXIT_FAILURE);
			}
			i.p--;
			break;
		case '+':
			i.m[i.p]++;
			break;
		case '-':
			i.m[i.p]--;
			break;
		case '.':
			putchar(i.m[i.p]);
			break;
		case ',':
			i.m[i.p] = getchar();
			break;
		case '[':
			if (i.m[i.p] == 0) {
				loop = 1;
				while (loop > 0) {
					pc++;
					if (*pc == '[') loop++;
					if (*pc == ']') loop--;
				}
			}
			break;
		case ']':
			if (i.m[i.p] != 0) {
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

	free(i.m);
}

int main(int argc, char *argv[]) {
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
	p(code);
	free(code);
	return EXIT_SUCCESS;
}
