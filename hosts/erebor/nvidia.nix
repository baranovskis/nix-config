{
  config,
  lib,
  pkgs,
  username,
  ...
}:
{
  # NVIDIA kernel parameters
  boot.kernelParams = [
    # Since NVIDIA does not load kernel mode setting by default,
    # enabling it is required to make Wayland compositors function properly.
    "nvidia-drm.fbdev=1"
  ];

  # GPU drivers configuration
  services.xserver.videoDrivers = [ "nvidia" ];

  # NVIDIA RTX 4060 Configuration
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  # Enable NVIDIA GPU support in Docker
  hardware.nvidia-container-toolkit.enable = true;
}
