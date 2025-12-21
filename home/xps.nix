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
  ];

  base.homeConfig = "xps";
}
