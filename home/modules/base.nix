{
  config,
  pkgs,
  lib,
  ...
}:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    "starship.toml" = "starship.toml";
    tmux = "tmux";
  };
in
{
  options.base = {
    homeConfig = lib.mkOption {
      type = lib.types.str;
      default = "lab";
    };
  };

  config = {

    home.username = "milou";
    home.homeDirectory = "/home/milou";
    home.stateVersion = "25.11";

    programs.fish.enable = true;
    programs.starship.enable = true;

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    home.shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#${config.base.homeConfig}";
    };

    home.packages = with pkgs; [
      bat
      tree
      file
      htop
      fastfetch
      typst
      zip
      unzip
      tmux
    ];

    xdg.configFile = builtins.mapAttrs (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    }) configs;

  };
}
