# home/default.nix
{pkgs, ...}: let
  user = "fredamaral";
in {
  # Set up the home directory and environment variables
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    # Install GNOME shell extensions
    packages = with pkgs.gnomeExtensions; [
      space-bar
      gtile
      focus-changer
      appindicator
      dim-background-windows
    ];

    # Set default applications
    sessionVariables = {
      BROWSER = "firefox";
      EDITOR = "micro";
      TERMINAL = "kitty";
    };
  };

  # Import additional configuration files
  imports = [
    # WM
    ./gnome

    # Others
    ./xdg.nix
    ./programs.nix
    ./aliases.nix
    ./direnv.nix
  ];

  # Enable numlock on session start
  xsession.numlock.enable = true;

  # Enable Home Manager
  programs.home-manager.enable = true;

  # Set the state version for Home Manager
  home.stateVersion = "24.05";
}
