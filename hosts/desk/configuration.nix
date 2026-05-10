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

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "corefonts"
      "vista-fonts"
    ];

  networking.hostName = "nix-desk";

  services.getty.autologinUser = "milou";

  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelParams = [ "usbcore.autosuspend=-1" ];

  # virtualisation.libvirtd.enable = true;

  hardware.bluetooth.enable = true;
  environment.systemPackages = with pkgs; [
    bluetui
  ];

  # probe rs udev rules
  services.udev.packages = [
    pkgs.openocd
    (pkgs.writeTextFile {
      name = "probers_udev";
      text = builtins.readFile ../../config/69-probe-rs.rules;
      destination = "/etc/udev/rules.d/69-probe-rs.rules";
    })
  ];

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
    usbmon.enable = true;
    dumpcap.enable = true;
  };

  users.groups.wireshark.members = [ "milou" ];
}
