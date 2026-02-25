{ ... }: {
  imports = [
    ./gc.nix
    ./locale.nix
    ./networking.nix
    ./nix.nix
    ./packages.nix
    ./power.nix
    ./shell.nix
    ./ssh.nix
    ./user.nix
  ];
}
