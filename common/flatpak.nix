# Flatpak-first: GUI applications managed declaratively through Flathub
#
# Hybrid design — each layer has a clear responsibility:
#   Nix (system)       → kernel, drivers, services, desktop shell
#   Nix (home-manager) → CLI tools, dev tools, shell config, fonts
#   Flatpak            → GUI applications (sandboxed, independent lifecycle)
#   Containers         → development environments (isolated, reproducible)
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

  # Declarative Flatpak packages — all GUI applications live here
  services.flatpak.packages = [
    # App Store & Flatpak Management
    "io.github.kolunmi.Bazaar" # Curated Flathub storefront
    "com.github.tchx84.Flatseal" # Flatpak permissions manager
    "io.github.flattool.Warehouse" # Flatpak management (pin, rollback, bulk ops)

    # GNOME Extensions
    "com.mattjakeman.ExtensionManager"

    # Communication
    "org.telegram.desktop"

    # Security
    "com.bitwarden.desktop"

    # Media & Creative
    "com.spotify.Client"
    "org.gimp.GIMP"
    "org.inkscape.Inkscape"

    # Productivity
    "org.remmina.Remmina"
  ];

  # Set to true to enforce fully declarative Flatpak management
  # (removes any manually installed Flatpaks not listed above)
  # services.flatpak.uninstallUnmanaged = true;
}
