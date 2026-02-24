{pkgs, ...}: {
  # System-wide packages, root accessible
  programs.nix-ld.enable = true;

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
    mission-center
    just
  ];
}