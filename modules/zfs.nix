# ZFS filesystem support — parameterized for any host
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.zfs;
in {
  options.modules.zfs = {
    enable = lib.mkEnableOption "ZFS filesystem support";

    hostId = lib.mkOption {
      type = lib.types.str;
      example = "afeb27ee";
      description = "Unique host ID required by ZFS (8-character hex string)";
    };

    pools = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      example = ["tank"];
      description = "ZFS pools to auto-import at boot";
    };

    scrubInterval = lib.mkOption {
      type = lib.types.str;
      default = "monthly";
      description = "How often to scrub ZFS pools";
    };
  };

  config = lib.mkIf cfg.enable {
    boot.supportedFilesystems = ["zfs"];
    boot.zfs.forceImportRoot = false;

    networking.hostId = cfg.hostId;

    # Disable deprecated udev-settle service that causes 2min boot delay
    systemd.services.systemd-udev-settle.enable = false;

    services.zfs.autoScrub = {
      enable = true;
      interval = cfg.scrubInterval;
    };
    services.zfs.autoSnapshot.enable = true;

    boot.zfs.extraPools = cfg.pools;

    environment.systemPackages = with pkgs; [
      zfs
    ];
  };
}
