{pkgs, ...}: {
  home.packages = with pkgs; [
    # Media & Communication
    ffmpeg
    spotify
    telegram-desktop

    # Security & Utilities
    bitwarden-desktop
    firefox
    pika-backup

    # Productivity
    gimp
    inkscape
    eloquent

    # Development
    vscode
    nodejs_22

    # Fonts for Looking Glass
    dejavu_fonts

    # Themes
    kora-icon-theme
  ];
}