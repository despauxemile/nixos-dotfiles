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
    ./modules/nvim.nix
  ];

  base.homeConfig = "lab";
}
