{pkgs, ...}: {
  # Enable ZFS support
  boot.supportedFilesystems = ["zfs"];
  boot.zfs.forceImportRoot = false;

  # Required: Unique host ID for ZFS
  networking.hostId = "afeb27ee";

  # Disable deprecated udev-settle service that causes 2min boot delay
  systemd.services.systemd-udev-settle.enable = false;

  # ZFS services
  services.zfs.autoScrub.enable = true;
  services.zfs.autoScrub.interval = "monthly";
  services.zfs.autoSnapshot.enable = true;

  # Auto-import ZFS pools at boot
  boot.zfs.extraPools = ["tank"];

  # ZFS packages
  environment.systemPackages = with pkgs; [
    zfs
  ];
}