{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../common.nix
  ];

  networking.hostName = "nix-desk";

  services.getty.autologinUser = "milou";

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
}
