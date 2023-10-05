#include <stdio.h>

int main(void)
{
	FILE *fp;
	int value;

	fp = fopen("/tmp/file_read.txt", "rb");
	if(fp)
	{
		while(1)
		{
			value = fgetc(fp);
			if (value == EOF) break;
			else printf("%c", value);
		}		
		fclose(fp);
	}
}
