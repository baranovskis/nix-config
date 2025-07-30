{
  inputs,
  lib,
  pkgs,
  config,
  username,
  ...
}:
let
  virtLib = inputs.nixvirt.lib;
  vfioIds = [
    "1002:67c7"  # AMD Radeon Pro WX 5100
    "1002:aaf0"  # AMD Radeon Pro WX 5100 Audio
  ];
in
{
  imports = [
    inputs.nixvirt.nixosModules.default
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    extraModulePackages = [ pkgs.linuxPackages_zen.kvmfr ];

    initrd.kernelModules = [
      # VFIO modules
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
      
      # VFIO settings
      "rd.driver.pre=vfio_pci"
      "vfio_pci.disable_vga=1"
      "vfio_pci.ids=${builtins.concatStringsSep "," vfioIds}"
      
      # KVM optimizations
      "kvm.ignore_msrs=1"
      "kvm.report_ignored_msrs=0"

      # Looking Glass settings
      "kvmfr.static_size_mb=128"
    ];

    extraModprobeConfig = "options vfio-pci ids=${builtins.concatStringsSep "," vfioIds}";
  };

  # Libvirt Configuration
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.stable.qemu_kvm;
      runAsRoot = false;
      swtpm.enable = true;
      verbatimConfig = ''
        namespaces = []
        user = "${username}"
        group = "kvm"
        cgroup_device_acl = [
          "/dev/null", "/dev/full", "/dev/zero",
          "/dev/random", "/dev/urandom",
          "/dev/ptmx", "/dev/kvm",
          "/dev/kvmfr0"
        ]
      '';
      ovmf = {
        enable = true;
        packages = with pkgs.stable; [
          (OVMFFull.override {
            secureBoot = true;
            tpmSupport = true;
            httpSupport = true;
          }).fd
        ];
      };
    };
  };

  virtualisation.libvirt = {
    enable = true;
    connections."qemu:///system" = {
      networks = [
        {
          active = true;
          definition = virtLib.network.writeXML {
            uuid = "8e91d351-e902-4fce-99b6-e5ea88ac9b80";
            name = "vm-lan";
            forward = {
              mode = "nat";
              nat = {
                nat = {
                  port = {
                    start = 1024;
                    end = 65535;
                  };
                };
                ipv6 = false;
              };
            };
            bridge = {
              name = "virbr0";
              stp = true;
              delay = 0;
            };
            ipv6 = false;
            ip = {
              address = "192.168.122.1";
              netmask = "255.255.255.0";
              dhcp = {
                range = {
                  start = "192.168.122.100";
                  end = "192.168.122.254";
                };
              };
              hosts = [
                # Add any static host entries here if needed
              ];
            };
          };
        }
      ];
    };
  };

  virtualisation.spiceUSBRedirection.enable = true;

  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    stable.OVMFFull
    stable.qemu
    stable.qemu_kvm
    stable.spice
    stable.spice-gtk
    stable.spice-protocol
    stable.virtiofsd
    stable.win-spice
    stable.win-virtio
    looking-glass-client
    virt-viewer
    OVMF
  ];

  users.users.${username} = {
    extraGroups = [ "libvirtd" "kvm" ];
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="kvmfr", OWNER="${username}", GROUP="kvm", MODE="0666"
  '';
}