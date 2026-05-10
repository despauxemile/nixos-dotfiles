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
    waybar = "waybar";
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
  ];

  programs.fish = {
    loginShellInit = ''
      if test (tty) = /dev/tty1
          exec hyprland
      end
    '';
  };

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      ${builtins.readFile ../../config/hypr/hyprland.conf}
    '';
  };

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

  programs.kitty = {
    enable = true;
    font = {
      name = "FiraCode Nerd Font";
      size = lib.mkDefault 11;
    };
    themeFile = "tokyo_night_moon";
    settings = {
      background_opacity = 0.9;
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    gtk3 = {
      extraConfig.gtk-application-prefer-dark-theme = true;
    };
    gtk4 = {
      extraConfig.gtk-application-prefer-dark-theme = true;
    };
  };

  programs.firefox = {
    enable = true;
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
