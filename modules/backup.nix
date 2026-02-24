# Restic backup service — parameterized for any host
{
  config,
  lib,
  ...
}: let
  cfg = config.modules.backup;
in {
  options.modules.backup = {
    enable = lib.mkEnableOption "Restic backup service";

    repository = lib.mkOption {
      type = lib.types.str;
      example = "/tank/backups";
      description = "Restic backup repository path";
    };

    passwordFile = lib.mkOption {
      type = lib.types.str;
      example = "/etc/restic-password";
      description = "Path to file containing the restic repository password";
    };

    paths = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      example = ["/home/user"];
      description = "Paths to back up";
    };

    exclude = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [
        # Cache and temporary files
        "/home/*/.cache"
        "/home/*/.local/share/Trash"
        "/home/*/Downloads"
        "*.tmp"
        ".tmp.*"

        # Development artifacts
        "**/node_modules"
        "**/.direnv"
        "**/target"
        "**/__pycache__"
        "**/.venv"

        # Large media that can be re-downloaded
        "/home/*/.local/share/Steam"
        "/home/*/.wine"
      ];
      description = "Paths to exclude from backup";
    };

    schedule = lib.mkOption {
      type = lib.types.str;
      default = "daily";
      description = "Systemd calendar expression for backup schedule";
    };

    pruneOpts = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [
        "--keep-daily 7"
        "--keep-weekly 4"
        "--keep-monthly 6"
      ];
      description = "Restic prune retention options";
    };
  };

  config = lib.mkIf cfg.enable {
    services.restic.backups.daily = {
      initialize = true;
      repository = cfg.repository;
      passwordFile = cfg.passwordFile;
      paths = cfg.paths;
      exclude = cfg.exclude;

      timerConfig = {
        OnCalendar = cfg.schedule;
        Persistent = true;
      };

      pruneOpts = cfg.pruneOpts;
    };
  };
}
