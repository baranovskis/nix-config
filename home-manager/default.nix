{
  inputs,
  outputs,
  username,
  ...
}: {
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

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.05";
}
