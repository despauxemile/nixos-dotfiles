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
    nvim = "nvim";
  };
in
{
  home.packages = with pkgs; [
    ripgrep
    fzf
    nodejs

    # rust-analyzer
    lua-language-server
    nil
    zls
    clang-tools
    vscode-langservers-extracted
    typescript-language-server
    pyright
    tinymist
    # omnisharp-roslyn
  ];

  programs.neovim = {
    enable = true;
  };

  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;
}
