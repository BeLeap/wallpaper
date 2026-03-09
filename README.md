# Wallpaper

Catppuccin Frappé wallpaper source and reproducible Nix build output.

## Build

```bash
nix build .#wallpaper
```

The default output is also available with:

```bash
nix build
```

## Outputs

After building, the `result` symlink contains:

- `share/wallpapers/wallpaper-frappe.svg`
- `share/wallpapers/wallpaper-frappe.png` (3840x2160)
