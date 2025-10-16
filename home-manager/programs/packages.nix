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

    # Fonts
    corefonts # Microsoft fonts (Verdana, Arial, Times New Roman, etc.)
    vistafonts # Additional Microsoft fonts (Calibri, Cambria, Consolas, etc.)
  ];
}