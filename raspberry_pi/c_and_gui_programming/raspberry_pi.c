#include <stdio.h>
#define PI 3.14159
void main (void)
{
 float rad = 3;
 float circ = rad * 2 * PI;
 float area = rad * rad * PI;
 printf ("The circumference of a circle radius %f is %f\n", 
rad, circ);
 printf ("The area of a circle radius %f is %f\n", rad, area);
}
