{ inputs, outputs }: {
  mkHost = {
    hostname,
    username ? "baranovskis",
    fullName ? "Andrejs Baranovskis",
    email ? "info@baranovskis.dev",
    system ? "x86_64-linux",
    extraModules ? [],
  }:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs outputs username fullName email; };
      modules =
        [
          ../modules
          ../hosts/${hostname}
        ]
        ++ extraModules;
    };

  mkHome = {
    username,
    fullName ? "Andrejs Baranovskis",
    email ? "info@baranovskis.dev",
    system ? "x86_64-linux",
    extraModules ? [],
  }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      extraSpecialArgs = { inherit inputs outputs username fullName email; };
      modules = [ ../home-manager ] ++ extraModules;
    };
}
