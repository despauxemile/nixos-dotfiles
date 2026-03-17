{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    profiles.default.extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      enkia.tokyo-night
    ];
  };

  home.packages = with pkgs; [
    virt-manager
    dnsmasq
  ];
}
