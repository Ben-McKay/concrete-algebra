/* A first program to see how to print things. */
#include <stdio.h>

int abs(int b)
{
	if (b<0)
		b=-b;
	return b;
}

int mod(int b, int c)
{
	int rem=b%c;
	if (rem<0)
		rem+=abs(c);
	return rem;
}

int gcd(int b, int c)
{
	while (c != 0) {
		int t;
		t=c;
		c=b%c;
		b=t;
	}	
	return abs(b);
}

unsigned int binary_gcd_unsigned(unsigned int u, unsigned int v)
{
  unsigned int shift;

  /* GCD(0,v) == v; GCD(u,0) == u, GCD(0,0) == 0 */
  if (u == 0) return v;
  if (v == 0) return u;
 
  /* Let shift := lg K, where K is the greatest power of 2
        dividing both u and v. */
  for (shift = 0; ((u | v) & 1) == 0; ++shift) {
         u >>= 1;
         v >>= 1;
  }
 
  while ((u & 1) == 0)
    u >>= 1;
 
  /* From here on, u is always odd. */
  do {
       /* remove all factors of 2 in v -- they are not common */
       /*   note: v is not zero, so while will terminate */
       while ((v & 1) == 0)  /* Loop X */
           v >>= 1;

       /* Now u and v are both odd. Swap if necessary so u <= v,
          then set v = v - u (which is even). For bignums, the
          swapping is just pointer movement, and the subtraction
          can be done in-place. */
       if (u > v) {
         unsigned int t = v; v = u; u = t;}  // Swap u and v.
       v = v - u;                       // Here v >= u.
     } while (v != 0);

  /* restore common factors of 2 */
  return u << shift;
}


int binary_gcd

int main(int argc, char **argv)
{
	printf("Hello, world.\n");
	int b;
	b=5;
	printf("The number called b has the value %d.\n",b);
	printf("gcd(-1,-1)=%d\n",gcd(-1,-1));
	return 0;
}
