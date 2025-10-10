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
    "nvidia-drm.modeset=1"
  ];

  # Additional graphics packages
  hardware.graphics.extraPackages = with pkgs; [ 
    nvidia-vaapi-driver
    egl-wayland
  ];

  # Environment variables for NVIDIA
  environment.variables = {
    NVD_BACKEND = "direct";
    LIBVA_DRIVER_NAME = "nvidia";
  };


  # NVIDIA RTX 4060 Configuration
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
