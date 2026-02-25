{ ... }: {
  imports = [
    ../../modules/nautilus.nix
    ./dconf.nix
  ];

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
}
