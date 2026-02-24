{...}: {
  imports = [
    # Shell & prompt
    ./fish.nix
    ./starship.nix

    # Modern CLI tools (each with home-manager module integration)
    ./atuin.nix
    ./bat.nix
    ./btop.nix
    ./eza.nix
    ./fastfetch.nix
    ./fzf.nix
    ./yazi.nix
    ./zoxide.nix

    # Development
    ./direnv.nix
    ./git.nix

    # Host-specific (erebor only — harmless on other hosts)
    ./looking-glass.nix

    # Raw packages (no home-manager modules)
    ./packages.nix
  ];
}
