{...}: {
  imports = [
    ../wm/gnome
  ];

  xdg.configFile."looking-glass/client.ini".text = ''
    [win]
    size=1920x1200
  '';
}
