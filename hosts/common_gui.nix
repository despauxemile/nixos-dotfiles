{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;

  services.printing.enable = true;
}
