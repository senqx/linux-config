# Amber Horizon

An original abstract wallpaper made for this repository, with flowing hill
shapes, navy and teal colors, and a soft amber glow. It was drawn directly as
SVG; it contains no traced image, stock assets, fonts, or external resources.

- `amber-horizon.svg`: editable vector source, 3840 × 2160 canvas.
- `amber-horizon.png`: 4K export for wallpaper tools such as Nitrogen.

Both files are covered by the repository's [MIT License](../LICENSE).
Copyright (c) 2026 senqx. Keep the copyright and license notice when
redistributing them.

## Edit and export

Edit the SVG in a text editor or an SVG editor. The gradients and individual
hill paths are separate elements, so you can change the palette and shapes.
To regenerate the PNG with librsvg's `rsvg-convert`:

```sh
rsvg-convert -o Wallpapers/amber-horizon.png Wallpapers/amber-horizon.svg
```

Run that command from the repository root. Use `-w 1920 -h 1080` for a smaller
export. The i3 startup configuration points to `~/Wallpapers/amber-horizon.png`;
see the [installation instructions](../README.md#wallpaper).
