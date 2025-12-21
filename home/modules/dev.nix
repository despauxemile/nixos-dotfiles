{
  config,
  pkgs,
  lib,
  ...
}:

let
  settings = import ../settings.nix;
in
{
  home.packages = with pkgs; [
    # languages
    rustup
    gcc
    zig
    python313Packages.python
    python313Packages.pip

    # tools
    lazygit
    delta
    git
  ];

  programs.git = {
    enable = true;
    settings = {
      user.name = settings.git.name;
      user.email = settings.git.email;
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      line-numbers = true;
    };
  };
}
