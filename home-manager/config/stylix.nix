{pkgs, ...}: let
  stylixSettings = import ../../lib/stylix.nix {inherit pkgs;};
in {
  gtk.gtk4.theme = null;

  stylix = stylixSettings // {
    image = ../../assets/wallpapers/wallhaven-lym7pl.jpg;
    targets = {
      gtk.flatpakSupport.enable = true;
    };
  };
}
