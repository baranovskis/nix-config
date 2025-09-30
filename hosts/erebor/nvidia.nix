{
  config,
  lib,
  pkgs,
  username,
  ...
}:
{
  # NVIDIA RTX 4060 Configuration
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;  # Use proprietary drivers (more stable)
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # NVIDIA kernel parameters
  boot.kernelParams = [
    "nvidia-drm.modeset=1"
  ];
}
