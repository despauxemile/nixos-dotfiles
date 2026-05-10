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

  programs.kitty.font.size = 12;

  home.packages = with pkgs; [
    blender-hip
    godot
    kicad-small
    gimp
  ];

  services.hyprpaper.settings = {
    preload = [ "/home/milou/Pictures/wallpapers/butwhy.png" ];
    wallpaper = [ ",/home/milou/Pictures/wallpapers/butwhy.png" ];
  };
}
