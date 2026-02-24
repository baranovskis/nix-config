# Erebor — Desktop workstation (The Lonely Mountain)
#
# This file only contains host-specific settings and module parameters.
# All reusable logic lives in modules/.
{
  pkgs,
  ...
}: {
  imports = [
    ./hardware.nix

    # GPU stack
    ../../modules/gpu
    ../../modules/gpu/nvidia.nix
    ../../modules/gpu/radeon.nix
    ../../modules/gpu/vfio.nix

    # Features
    ../../modules/gaming.nix
    ../../modules/zfs.nix
    ../../modules/backup.nix
  ];

  # ── Host identity ──────────────────────────────────────
  networking.hostName = "erebor";

  # ── Module parameters ──────────────────────────────────

  # GPU: NVIDIA RTX 4060 (primary) + AMD Radeon WX 5100 (passthrough)
  modules.gpu.enable = true;

  modules.gpu.nvidia = {
    enable = true;
    open = true;
    containerToolkit = true; # GPU access in Docker/Podman
  };

  modules.gpu.radeon = {
    enable = true;
    pciIds = "1002:67c7,1002:aaf0"; # Radeon Pro WX 5100
    powerManagement = [
      {vendor = "0x1002"; device = "0x67c7";}
      {vendor = "0x1002"; device = "0xaaf0";}
    ];
  };

  modules.gpu.vfio = {
    enable = true;
    iommuType = "intel";
    lookingGlass = {
      enable = true;
      sizeMB = 128;
    };
  };

  # Gaming
  modules.gaming.enable = true;

  # Storage: ZFS pool "tank"
  modules.zfs = {
    enable = true;
    hostId = "afeb27ee";
    pools = ["tank"];
  };

  # Backup: Restic to ZFS pool
  modules.backup = {
    enable = true;
    repository = "/tank/backups";
    passwordFile = "/etc/restic-password";
    paths = [
      "/home/baranovskis"
      "/home/baranovskis/Development/nix-config"
    ];
  };

  # ── Boot configuration ─────────────────────────────────
  boot = {
    kernelPackages = pkgs.linuxPackages_6_12;

    kernelParams = [
      "acpi_rev_override=1"
      "quiet"
      "loglevel=3"
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
    ];

    consoleLogLevel = 0;
    initrd.verbose = false;

    plymouth.enable = true;

    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };
  };

  # ── Host-specific services ─────────────────────────────
  services.gvfs.enable = true;
  time.hardwareClockInLocalTime = true;
}
