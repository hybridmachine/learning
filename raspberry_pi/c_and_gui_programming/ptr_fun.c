#include <stdio.h>
void main (void)
{
 int a;
 int *ptr_to_a;
 ptr_to_a = &a;
 a = 5;
 printf ("The value of a is %lu\n", a);
 *ptr_to_a = 6;
 printf ("The value of a is %lu\n", a);
 printf ("The value of ptr_to_a is %lu\n", ptr_to_a);
 printf ("It stores the value %lu\n", *ptr_to_a);
 printf ("The address of a is %lu\n", &a);
}
