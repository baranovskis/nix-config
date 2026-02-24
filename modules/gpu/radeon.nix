# AMD Radeon VFIO passthrough — parameterized PCI device binding
{
  config,
  lib,
  ...
}: let
  cfg = config.modules.gpu.radeon;
in {
  options.modules.gpu.radeon = {
    enable = lib.mkEnableOption "AMD Radeon VFIO passthrough";

    pciIds = lib.mkOption {
      type = lib.types.str;
      example = "1002:67c7,1002:aaf0";
      description = "Comma-separated PCI vendor:device IDs to bind to vfio-pci";
    };

    powerManagement = lib.mkOption {
      type = lib.types.listOf (lib.types.submodule {
        options = {
          vendor = lib.mkOption {
            type = lib.types.str;
            example = "0x1002";
            description = "PCI vendor ID";
          };
          device = lib.mkOption {
            type = lib.types.str;
            example = "0x67c7";
            description = "PCI device ID";
          };
        };
      });
      default = [];
      description = "PCI devices to enable runtime power management on";
    };
  };

  config = lib.mkIf cfg.enable {
    # Bind GPU to VFIO at boot (prevent amdgpu from claiming it)
    boot.kernelParams = [
      "vfio-pci.ids=${cfg.pciIds}"
    ];

    # Enable runtime power management to prevent overheating when GPU is idle
    services.udev.extraRules = lib.concatMapStringsSep "\n" (dev: ''
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="${dev.vendor}", ATTR{device}=="${dev.device}", ATTR{power/control}="auto"
    '') cfg.powerManagement;
  };
}
