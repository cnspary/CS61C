```c
// hello.c
#include <stdio.h>

int main(int argc, char* argv[]) {
    int i;
    int count = 0;
    int* p = &count;

    for (i = 0; i < 10; i++) {
        (*p)++; // Do you understand this line of code and all the other permutations of the operators? ;)
    }

    printf("executing file: %s\n", argv[0]);
    printf("first args    : %s\n", argv[1]);

    printf("Thanks for waddling through this program. Have a nice day.\n");
    return 0;
}
```
1. **set args arg1...**
``` zsh
➜  lab01 git:(main) ✗ gcc -g -o hello hello.c
➜  lab01 git:(main) ✗ ./hello args1
executing file: ./hello
first args    : args1
Thanks for waddling through this program. Have a nice day.

(gdb) set args args1
(gdb) run
executing file: /***/hello
first args    : args1
Thanks for waddling through this program. Have a nice day.
```

2. **b main**
```zsh
(gdb) b main
Breakpoint 1 at 0x5555555546e4: file hello.c, line 3.
```
3. **next**
```zsh
Breakpoint 1, main (argc=2, argv=0x7fffffffe468) at hello.c:3
3       int main(int argc, char* argv[]) {
(gdb) next
5           int count = 0;
```
4. **step**
5. **continue**
```zsh
Breakpoint 1, main (argc=1, argv=0x7fffffffe488) at hello.c:3
3       int main(int argc, char* argv[]) {
(gdb) c
Continuing.
```
6. **p**
```zsh
(gdb) p 1+2
$1 = 3
```
7. **display**
```zsh
Breakpoint 1, main (argc=1, argv=0x7fffffffe488) at hello.c:9
9               (*p)++; // Do you understand this line of code and all the other permutations of the operators? ;)
(gdb) display *p
1: *p = 0
(gdb) c
Continuing.

Breakpoint 1, main (argc=1, argv=0x7fffffffe488) at hello.c:9
9               (*p)++; // Do you understand this line of code and all the other permutations of the operators? ;)
1: *p = 1
(gdb)
Continuing.

Breakpoint 1, main (argc=1, argv=0x7fffffffe488) at hello.c:9
9               (*p)++; // Do you understand this line of code and all the other permutations of the operators? ;)
1: *p = 2
```
8. **info locals**
```zsh
(gdb) info locals
i = 2
count = 2
p = 0x7fffffffe388
```
9. **quit**