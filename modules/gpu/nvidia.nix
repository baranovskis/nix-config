# NVIDIA proprietary drivers — parameterized options
{
  config,
  lib,
  ...
}: let
  cfg = config.modules.gpu.nvidia;
in {
  options.modules.gpu.nvidia = {
    enable = lib.mkEnableOption "NVIDIA proprietary GPU drivers";

    open = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Use NVIDIA open-source kernel modules (recommended for Turing+)";
    };

    containerToolkit = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable NVIDIA container toolkit for GPU access in Docker/Podman";
    };
  };

  config = lib.mkIf cfg.enable {
    boot.kernelParams = [
      # Required for Wayland compositors with NVIDIA
      "nvidia-drm.fbdev=1"
    ];

    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      open = cfg.open;
      package = config.boot.kernelPackages.nvidiaPackages.production;
    };

    hardware.nvidia-container-toolkit.enable = cfg.containerToolkit;
  };
}
