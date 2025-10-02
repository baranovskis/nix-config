{
  lib,
  pkgs,
  config,
  username,
  ...
}:
{
  # VFIO and GPU Passthrough Configuration
  boot = {
    extraModulePackages = [ config.boot.kernelPackages.kvmfr ];

    initrd.kernelModules = [
      "vfio_pci"
      "vfio"
      "vfio_iommu_type1"

      # Looking Glass module
      "kvmfr"
    ];

    kernelParams = [
      # IOMMU settings based on CPU vendor
      "intel_iommu=on"
      "iommu=pt"

      "rd.driver.pre=vfio_pci"
      "vfio_pci.disable_vga=1"

      # KVM optimizations
      "kvm.ignore_msrs=1"
      "kvm.report_ignored_msrs=0"

      # Looking Glass settings
      "kvmfr.static_size_mb=128"
    ];
  };

  # QEMU configuration for VFIO
  virtualisation.libvirtd.qemu.verbatimConfig = ''
    cgroup_device_acl = [
      "/dev/null", "/dev/full", "/dev/zero",
      "/dev/random", "/dev/urandom",
      "/dev/ptmx", "/dev/kvm",
      "/dev/kvmfr0"
    ]
  '';

  # Looking Glass udev rules
  services.udev.extraRules = ''
    SUBSYSTEM=="kvmfr", OWNER="${username}", GROUP="kvm", MODE="0666"
  '';

  # Lookiong Glass client
  environment.systemPackages = with pkgs; [
    looking-glass-client
  ];
}