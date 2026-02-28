{pkgs, ...}: {
  home.packages = [
    pkgs.nerd-fonts.fira-code
  ];

  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      font-family = "FiraCode Nerd Font";
      background-opacity = 0.9;
      window-width = 110;
      window-height = 35;
      window-padding-x = 16;
      window-padding-y = 12;
      window-decoration = true;
      gtk-titlebar = true;
      confirm-close-surface = false;
      mouse-hide-while-typing = true;
      copy-on-select = "clipboard";
    };
  };
}
