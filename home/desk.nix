{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:
{
  imports = [
    ./modules/base.nix
    ./modules/dev.nix
    ./modules/gui.nix
    ./modules/nvim.nix
  ];

  base.homeConfig = "desk";

  programs.ghostty.settings.font-size = 12;

  home.packages = with pkgs; [
    blender
    godot
    kicad-small
    gimp
  ];

  services.hyprpaper.settings = {
    preload = [ "/home/milou/Pictures/wallpapers/butwhy.png" ];
    wallpaper = [
      {
        monitor = "";
        path = "/home/milou/Pictures/wallpapers/butwhy.png";
      }
    ];
  };
}
