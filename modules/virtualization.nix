{
  config,
  lib,
  pkgs,
  username,
  ...
}: let
  cfg = config.modules.virtualization;
in {
  options.modules.virtualization = {
    enable = lib.mkEnableOption "QEMU/KVM/libvirt virtualization";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.stable.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
    };

    virtualisation.spiceUSBRedirection.enable = true;
    programs.virt-manager.enable = true;

    environment.systemPackages = with pkgs; [
      stable.OVMFFull
      virt-viewer
      stable.win-virtio
      stable.win-spice
    ];

    users.users.${username}.extraGroups = [ "libvirtd" "kvm" ];
  };
}
