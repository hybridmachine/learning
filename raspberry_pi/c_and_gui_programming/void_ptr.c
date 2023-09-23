#include <stdio.h>
void main (void)
{
 int intval = 255958283;
 void *vptr = &intval;
 char *cptr = (char *)vptr;
 printf ("The value at vptr as an int is %d\n", *((int *) vptr));
 printf ("The value at cptr as a char is %d\n", *cptr);
 printf ("The next value at cptr as a char is %d\n", *(cptr++));
 printf ("The next value at cptr as a char is %d\n", *(cptr++));
 printf ("The next value at cptr as a char is %d\n", *(cptr++));
}
