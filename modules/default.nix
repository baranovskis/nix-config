{ outputs, ... }: {
  imports = [
    ./core
    ./wm
    ./profiles/desktop

    ./ai.nix
    ./docker.nix
    ./gaming.nix
    ./gpu.nix
    ./nfs.nix
    ./rdp.nix
    ./sunshine.nix
    ./virtualization.nix
    ./zfs.nix
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

  system.stateVersion = "25.05";
}
