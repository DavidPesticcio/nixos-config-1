# home/default.nix
{
  config,
  pkgs,
  lib,
  nixosConfig,
  user,
  ...
}: {
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    sessionPath = ["$HOME/.local/bin"];

    preferXdgDirectories = true;
    activation = {
      createScreenshotsDir = config.lib.dag.entryAfter ["writeBoundary"] ''
        mkdir -p "${config.xdg.userDirs.pictures}/screenshots"
      '';
    };

    # Set session variables
    sessionVariables = {
      BROWSER = "firefox";
      EDITOR = "micro";
      TERMINAL = "kitty";
      XDG_DATA_DIRS = "$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share";
    };
  };

  # Settings Icons
  gtk = {
    enable = true;
    iconTheme.name = "Vimix-White";
    iconTheme.package = pkgs.vimix-icon-theme;
  };

  # Import additional configuration files
  imports = [
    ./others/xdg.nix
    ./others/programs.nix
    ./others/aliases.nix
    ./others/direnv.nix
    ./others/stylix.nix
    ./sway
  ];

  # Enable Home Manager
  programs.home-manager.enable = true;

  # Set the state version for Home Manager
  home.stateVersion = "24.05";
}