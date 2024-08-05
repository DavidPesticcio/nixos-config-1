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
  };
  services.acpid.enable = true;
  services.thermald.enable = true;
}
