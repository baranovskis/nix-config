# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{outputs, ...}: {
  # Import modular configurations
  # These are shared configurations across all hosts
  imports = [
    # Audio & Peripherals
    ./audio.nix
    ./bluetooth.nix
    ./nuphy.nix
    ./solaar.nix

    # Desktop Environment
    ./gnome.nix
    ./fonts.nix

    # Development & Services
    ./docker.nix
    ./nfs.nix
    ./networking.nix
    ./rdp.nix
    ./virtualization.nix

    # Security
    ./ssh.nix
    ./gnupg.nix

    # System
    ./gc.nix
    ./locale.nix
    ./nix.nix
    ./packages.nix
    ./printing.nix
    ./shell.nix
    ./user.nix
  ];

  # Overlays
  nixpkgs = {
    overlays = [
      outputs.overlays.default
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.05";
}
