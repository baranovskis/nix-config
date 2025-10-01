{pkgs, ...}: {
  # Enable ZFS support
  boot.supportedFilesystems = ["zfs"];
  boot.zfs.forceImportRoot = false;

  # Required: Unique host ID for ZFS
  networking.hostId = "afeb27ee";

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