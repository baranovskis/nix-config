{
  inputs,
  lib,
  config,
  ...
}: {
  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # https://jackson.dev/post/nix-reasonable-defaults/
      connect-timeout = 5;
      min-free = 128000000;
      max-free = 1000000000;

      experimental-features = [
        "nix-command"
        "flakes"
      ];

      max-jobs = "auto";
      cores = 0;

      warn-dirty = false;
      auto-optimise-store = true;
      flake-registry = "";

      # https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };

    channel.enable = false;

    registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };
}
