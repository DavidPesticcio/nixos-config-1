# system/modules/power-management.nix
{
  config,
  lib,
  ...
}: {
  # Enable Power Management
  powerManagement = {
    enable = true;
    cpuFreqGovernor = lib.mkDefault "ondemand";
    powertop.enable = false;
  };
  services.acpid.enable = true;
  services.thermald.enable = true;
}