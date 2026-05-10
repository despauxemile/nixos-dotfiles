{
  config,
  pkgs,
  pkgs-unstable,
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
    fd
    fzf
    nodejs

    # rust-analyzer
    tree-sitter
    lua-language-server
    nil
    zls
    clang-tools
    vscode-langservers-extracted
    typescript-language-server
    pkgs-unstable.ty
    tinymist
    # omnisharp-roslyn
  ];

  programs.neovim = {
    enable = true;
    package = pkgs-unstable.neovim-unwrapped;
  };

  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;
}
