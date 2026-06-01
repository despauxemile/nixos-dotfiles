{
  config,
  lib,
  pkgs,
  ...
}:

{
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    default = "saved";
    device = "nodev";
    useOSProber = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  time.timeZone = "America/Toronto";

  i18n.defaultLocale = "en_US.UTF-8";

  users.extraGroups.plugdev = { };
  users.users.milou = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "libvirtd"
      "plugdev"
      "dialout"
    ];
    shell = pkgs.fish;
  };

  # packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    psmisc
  ];

  # programs
  programs.fish.enable = true;

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [
    pkgs.libX11
  ];

  services.thermald.enable = true;

  # flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "25.11";
}
