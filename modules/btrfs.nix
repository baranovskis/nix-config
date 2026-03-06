{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.btrfs;
in {
  options.modules.btrfs = {
    enable = lib.mkEnableOption "Btrfs filesystem support";

    scrubInterval = lib.mkOption {
      type = lib.types.str;
      default = "monthly";
      description = "How often to scrub Btrfs filesystems";
    };

    mountpoints = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      example = ["/tank"];
      description = "Btrfs mountpoints to auto-scrub";
    };
  };

  config = lib.mkIf cfg.enable {
    boot.supportedFilesystems = ["btrfs"];

    services.btrfs.autoScrub = {
      enable = true;
      interval = cfg.scrubInterval;
      fileSystems = cfg.mountpoints;
    };

    environment.systemPackages = with pkgs; [
      btrfs-progs
    ];
  };
}
