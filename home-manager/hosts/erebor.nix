{...}: {
  imports = [
    ../wm/gnome
    ../programs/gaming.nix
  ];

  xdg.configFile."looking-glass/client.ini".text = ''
    [win]
    size=1920x1200
  '';
}
