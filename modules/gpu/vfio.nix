# VFIO GPU passthrough + Looking Glass — parameterized for any CPU/config
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.gpu.vfio;
in {
  options.modules.gpu.vfio = {
    enable = lib.mkEnableOption "VFIO GPU passthrough";

    iommuType = lib.mkOption {
      type = lib.types.enum ["intel" "amd"];
      example = "intel";
      description = "CPU vendor for IOMMU (determines intel_iommu vs amd_iommu kernel param)";
    };

    lookingGlass = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable Looking Glass shared memory for near-native VM display";
      };

      sizeMB = lib.mkOption {
        type = lib.types.int;
        default = 128;
        description = "KVMFR shared memory size in MB (depends on guest resolution)";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    boot = {
      extraModulePackages =
        lib.optional cfg.lookingGlass.enable config.boot.kernelPackages.kvmfr;

      initrd.kernelModules =
        [
          "vfio_pci"
          "vfio"
          "vfio_iommu_type1"
        ]
        ++ lib.optional cfg.lookingGlass.enable "kvmfr";

      kernelParams =
        [
          # IOMMU settings based on CPU vendor
          "${cfg.iommuType}_iommu=on"
          "iommu=pt"

          "rd.driver.pre=vfio_pci"
          "vfio_pci.disable_vga=1"

          # KVM optimizations
          "kvm.ignore_msrs=1"
          "kvm.report_ignored_msrs=0"
        ]
        ++ lib.optional cfg.lookingGlass.enable
        "kvmfr.static_size_mb=${toString cfg.lookingGlass.sizeMB}";
    };

    # QEMU configuration for VFIO
    virtualisation.libvirtd.qemu.verbatimConfig = ''
      cgroup_device_acl = [
        "/dev/null", "/dev/full", "/dev/zero",
        "/dev/random", "/dev/urandom",
        "/dev/ptmx", "/dev/kvm"${lib.optionalString cfg.lookingGlass.enable '',
        "/dev/kvmfr0"''}
      ]
    '';

    # Looking Glass udev rules
    services.udev.extraRules = lib.mkIf cfg.lookingGlass.enable ''
      SUBSYSTEM=="kvmfr", GROUP="kvm", MODE="0660"
    '';

    environment.systemPackages =
      lib.optional cfg.lookingGlass.enable pkgs.looking-glass-client;
  };
}
