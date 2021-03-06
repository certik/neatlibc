# for x86 build
#ARCH = x86
#CC = ncc
#AS = fasm

# for arm build
#ARCH = arm
#CC = ncc
#AS = neatas

# for x86_64 build
ARCH = x64
CC = ncc
AS = fasm

CFLAGS = -O2 -I.

all: start.o libc.a

%.o: %.s
	$(AS) $^ >/dev/null
%.o: %.c
	$(CC) -c $(CFLAGS) $^

OBJS1 = $(patsubst %.c,%.o,$(wildcard *.c))
OBJS2 = $(patsubst %.s,%.o,$(wildcard $(ARCH)/*.s))

start.o: $(ARCH)/start.o
	cp $(ARCH)/start.o .
libc.a: $(OBJS1) $(OBJS2)
	$(AR) rcs $@ $(OBJS1) $(OBJS2)

clean:
	rm -f *.o *.a x86/*.o arm/*.o x64/*.o
