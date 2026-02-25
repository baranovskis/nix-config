{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.nfs;
in {
  options.modules.nfs = {
    enable = lib.mkEnableOption "NFS client support";
  };

  config = lib.mkIf cfg.enable {
    services.rpcbind.enable = true;

    environment.systemPackages = with pkgs; [
      nfs-utils
    ];
  };
}
