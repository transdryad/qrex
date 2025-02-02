**QREX**

An executable, in a qr code.
This was my first foray into assembly, and I learned a lot. It was built using an existing guide for elf executable size reduction.
It displays some fun messages and is interactive (to an extent.) It runs only on x86_64 linux.

**Building**

build.sh - Requires nasm, qrencode, and base64.


Credits:

qrex32 is from [here](https://www.muppetlabs.com/~breadbox/software/tiny/teensy.html).
qrex64 is from [here](https://tuket.github.io/notes/asm/elf64_hello_world/). These two are just the smallest nice ones, (ie they exit with exit code 42, reachable with "./qrex.out; echo $?".)