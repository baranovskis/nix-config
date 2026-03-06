{
  inputs,
  outputs,
  username,
  ...
}: {
  imports = [
    inputs.stylix.homeModules.stylix
    inputs.nix-flatpak.homeManagerModules.nix-flatpak

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
        source = ../assets/wallpapers;
        recursive = true;
      };
    };
  };

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.05";
}
