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

  environment.systemPackages = with pkgs; [
    brightnessctl
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    corefonts
    vista-fonts
  ];

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;

  services.printing.enable = true;
}
