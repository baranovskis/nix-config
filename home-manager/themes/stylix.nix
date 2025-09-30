{pkgs, ...}: {
  stylix = {
    enable = true;
    autoEnable = true;
    image = ../wallpapers/wallhaven-lym7pl.jpg;
    polarity = "dark";
    fonts = {
      serif = {
        package = pkgs.google-fonts.override {fonts = ["Inter"];};
        name = "Inter";
      };

      sansSerif = {
        package = pkgs.google-fonts.override {fonts = ["Inter"];};
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
}