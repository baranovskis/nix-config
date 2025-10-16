{pkgs, ...}: 
{
  stylix = {
    enable = true;
    autoEnable = true;
    image = ../wallpapers/wallhaven-lym7pl.jpg;
    polarity = "dark";

    cursor = {
      package = pkgs.capitaine-cursors;
      name = "capitaine-cursors";
      size = 32;
    };

    icons = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };

    fonts = {
      serif = {
        package = pkgs.google-fonts.override {
          fonts = ["Inter"];
        };
        name = "Inter";
      };

      sansSerif = {
        package = pkgs.google-fonts.override {
          fonts = ["Inter"];
        };
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
      firefox = {
        firefoxGnomeTheme = {
          enable = true;
        };
      };
    };
  };
}