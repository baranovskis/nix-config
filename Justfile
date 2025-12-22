# Show available commands
default:
    @just --list

# Build system configuration
system:
    sudo nixos-rebuild switch --flake .#erebor

# Build home-manager configuration
user:
    home-manager switch --flake . -b backup

# Update flake inputs
update:
    nix flake update

# Clean old generations
clean:
    sudo nix-collect-garbage --delete-older-than 7d
    home-manager expire-generations "-7 days"

# Run backup now
backup:
    sudo systemctl start restic-backups-daily && sudo journalctl -fu restic-backups-daily

# Check backup status
backup-status:
    sudo systemctl status restic-backups-daily

# List backup snapshots
backup-list:
    sudo restic -r /tank/backups --password-file /etc/restic-password snapshots

# Restore latest backup to specified directory
backup-restore target="/tmp/restore":
    sudo restic -r /tank/backups --password-file /etc/restic-password restore latest --target {{target}}