{
  description = "Baranovskis Flake";

  inputs = {
    # NixOS
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Theming
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Misc Packages
    solaar = {
      url = "github:Svenum/solaar-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Flatpak
    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    username = "baranovskis"; # Username for configurations
    inherit (self) outputs;
  in {
    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};

    # NixOS configuration entrypoint
    # Per-host configurations
    nixosConfigurations = {
      # Erebor (Desktop) configuration
      # sudo nixos-rebuild switch --flake .#erebor
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

      # Alias configurations for convenience
      desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs username;
        };
        modules = [
          inputs.nix-flatpak.nixosModules.nix-flatpak
          ./common
          ./hosts/erebor
        ];
      };

      # Default configuration (points to erebor for backward compatibility)
      # sudo nixos-rebuild switch --flake .
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs username;
        };
        modules = [
          inputs.nix-flatpak.nixosModules.nix-flatpak
          ./common
          ./hosts/erebor
        ];
      };
    };

    # Standalone home-manager configuration entrypoint
    # home-manager switch --flake .
    homeConfigurations.baranovskis = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      extraSpecialArgs = {
        inherit inputs outputs username;
      };
      modules = [ ./home-manager ];
    };
  };
}
