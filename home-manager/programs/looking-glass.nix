{pkgs, ...}: {
  # Looking Glass client configuration
  xdg.configFile."looking-glass/client.ini".text = ''
    [win]
    size=1920x1200
    uiFont=Adwaita Mono
  '';
}
