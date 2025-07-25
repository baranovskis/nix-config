# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
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
    base16Scheme = ./stylix.yaml;
    image = ./wallpapers/gojo.jpg;
    polarity = "dark";
    fonts = {
    #  serif = {
    #    package = pkgs.google-fonts.override { fonts = [ "Laila" ]; };
    #    name = "Laila";
    #  };

    #  sansSerif = {
    #    package = pkgs.lexend;
    #    name = "Lexend";
    #  };

    #  monospace = {
    #    package = pkgs.monocraft-nerd-fonts;
    #    name = "Monocraft";
    #  };

    #  emoji = {
    #    package = pkgs.noto-fonts-emoji;
    #    name = "Noto Color Emoji";
    #  };
      sizes = {
        applications = 12;
        desktop = 11;
        popups = 11;
        terminal = 12;
      };
    };
    targets = {
      gnome = {
        enable = true;
        useWallpaper = true;
      };
      vscode = {
        enable = false;
        # profileNames = [ "Stylix" ];
      };
    };
  };

  home = {
    username = "baranovskis";
    homeDirectory = "/home/baranovskis";
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
  ];

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
}
