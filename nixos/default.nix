# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    ./audio.nix
    ./bluetooth.nix
    ./fonts.nix
    ./gaming.nix
    ./gnome.nix
    ./gnupg.nix
    ./hardware.nix
    ./nuphy.nix
    ./networking.nix
    ./nvidia.nix
    ./solaar.nix
    ./ssh.nix
    ./user.nix
    ./virtualization.nix
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

  # System-wide packages, root accessible
  programs.nix-ld.enable = true;
  environment.systemPackages = with pkgs; [
    curl
    git
    openssh
    sshfs
    wget
    pciutils
    usbutils
  ];

  # Shell configuration
  programs.zsh.enable = true;
  
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";


  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # SUDO and Terminal
  #environment.enableAllTerminfo = true;
  #hardware.enableAllFirmware = true;

  #security.sudo = {
  #  extraConfig = ''
  #    Defaults lecture = never # rollback results in sudo lectures after each reboot, it's somewhat useless anyway
  #    Defaults pwfeedback # password input feedback - makes typed password visible as asterisks
  #    Defaults timestamp_timeout=120 # only ask for password every 2h
  #    # Keep SSH_AUTH_SOCK so that pam_ssh_agent_auth.so can do its magic.
  #    Defaults env_keep+=SSH_AUTH_SOCK
  #  '';
  #};

  # Cleanup
  #programs.nh = {
  #  enable = true;
  #  clean.enable = true;
  #  clean.extraArgs = "--keep-since 20d --keep 20";
  #  flake = "${config.hostSpec.home}/git/Nix/dot.nix/";
  #};

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # See https://jackson.dev/post/nix-reasonable-defaults/
      connect-timeout = 5;
      min-free = 128000000; # 128MB
      max-free = 1000000000; # 1GB

      # Enable flakes and new 'nix' command
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      # Deduplicate and optimize nix store
      warn-dirty = false;
      auto-optimise-store = true;

      # Opinionated: disable global registry
      flake-registry = "";

      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };

    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.05";
}
