{...}: {
  services.flatpak.enable = true;

  services.flatpak.remotes = [
    {
      name = "flathub";
      location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    }
  ];

  services.flatpak.update.onActivation = true;

  services.flatpak.update.auto = {
    enable = true;
    onCalendar = "*-*-* 0/6:00:00";
  };

  services.flatpak.packages = [
    # Flatpak management
    "io.github.kolunmi.Bazaar"
    "com.github.tchx84.Flatseal"
    "io.github.flattool.Warehouse"

    # GNOME
    "com.mattjakeman.ExtensionManager"

    # Communication
    "org.telegram.desktop"

    # Security
    "com.bitwarden.desktop"

    # Media
    "com.spotify.Client"
    "org.gimp.GIMP"
    "org.inkscape.Inkscape"

    # Productivity
    "org.remmina.Remmina"

    # System
    "io.missioncenter.MissionCenter"

    # Gaming
    "net.lutris.Lutris"
    "com.heroicgameslauncher.hgl"
    "com.usebottles.bottles"

    # AI
    "com.jeffser.Alpaca"

    # Development
    "dev.zed.Zed"
    "com.jetbrains.Toolbox"
  ];

  # services.flatpak.uninstallUnmanaged = true;
}
