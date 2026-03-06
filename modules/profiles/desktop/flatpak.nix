{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.profiles.desktop.enable {
    services.flatpak.enable = true;
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
    };
  };
}
