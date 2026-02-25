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
    inherit (self) outputs;
    lib = import ./lib { inherit inputs outputs; };
    username = "baranovskis";
    fullName = "Andrejs Baranovskis";
    email = "info@baranovskis.dev";
  in {
    overlays = import ./overlays { inherit inputs; };

    nixosConfigurations = {
      erebor = lib.mkHost {
        hostname = "erebor";
        inherit username fullName email;
        extraModules = [
          inputs.nix-flatpak.nixosModules.nix-flatpak
        ];
      };

      desktop = self.nixosConfigurations.erebor;
      nixos = self.nixosConfigurations.erebor;
    };

    homeConfigurations = {
      "${username}@erebor" = lib.mkHome {
        inherit username fullName email;
        extraModules = [ ./home-manager/hosts/erebor.nix ];
      };

      ${username} = lib.mkHome {
        inherit username fullName email;
      };
    };
  };
}
