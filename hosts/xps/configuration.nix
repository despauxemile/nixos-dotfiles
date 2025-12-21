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
    ../common_gui.nix
  ];

  networking.hostName = "nix-xps";
}
