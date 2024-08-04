# system/modules/services.nix
{
  pkgs,
  config,
  ...
}: {
  services = {
    # Enable OpenRGB for RGB lighting control
    hardware.openrgb.enable = true;

    # Add OpenRGB udev rules
    udev.packages = with pkgs; [openrgb];

    # Enable periodic TRIM for SSDs
    fstrim.enable = true;

    # Enable OpenSSH server
    openssh.enable = true;

    # Enable CUPS for printing
    printing.enable = true;

    logind = {
      lidSwitch = "sleep";
      extraConfig = ''
        HandlePowerKey=sleep
        HandleLidSwitch=sleep
        HandleLidSwitchExternalPower=sleep
      '';
    };

    # Enable Tailscale VPN
    tailscale = {
      enable = true;
      authKeyFile = config.age.secrets.sonic-tailscale-auth.path;
    };

    # Configure PipeWire for audio
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
