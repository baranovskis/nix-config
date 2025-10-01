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
    kernelPackages = pkgs.linuxPackages_zen;

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

  # Windows dual-boot time fix
  time.hardwareClockInLocalTime = true;
}