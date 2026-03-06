{...}: {
  services.flatpak = {
    enable = true;

    remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
    ];

    update.onActivation = true;

    update.auto = {
      enable = true;
      onCalendar = "*-*-* 0/6:00:00";
    };

    overrides.global = {
      Context = {
        filesystems = [
          "xdg-config/gtk-3.0:ro"
          "xdg-config/gtk-4.0:ro"
          "/nix/store:ro"
        ];
      };
    };


    packages = [
      "io.github.kolunmi.Bazaar"
      "com.github.tchx84.Flatseal"
      "io.github.flattool.Warehouse"
      "com.mattjakeman.ExtensionManager"
      "org.telegram.desktop"
      "com.bitwarden.desktop"
      "com.spotify.Client"
      "org.gimp.GIMP"
      "org.inkscape.Inkscape"
      "org.remmina.Remmina"
      # Mission Center: use native nixpkg instead (gatherer socket fails on NixOS)
      # "io.missioncenter.MissionCenter"
      "com.usebottles.bottles"
      "com.jeffser.Alpaca"
      "io.podman_desktop.PodmanDesktop"
    ];
  };
}
