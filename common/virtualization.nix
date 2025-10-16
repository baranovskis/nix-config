{
  lib,
  pkgs,
  config,
  username,
  ...
}:
{
  # Libvirt/KVM virtualization
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
      '';
    };
  };

  virtualisation.spiceUSBRedirection.enable = true;

  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    # UEFI firmware for VMs (supports Secure Boot, TPM)
    stable.OVMFFull

    # VM viewer application
    virt-viewer

    # Windows VM drivers (needed for GPU passthrough with Looking Glass)
    stable.win-virtio # VirtIO drivers for Windows guests
    stable.win-spice  # SPICE guest tools for Windows
  ];

  users.users.${username} = {
    extraGroups = [ "libvirtd" "kvm" ];
  };
}