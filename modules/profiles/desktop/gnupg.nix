{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.profiles.desktop.enable {
    programs.gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-gnome3;
    };
    services.pcscd.enable = true;
  };
}
