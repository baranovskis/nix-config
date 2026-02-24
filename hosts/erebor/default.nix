# Erebor — Desktop workstation
{
  config,
  pkgs,
  username,
  ...
}: {
  imports = [
    ./hardware.nix
    ../../modules/gpu.nix
    ../../modules/gaming.nix
    ../../modules/zfs.nix
  ];

  networking.hostName = "erebor";

  # Modules
  modules.gpu.enable = true;
  modules.gaming.enable = true;

  modules.zfs = {
    enable = true;
    hostId = "afeb27ee";
    pools = ["tank"];
  };

  # NVIDIA RTX 4060
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  hardware.nvidia-container-toolkit.enable = true;

  # VFIO + Looking Glass
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

  # Restic backup
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

  # Boot
  boot = {
    kernelPackages = pkgs.linuxPackages_6_12;
    extraModulePackages = [config.boot.kernelPackages.kvmfr];

    initrd = {
      verbose = false;
      kernelModules = [
        "vfio_pci"
        "vfio"
        "vfio_iommu_type1"
        "kvmfr"
      ];
    };

    kernelParams = [
      "acpi_rev_override=1"
      "quiet"
      "loglevel=3"
      "systemd.show_status=auto"
      "rd.udev.log_level=3"

      "nvidia-drm.fbdev=1"

      # Radeon WX 5100 VFIO passthrough
      "vfio-pci.ids=1002:67c7,1002:aaf0"

      # IOMMU
      "intel_iommu=on"
      "iommu=pt"
      "rd.driver.pre=vfio_pci"
      "vfio_pci.disable_vga=1"

      # KVM
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

  # Udev
  services.udev.extraRules = ''
    # Radeon WX 5100 power management
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x1002", ATTR{device}=="0x67c7", ATTR{power/control}="auto"
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x1002", ATTR{device}=="0xaaf0", ATTR{power/control}="auto"

    # Looking Glass kvmfr
    SUBSYSTEM=="kvmfr", GROUP="kvm", MODE="0660"
  '';

  services.gvfs.enable = true;
  time.hardwareClockInLocalTime = true;
}
