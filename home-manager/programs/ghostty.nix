{...}: {
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      window-padding-x = 16;
      window-padding-y = 12;
      window-decoration = false;
      gtk-titlebar = false;
      confirm-close-surface = false;
      mouse-hide-while-typing = true;
      copy-on-select = "clipboard";
    };
  };
}
