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

  # NVIDIA RTX 4060 Configuration
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  
  # Enable NVIDIA NVENC for hardware encoding (needed for RDP)
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
}
