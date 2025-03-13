#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

#define EXPONENT_ALL_ONES 255 << 23
// Function to print bits of an unsigned integer in 32 bit float format
void print_bits(uint32_t num) {
	for (int i = 31; i >= 0; i--) {
		printf("%d", (num >> i) & 1);
		if (i == 31 || i == 23) {
			printf(" ");
		}
	}
	printf("\n");
}

void print_float_info(char *note, uint32_t float_mem)
{
	printf("++++++++++++++++++++++++++++\n");
	printf("%s\n\n", note);
	float float_val;
	memcpy(&float_val, &float_mem, sizeof(float));
	printf("Raw mem val is 0x%x\n", (uint32_t)float_mem);
	print_bits(float_mem);
	printf("\nFloat val is %g\n", float_val);
	printf("-----------------------------\n\n");
}

int main(int argc, char **argv) {

	printf("Size of float is %ld bytes\n", sizeof(float));
	
	uint32_t float_mem;
	float_mem = 0;
	print_float_info("\tfloat_mem = 0;", float_mem);

	float_mem = float_mem | 0x80000000;
	print_float_info("\tfloat_mem | 0x80000000;", float_mem);;

	float float_val = -0.0;
	memcpy(&float_mem, &float_val, sizeof(float));
	print_float_info("\tfloat float_val = -0.0;\n\tmemcpy(&float_mem, &float_val, sizeof(float));",float_mem);

	float_mem = 0 | EXPONENT_ALL_ONES;
	print_float_info("\tfloat_mem = 0 | EXPONENT_ALL_ONES;", float_mem);

	float_mem = 0x80000000 | EXPONENT_ALL_ONES;
	print_float_info("\t0x80000000 | EXPONENT_ALL_ONES;", float_mem);

	float_mem = 0x00000001;
	print_float_info("\t0x0000000F;", float_mem);
	
	for (int shift = 0; shift < 24; shift++) {
		char note[255];
		sprintf(note, "\t0x0000000F << %d", shift);
		float_mem = 0x0000000F << shift;
		print_float_info(note, float_mem);
	}

	float_val = 0.5;
	memcpy(&float_mem, &float_val, sizeof(float));
	print_float_info("\tfloat_val = 0.5;\n\tmemcpy(&float_mem, &float_val, sizeof(float));", float_mem);

	float_val = 0.15625;
	memcpy(&float_mem, &float_val, sizeof(float));
	print_float_info("\tfloat_val = 0.5;\n\tmemcpy(&float_mem, &float_val, sizeof(float));", float_mem);
	return 0;	
}
