{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./modules/base.nix
    ./modules/dev.nix
    ./modules/gui.nix
    ./modules/nvim.nix
    ./modules/uni.nix
  ];

  base.homeConfig = "xps";
}
