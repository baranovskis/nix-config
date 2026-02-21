# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  username,
  ...
}: {
  # Import modular configurations
  imports = [
    inputs.stylix.homeModules.stylix

    ./modules/nautilus.nix
    ./config
    ./programs
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

  # Nautilus file manager
  programs.nautilus = {
    enable = true;

    bookmarks = [
      {
        path = "/fast";
        name = "⚡ Fast";
      }
      {
        path = "/tank";
        name = "🫙 Tank";
      }
    ];
  };

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
}
