#include <stdio.h>

int main(void)
{
	FILE *fp;
	int value;

	fp = fopen("/tmp/file_write.txt", "wb");
	if(fp)
	{
		for (value = 48; value < 58; value++) 
		{
			fputc(value,fp);
		}
		fclose(fp);
	}
}
