# make check: the XML through wayland-scanner, then the generated code and the header compiled
CC ?= cc
CFLAGS ?= -O2
CFLAGS += -Wall -Wextra -Werror
O = out

check:
	mkdir -p $(O)
	wayland-scanner client-header glassine-ink-v1.xml $(O)/glassine-ink-v1-client.h
	wayland-scanner server-header glassine-ink-v1.xml $(O)/glassine-ink-v1-server.h
	wayland-scanner private-code glassine-ink-v1.xml $(O)/glassine-ink-v1.c
	$(CC) $(CFLAGS) -c $(O)/glassine-ink-v1.c -o $(O)/glassine-ink-v1.o
	printf '#include "glassine-ink-v1-client.h"\n#include "glassine-ink-v1-server.h"\n#include "../glassine-epd-output-proto.h"\nint main(void) { return 0; }\n' > $(O)/t.c
	$(CC) $(CFLAGS) -I$(O) $(O)/t.c -o $(O)/t
	@echo ok

clean:
	rm -rf $(O)

.PHONY: check clean
