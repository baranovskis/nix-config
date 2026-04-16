{...}: {
  imports = [
    ../wm/gnome
    ../programs/gaming.nix
  ];

  xdg.configFile."looking-glass/client.ini".text = ''
    [win]
    size=1920x1200
    jitRender=yes

    [egl]
    vsync=yes
    doubleBuffer=yes
    noBufferAge=yes

    [wayland]
    warpSupport=yes

    [input]
    rawMouse=yes
  '';
}
