{pkgs, ...}: {
  # System-wide packages, root accessible
  programs.nix-ld.enable = true;

  # Firmware updates (Bluefin ships fwupd for hardware firmware)
  services.fwupd.enable = true;

  environment.systemPackages = with pkgs; [
    home-manager
    curl
    git
    openssh
    openssl
    sshfs
    wget
    pciutils
    usbutils
    mesa-demos
    just

    # Nix helpers — better UX for nix operations
    nh # Wraps nixos-rebuild/home-manager with pretty output and diffs
    nix-output-monitor # Pretty nix build progress (use: nom build)
    nvd # Diff between NixOS generations (used by: just changelogs)
  ];
}
