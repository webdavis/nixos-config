{ pkgs, ...}:

{
  fonts = {
    # Set this to false for machines without a display server.
    fontconfig.enable = true;

    enableFontDir = true;
    enableGhostscriptFonts = true;
    font = with pkgs; [
      roboto
      roboto-mono
      roboto-slab
      vistafonts
      font-awesome-ttf
      joypixels
    ];
  };
}
