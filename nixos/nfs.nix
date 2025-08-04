{
  config,
  pkgs,
  ...
}: {
  # Enable NFS server
  services.nfs.server = {
    enable = true;
    # Allow NFS clients from local network and localhost
    exports = ''
      /export         192.168.0.0/16(rw,fsid=0,no_subtree_check)
      /export/home    192.168.0.0/16(rw,nohide,insecure,no_subtree_check)
      /export/public  192.168.0.0/16(rw,nohide,insecure,no_subtree_check,all_squash,anonuid=1000,anongid=1000)
    '';
  };

  # Open firewall for NFS
  networking.firewall = {
    allowedTCPPorts = [ 2049 ];
    allowedUDPPorts = [ 2049 ];
  };

  # Create NFS export directories
  systemd.tmpfiles.rules = [
    "d /export 0755 nobody nogroup -"
    "d /export/home 0755 nobody nogroup -"
    "d /export/public 0755 nobody nogroup -"
  ];

  # Enable RPC services required for NFS
  services.rpcbind.enable = true;
}