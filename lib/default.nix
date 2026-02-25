{ inputs, outputs }: {
  mkHost = {
    hostname,
    username ? "baranovskis",
    system ? "x86_64-linux",
    extraModules ? [],
  }:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs outputs username; };
      modules =
        [
          ../modules
          ../hosts/${hostname}
        ]
        ++ extraModules;
    };

  mkHome = {
    username,
    system ? "x86_64-linux",
    extraModules ? [],
  }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      extraSpecialArgs = { inherit inputs outputs username; };
      modules = [ ../home-manager ] ++ extraModules;
    };
}
