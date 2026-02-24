# Restic backup configuration for erebor
{ config, pkgs, ... }:

{
  services.restic.backups = {
    daily = {
      initialize = true;
      repository = "/tank/backups";
      passwordFile = "/etc/restic-password";

      paths = [
        "/home/baranovskis"
        "/home/baranovskis/Development/nix-config"
      ];

      exclude = [
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

      timerConfig = {
        OnCalendar = "daily";
        Persistent = true;
      };

      pruneOpts = [
        "--keep-daily 7"
        "--keep-weekly 4"
        "--keep-monthly 6"
      ];
    };
  };
}
