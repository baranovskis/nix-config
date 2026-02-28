{ ... }: {
  imports = [
    ../../modules/nautilus.nix
    ./dconf.nix
  ];

  # Hide the built-in Extensions app (using Extension Manager via Flatpak)
  xdg.desktopEntries."org.gnome.Extensions" = {
    name = "Extensions";
    noDisplay = true;
  };

  programs.nautilus = {
    enable = true;

    bookmarks = [
      {
        path = "/fast";
        name = "⚡ Fast";
      }
      {
        path = "/tank";
        name = "🫙 Tank";
      }
      {
        path = "/etc/nixos";
        name = "❄️ NixOS";
      }
    ];
  };
}
