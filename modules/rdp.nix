{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.rdp;
in {
  options.modules.rdp = {
    enable = lib.mkEnableOption "RDP remote desktop";
  };

  config = lib.mkIf cfg.enable {
    services.xrdp = {
      enable = true;
      defaultWindowManager = "${pkgs.gnome-session}/bin/gnome-session";
      openFirewall = true;
    };

    services.gnome.gnome-remote-desktop.enable = true;
  };
}
