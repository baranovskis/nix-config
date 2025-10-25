# Desktop host configuration
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    # Hardware
    ./hardware.nix

    # Graphics & GPU
    ./graphics.nix
    ./nvidia.nix
    ./radeon.nix

    # VFIO & GPU Passthrough
    ./vfio.nix

    # Gaming
    ./gaming.nix

    # Storage
    ./zfs.nix
  ];

  # Host-specific configuration
  networking.hostName = "erebor";

  # Boot configuration
  boot = {
    # Using 6.12 LTS kernel for ZFS compatibility
    # ZFS support often lags behind the newest kernel releases
    kernelPackages = pkgs.linuxPackages_6_12;

    # Hardware-specific kernel parameters
    kernelParams = [
      "acpi_rev_override=1"
      "loglevel=3"
    ];

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