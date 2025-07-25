{
  inputs,
  lib,
  pkgs,
  config,
  ...
}:
let
  virtLib = inputs.nixvirt.lib;
  vfioIds = [
    "10de:11b4"  # NVIDIA GTX 980
    "10de:0e0a"  # NVIDIA GTX 980 Audio
  ];
in
{
  imports = [
    inputs.nixvirt.nixosModules.default
  ];

  # VFIO Configuration
  boot.kernelParams = [
    # IOMMU settings based on CPU vendor
    "iommu=pt"
    "intel_iommu=on"
    
    # VFIO settings
    "rd.driver.pre=vfio_pci"
    "vfio_pci.disable_vga=1"
    "vfio_pci.ids=${builtins.concatStringsSep "," vfioIds}"
    
    # KVM optimizations
    "kvm.ignore_msrs=1"
    "kvm.report_ignored_msrs=0"
  ];

  boot.kernelModules = [ 
    # VFIO modules
    "vfio_virqfd" 
    "vfio_pci" 
    "vfio_iommu_type1" 
    "vfio"
    # Looking Glass module
    "kvmfr"
  ];

  boot.extraModprobeConfig = "options vfio-pci ids=${builtins.concatStringsSep "," vfioIds}";

  # Libvirt Configuration
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.stable.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
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

  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs.stable; [
    OVMFFull
    qemu
    qemu_kvm
    spice
    spice-gtk
    spice-protocol
    virtiofsd
    win-spice
    win-virtio
    looking-glass-client
  ];

  users.users.baranovskis = {
    extraGroups = [ "libvirtd" "kvm" ];
  };

  # Looking Glass configuration
  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 0660 baranovskis kvm -"
  ];

  services.udev.extraRules = ''
    SUBSYSTEM=="kvmfr", OWNER="baranovskis", GROUP="kvm", MODE="0660"
  '';
}