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

  networking.hostName = "nix-lab";

  # headless vm setup
  services.openssh.enable = true;
  services.qemuGuest.enable = true;
}
