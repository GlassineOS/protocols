# GlassineOS/protocols

The interfaces GlassineOS components speak to each other, in one place:

| File | Between | What |
|---|---|---|
| `glassine-ink-v1.xml` | the compositor (`sway`) and apps (the shell's GTK 3 module `glassine-ink` for GTK apps) | Wayland protocol: where on its surfaces the pen draws, and the brush the panel engine previews the stroke with |
| `glassine-epd-output-proto.h` | the compositor's panel output and `glassine-epdd-desktop` (`epd`) | socket protocol: frame buffers, changed rectangles, the cursor, the grey and gamma passes |

Both are versioned: a change is backwards compatible, or it raises the version and the
consumers handle both until the old version is dropped.

## Status

The consumers still carry their own copies (`GlassineOS/sway`, `GlassineOS/epd`, the
GTK module in `GlassineOS/shell`, the Rnote Ink patch in `GlassineOS/rnote`). They switch to this repository one at a time;
until then a change here goes to those copies in the same release.

## Check

    make check

runs `wayland-scanner` on the XML (client and server headers, glue code) and compiles
the generated code and `glassine-epd-output-proto.h` with `-Wall -Werror`.

## License

GPL-2.0-or-later (`LICENSE`).
