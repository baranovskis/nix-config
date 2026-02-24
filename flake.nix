{
  description = "Baranovskis Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    solaar = {
      url = "github:Svenum/solaar-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    username = "baranovskis";
    inherit (self) outputs;

    mkHome = extraModules:
      home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs outputs username;
        };
        modules = [./home-manager] ++ extraModules;
      };
  in {
    overlays = import ./overlays {inherit inputs;};

    nixosConfigurations = {
      erebor = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs username;
        };
        modules = [
          inputs.nix-flatpak.nixosModules.nix-flatpak
          ./common
          ./hosts/erebor
        ];
      };

      desktop = self.nixosConfigurations.erebor;
      nixos = self.nixosConfigurations.erebor;
    };

    # Per-host home configs: home-manager switch --flake .
    # Matches "username@hostname" automatically
    homeConfigurations = {
      "${username}@erebor" = mkHome [./home-manager/hosts/erebor.nix];

      # Fallback (no host-specific config)
      ${username} = mkHome [];
    };
  };
}
