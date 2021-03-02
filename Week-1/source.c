#include <stdio.h>
typedef struct node {
  int a;
  char b;
  struct node *c;
} node;

// A struct is always aligned to the largest type’s alignment requirements
typedef struct hello {
  int a;
  char b;
  char e;
  short c;
  char *d;
//  char e;
} hello;

void incrementPtr(int **p) {
  printf("  before incrementPtr : %p\n", *p);
  *p = *p + 1;
  printf("  after  incrementPtr : %p\n", *p);
  return ;
}

int main () {
  printf("type size: \n");
  printf("  sizeof(long)    = %ld\n", sizeof(long));
  printf("  sizeof(int)     = %ld\n", sizeof(int));
  printf("  sizeof(short)   = %ld\n", sizeof(short));
  printf("  sizeof(float)   = %ld\n", sizeof(float));
  printf("  sizeof(double)  = %ld\n", sizeof(double));
  printf("  sizeof(char)    = %ld\n", sizeof(char));
  printf("  sizeof(pointer) = %ld\n", sizeof(node *));
  printf("  sizeof(node)    = %ld\n", sizeof(node));
  printf("  sizeof(hello)   = %ld\n", sizeof(hello));

  printf("\nchar * & char []: \n");
  char *charpointer = "ABC";
  char chararray[] = {'A', 'B', 'C'};
  printf("  sizeof(char pointer)    = %ld\n", sizeof(charpointer));
  printf("  sizeof(char array)      = %ld\n", sizeof(chararray));

  printf("\nint []: \n");
  int intarray[] = {100, 101, 102, 103, 104};
  printf("  sizeof(int array)       = %ld\n", sizeof(intarray));

  printf("  1st element address   : %p\n", intarray);
  printf("  2nd element address   : %p\n", intarray + 1);
  printf("  3rd element address   : %p\n", intarray + 2);
  
  printf("  1st element in array  : %d\n", *intarray);
  printf("  2nd element in array  : %d\n", *(intarray + 1));
  printf("  3rd element in array  : %d\n", *(intarray + 2));

  printf("  1st element plus 100  : %d\n", *intarray + 100);
  printf("  2nd element plus 100  : %d\n", *(intarray + 1) + 100);
  printf("  3rd element plus 100  : %d\n", *(intarray + 2) + 100);

  printf("\npointer : \n");
  int *p;
  int arr[3];

  p = arr;
  printf("  p's address   : %p\n", &p);
  printf("  p's value     : %p\n", *&p);
  printf("  arr's address : %p\n", arr);

  *p = 1;
  *(p + 1) = 2;
  *(p + 2) = 3;
  printf("  arr: { %d %d %d }\n", arr[0], arr[1], arr[2]);

  p = arr;
  incrementPtr(&p);
  printf("  *p = %d\n", *p);

  return 0;
}
