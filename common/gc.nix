{
  config,
  lib,
  pkgs,
  ...
}: {
  # Nix garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
}