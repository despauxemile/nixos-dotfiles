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
      "steam"
      "steam-unwrapped"
    ];

  networking.hostName = "nix-desk";

  services.getty.autologinUser = "milou";

  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelParams = [ "usbcore.autosuspend=-1" ];
  boot.supportedFilesystems = [ "ntfs" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  programs.steam.enable = true;
  programs.gamemode.enable = true;

  services.xserver.videoDrivers = [ "amdgpu" ];

  # virtualisation.libvirtd.enable = true;

  hardware.bluetooth.enable = true;
  environment.systemPackages = with pkgs; [
    bluetui
    protonup-ng
    mangohud
    heroic
  ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/milou/.steam/root/compatibilitytools.d";
  };

  fileSystems."/mnt/wdblue" = {
    device = "/dev/disk/by-uuid/B0EA5E6DEA5E3038";
    fsType = "ntfs3";
    options = [
      "rw"
      "uid=1000"
      "nofail"
    ];
  };

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
