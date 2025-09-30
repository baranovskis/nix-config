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
    dconf2nix

    # Productivity
    gimp
    inkscape
    eloquent

    # Development
    vscode
    nodejs_22

    # Gaming
    #citron-emu
    #modrinth-app

    # Fonts for Looking Glass
    dejavu_fonts
  ];
}