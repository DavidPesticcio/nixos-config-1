# configuration.nix
{
  inputs,
  pkgs,
  hostname,
  config,
  ...
}: {
  # Import all necessary configuration modules
  imports = [
    ./hardware-configuration.nix
    ./modules
  ];

  boot = {
    loader.efi.efiSysMountPoint = "/boot";
    consoleLogLevel = 0;
    kernelParams = ["quiet" "udev.log_priority=3"];
  };

  systemd.services.getty = {
    serviceConfig.ExecStart = [
      ""
      "${pkgs.systemd}/lib/systemd/systemd-getty-generator %I"
    ];
  };

  ## ! CONFIG HERE: options for proprietary modules ##########################
  # Define the config for the module networking
  networking = let
    wirelessNetworks = config.age.secrets."${hostname}-wireless-networks".path;
  in {
    hostName = hostname;
    networkmanager.wifi.backend = "iwd";
    wireless = {
      enable = true;
      iwd.enable = true;
      environmentFile = wirelessNetworks;
      userControlled.enable = true;
      dbusControlled = true;
      fallbackToWPA2 = true;
      interfaces = ["wlp3s0"];
      networks = {
        Farenet.psk = "@Farenet_PSK";
        Fredflat_5G.psk = "@Fredflat_5G_PSK";
        Fredflat_2G.psk = "@Fredflat_2G_PSK";
      };
    };
  };

  # Graphical environment configuration
  graphical = {
    xdefaults.enable = true; # Enable X-Server defaults (true by default)
    managers = {
      enable = true; # Enable graphical environment (false by default)

      # Choose one of the following (or none for default GNOME):
      # gnome.enable = true;
      # hyprland.enable = true;
      sway.enable = true;
      # i3.enable = true;
    };
  };
  ## ! END CONFIG #############################################################

  # Specify the NixOS release version
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken.
  system.stateVersion = "24.05";
}
