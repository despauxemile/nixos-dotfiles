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
      "nvidia-x11"
      "nvidia-settings"
      "corefonts"
      "vista-fonts"
    ];

  networking.hostName = "nix-xps";

  services.getty.autologinUser = "milou";

  services.fprintd.enable = true;

  hardware.bluetooth.enable = true;
  environment.systemPackages = with pkgs; [
    bluetui
  ];

  virtualisation.libvirtd.enable = true;

  boot.blacklistedKernelModules = [ "uvcvideo" ];

  # cisco vpn
  networking.networkmanager.plugins = [ pkgs.networkmanager-openconnect ];

  # probe rs udev rules
  services.udev.packages = [
    pkgs.openocd
    (pkgs.writeTextFile {
      name = "probers_udev";
      text = builtins.readFile ../../config/69-probe-rs.rules;
      destination = "/etc/udev/rules.d/69-probe-rs.rules";
    })
  ];

  # POWER
  powerManagement.powertop.enable = true;
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };

  # NVIDIA
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [
    "modesetting"
    "nvidia"
  ];
  hardware.nvidia = {
    open = true;
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
    modesetting.enable = true;
  };
}
