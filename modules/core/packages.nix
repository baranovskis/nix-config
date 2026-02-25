{ pkgs, ... }: {
  programs.nix-ld.enable = true;
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
    nh
    nix-output-monitor
    nvd
  ];
}
