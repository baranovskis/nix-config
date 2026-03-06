{pkgs, ...}: let
  stylixSettings = import ../../lib/stylix.nix {inherit pkgs;};
in {
  stylix = stylixSettings // {
    image = ../../assets/wallpapers/wallhaven-lym7pl.jpg;
    targets = {
      gtk.flatpakSupport.enable = true;
    };
  };
}
