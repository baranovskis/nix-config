# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  username,
  ...
}: 
{
  # You can import other home-manager modules here
  imports = [
    inputs.stylix.homeModules.stylix

    ./config
    ./zen.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.default
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  stylix = {
    enable = true;
    autoEnable = true;
    #base16Scheme = ./wallhaven-lym7pl.yaml;
    image = ./wallpapers/wallhaven-lym7pl.jpg;
    polarity = "dark";
    fonts = {
      serif = {
        package = pkgs.google-fonts.override { fonts = [ "Inter" ]; };
        name = "Inter";
      };

      sansSerif = {
        package = pkgs.google-fonts.override { fonts = [ "Inter" ]; };
        name = "Inter";
      };

      monospace = {
        package = pkgs.jetbrains-mono;
        name = "JetBrains Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = 12;
        desktop = 12;
        popups = 12;
        terminal = 14;
      };
    };
    targets = {
      gnome = {
        enable = true;
        useWallpaper = true;
      };
      vscode = {
        enable = false;
        #profileNames = [ "Stylix" ];
      };
    };
  };

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    file = {
      "Pictures/Wallpapers" = {
        source = ./wallpapers;
        recursive = true;
      };
    };
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [ 
    ffmpeg
    spotify
    telegram-desktop
    bitwarden-desktop
    firefox
    pika-backup

    # Productivity
    gimp
    inkscape
    eloquent

    # Coding
    vscode
    claude-code

    # Gaming
    #citron-emu
    #modrinth-app

    # Fonts for Looking Glass
    dejavu_fonts
  ];

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
}
