{...}: {
  services.flatpak.enable = true;

  # Remotes - Flathub is added by default, but explicit is clearer
  services.flatpak.remotes = [
    {
      name = "flathub";
      location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    }
  ];

  # Update flatpaks on system activation
  services.flatpak.update.onActivation = true;

  # Automatic weekly updates via systemd timer
  services.flatpak.update.auto = {
    enable = true;
    onCalendar = "weekly";
  };

  # Declarative Flatpak packages
  services.flatpak.packages = [
    "io.github.kolunmi.Bazaar" # GNOME Flatpak app store
    "org.telegram.desktop"
    "com.bitwarden.desktop"
  ];

  # Global overrides for all Flatpak apps
  # services.flatpak.overrides = {
  #   global = {
  #     Environment.GTK_THEME = "Adwaita:dark";
  #   };
  # };

  # Set to true to uninstall flatpaks not declared above
  # services.flatpak.uninstallUnmanaged = false;
}
