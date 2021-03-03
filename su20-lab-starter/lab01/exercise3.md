1. **run < inputfile.txt**
```zsh
➜  lab01 git:(main) ✗ gdb -q ./interactive_hello
Reading symbols from ./interactive_hello...done.
(gdb) run < interactive_input.txt
Starting program: /media/psf/CS61C/su20-lab-starter/lab01/interactive_hello < interactive_input.txt
What's your name?
Hey, wangxingyu
I just really wanted to say hello to you.
I hope you have a wonderful day.
[Inferior 1 (process 24971) exited normally]
(gdb)
```