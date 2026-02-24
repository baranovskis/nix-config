# Erebor — Desktop workstation (The Lonely Mountain)
#
# Host-specific hardware config lives here directly.
# Shared modules (gpu, gaming, zfs) are imported from modules/.
{
  config,
  pkgs,
  username,
  ...
}: {
  imports = [
    ./hardware.nix

    # Shared modules (reusable across hosts)
    ../../modules/gpu.nix
    ../../modules/gaming.nix
    ../../modules/zfs.nix
  ];

  # ── Host identity ──────────────────────────────────────
  networking.hostName = "erebor";

  # ── Shared modules ─────────────────────────────────────

  modules.gpu.enable = true;
  modules.gaming.enable = true;

  modules.zfs = {
    enable = true;
    hostId = "afeb27ee";
    pools = ["tank"];
  };

  # ── GPU: NVIDIA RTX 4060 (primary) ────────────────────

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  hardware.nvidia-container-toolkit.enable = true;

  # ── VFIO GPU passthrough + Looking Glass ───────────────

  virtualisation.libvirtd.qemu.verbatimConfig = ''
    cgroup_device_acl = [
      "/dev/null", "/dev/full", "/dev/zero",
      "/dev/random", "/dev/urandom",
      "/dev/ptmx", "/dev/kvm",
      "/dev/kvmfr0"
    ]
  '';

  environment.systemPackages = with pkgs; [
    looking-glass-client
  ];

  # ── Restic backup to ZFS pool ──────────────────────────

  services.restic.backups.daily = {
    initialize = true;
    repository = "/tank/backups";
    passwordFile = "/etc/restic-password";

    paths = [
      "/home/${username}"
      "/home/${username}/Development/nix-config"
    ];

    exclude = [
      "/home/*/.cache"
      "/home/*/.local/share/Trash"
      "/home/*/Downloads"
      "*.tmp"
      ".tmp.*"
      "**/node_modules"
      "**/.direnv"
      "**/target"
      "**/__pycache__"
      "**/.venv"
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

  # ── Boot configuration ─────────────────────────────────

  boot = {
    kernelPackages = pkgs.linuxPackages_6_12;
    extraModulePackages = [config.boot.kernelPackages.kvmfr];

    initrd = {
      verbose = false;
      kernelModules = [
        # VFIO
        "vfio_pci"
        "vfio"
        "vfio_iommu_type1"
        # Looking Glass
        "kvmfr"
      ];
    };

    kernelParams = [
      # Boot
      "acpi_rev_override=1"
      "quiet"
      "loglevel=3"
      "systemd.show_status=auto"
      "rd.udev.log_level=3"

      # NVIDIA Wayland
      "nvidia-drm.fbdev=1"

      # AMD Radeon WX 5100 — bind to VFIO for VM passthrough
      "vfio-pci.ids=1002:67c7,1002:aaf0"

      # IOMMU (Intel CPU)
      "intel_iommu=on"
      "iommu=pt"

      # VFIO
      "rd.driver.pre=vfio_pci"
      "vfio_pci.disable_vga=1"

      # KVM optimizations
      "kvm.ignore_msrs=1"
      "kvm.report_ignored_msrs=0"

      # Looking Glass shared memory
      "kvmfr.static_size_mb=128"
    ];

    consoleLogLevel = 0;
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

  # ── Udev rules ─────────────────────────────────────────

  services.udev.extraRules = ''
    # Radeon WX 5100 — runtime PM for power savings when idle
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x1002", ATTR{device}=="0x67c7", ATTR{power/control}="auto"
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x1002", ATTR{device}=="0xaaf0", ATTR{power/control}="auto"

    # Looking Glass kvmfr device
    SUBSYSTEM=="kvmfr", GROUP="kvm", MODE="0660"
  '';

  # ── Host-specific services ─────────────────────────────
  services.gvfs.enable = true;
  time.hardwareClockInLocalTime = true;
}
