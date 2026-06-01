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
    "waybar" = "waybar";
    "hypr/hyprland.lua" = "hypr/hyprland.lua";
  };
in
{
  home.packages = with pkgs; [
    wl-clipboard
    waybar
    wofi
    grim
    slurp
    hyprpicker
    nwg-displays
    hyprlock
    pavucontrol
    hyprpaper
  ];

  programs.fish = {
    loginShellInit = ''
      if test (tty) = /dev/tty1
          exec start-hyprland
      end
    '';
  };

  # to remove automatic hyprland.conf
  wayland.windowManager.hyprland.enable = false;

  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      ipc = true;
      preload = lib.mkDefault [ ];
      wallpaper = lib.mkDefault [ ];
    };
  };

  home.pointerCursor = {
    hyprcursor.enable = true;
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
  };

  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      font-size = lib.mkDefault 11;
      font-family = "FiraCode Nerd Font";
      theme = "TokyoNight Moon";
      background-opacity = 0.9;
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    colorScheme = "dark";
    gtk4 = {
      colorScheme = config.gtk.colorScheme;
      theme = config.gtk.theme;
    };
  };

  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";
    languagePacks = [ "en-US" ];
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      DisableFirefoxAccounts = true;
      DisableAccounts = true;
      DontCheckDefaultBrowser = true;
      DisplayBookmarksToolbar = "always";
      SearchBar = "unified";
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
  };

  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;

}
