# Desktop host configuration
{
  config,
  lib,
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

  # Host-specific configuration
  networking.hostName = "erebor";

  # Boot configuration
  boot = {
    kernelPackages = pkgs.linuxPackages_6_12;

    # Hardware-specific kernel parameters
    kernelParams = [
      "acpi_rev_override=1"
      "quiet"
      "loglevel=3"
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
    ];

    # Suppress boot messages for clean boot experience
    consoleLogLevel = 0;
    initrd.verbose = false;

    # Plymouth for graphical boot splash
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

  # Browsing samba shares with GVFS
  services.gvfs.enable = true;

  # Windows dual-boot time fix
  time.hardwareClockInLocalTime = true;
}
