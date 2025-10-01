{pkgs, ...}: {
  # NFS client support
  services.rpcbind.enable = true;

  # Required packages for NFS
  environment.systemPackages = with pkgs; [
    nfs-utils
  ];
}
