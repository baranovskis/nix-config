{ inputs, outputs }: {
  mkHost = {
    hostname,
    username ? builtins.throw "mkHost: 'username' is required",
    fullName ? builtins.throw "mkHost: 'fullName' is required",
    email ? builtins.throw "mkHost: 'email' is required",
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
    username ? builtins.throw "mkHome: 'username' is required",
    fullName ? builtins.throw "mkHome: 'fullName' is required",
    email ? builtins.throw "mkHome: 'email' is required",
    system ? "x86_64-linux",
    extraModules ? [],
  }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      extraSpecialArgs = { inherit inputs outputs username fullName email; };
      modules = [ ../home-manager ] ++ extraModules;
    };
}
