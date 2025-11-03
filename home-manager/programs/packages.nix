{pkgs, ...}: {
  home.packages = with pkgs; [
    # Media & Communication
    ffmpeg
    imagemagick
    spotify
    telegram-desktop

    # Security & Utilities
    bitwarden-desktop
    firefox
    pika-backup

    # Productivity
    remmina
    gimp
    inkscape
    realesrgan-ncnn-vulkan
    eloquent

    # Development
    vscode
    jetbrains-toolbox
    nodejs_22

    # Fonts
    corefonts
    vistafonts
    dejavu_fonts
  ];
}