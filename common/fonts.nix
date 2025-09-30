{ pkgs, lib, ... }:
{
  fonts = {
    packages = with pkgs; [
      # Sans fonts
      (google-fonts.override {
        fonts = [
          "Inter"
        ];
      })

      # monospace fonts
      jetbrains-mono
      nerd-fonts.jetbrains-mono
    ];

    # causes more issues than it solves
    enableDefaultPackages = false;

    # user defined fonts
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Inter" ];
        sansSerif = [ "Inter" ];
        monospace = [ "JetBrains Mono" ];
      };
    };
  };
}
