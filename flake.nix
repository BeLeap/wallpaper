{
  description = "Wallpaper";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    systems = ["x86_64-linux" "aarch64-darwin"];
    eachSystem = nixpkgs.lib.genAttrs systems;
  in {
    packages = eachSystem (system: let
      pkgs = import nixpkgs {inherit system;};
      wallpaperSrc = ./assets/wallpaper-frappe.svg;
      wallpaper = pkgs.stdenvNoCC.mkDerivation {
        pname = "wallpaper-frappe";
        version = "1.0.0";
        src = wallpaperSrc;
        nativeBuildInputs = [pkgs.librsvg];
        dontUnpack = true;
        installPhase = ''
          runHook preInstall
          mkdir -p "$out/share/wallpapers"
          cp "$src" "$out/share/wallpapers/wallpaper-frappe.svg"
          rsvg-convert \
            --width 3840 \
            --height 2160 \
            "$src" \
            --output "$out/share/wallpapers/wallpaper-frappe.png"
          runHook postInstall
        '';
        meta = {
          description = "Catppuccin Frappé wallpaper";
          platforms = systems;
        };
      };
    in {
      wallpaper = wallpaper;
      default = wallpaper;
    });
  };
}
