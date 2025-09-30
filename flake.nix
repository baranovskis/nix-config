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
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # VM tools
    nixvirt = {
      url = "https://flakehub.com/f/AshleyYakeley/NixVirt/*.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs-stable";
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

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
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
