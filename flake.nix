{
  description = "Personal Nix configurations for WSL (generated)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, nixpkgs, flake-utils, home-manager, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        hm = import home-manager {
          inherit pkgs;
          system = system;
        };
      in {
        # Home Manager configuration for a WSL host named "wsl"
        homeConfigurations = {
          wsl = hm.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [ ./hosts/wsl.nix ];
          };
        };

        packages.default = pkgs.mkShell {
          buildInputs = [ pkgs.git pkgs.curl pkgs.gnumake pkgs.zsh ];
          shellHook = ''
            echo "Dev shell for vinberg88/nix-config (WSL)"
          '';
        };
      });
}
