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
	wayland-scanner client-header glassine-handwriting-v1.xml $(O)/glassine-handwriting-v1-client.h
	wayland-scanner server-header glassine-handwriting-v1.xml $(O)/glassine-handwriting-v1-server.h
	wayland-scanner private-code glassine-handwriting-v1.xml $(O)/glassine-handwriting-v1.c
	$(CC) $(CFLAGS) -c $(O)/glassine-handwriting-v1.c -o $(O)/glassine-handwriting-v1.o
	printf '#include "glassine-ink-v1-client.h"\n#include "glassine-ink-v1-server.h"\n#include "glassine-handwriting-v1-client.h"\n#include "glassine-handwriting-v1-server.h"\n#include "../glassine-epd-output-proto.h"\n_Static_assert(GLASSINE_INK_SURFACE_V1_SET_CONTENT_SINCE_VERSION == 4 && GLASSINE_INK_SURFACE_V1_SET_BRUSH_OBJECT_SINCE_VERSION == 3, "since");\n_Static_assert(GLASSINE_INK_SURFACE_V1_CONTENT_PAGE == GLASSINE_EPD_HINT_PAGE && GLASSINE_INK_SURFACE_V1_CONTENT_MOTION == GLASSINE_EPD_HINT_MOTION && GLASSINE_INK_SURFACE_V1_CONTENT_NONE == 0, "the hint kinds are the content values");\n_Static_assert(!(GLASSINE_EPD_CAP_HINT & (GLASSINE_EPD_CAP_NEXT | GLASSINE_EPD_CAP_LUM | GLASSINE_EPD_CAP_GAMMA | GLASSINE_EPD_CAP_BAND)), "caps");\n_Static_assert(sizeof(struct glassine_epd_msg) == 36 + 16 * GLASSINE_EPD_MAXRECT, "the message layout stays");\nint main(void) { return 0; }\n' > $(O)/t.c
	$(CC) $(CFLAGS) -I$(O) $(O)/t.c -o $(O)/t
	@echo ok

clean:
	rm -rf $(O)

.PHONY: check clean
