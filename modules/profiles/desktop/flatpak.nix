{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.profiles.desktop.enable {
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
      "io.missioncenter.MissionCenter"
      "net.lutris.Lutris"
      "com.heroicgameslauncher.hgl"
      "com.usebottles.bottles"
      "com.jeffser.Alpaca"
      "dev.zed.Zed"
      "com.jetbrains.Toolbox"
      "io.podman_desktop.PodmanDesktop"
    ];
  };
}
