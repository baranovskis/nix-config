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

    # Productivity
    remmina
    rustdesk-flutter
    gimp
    inkscape
    realesrgan-ncnn-vulkan
    eloquent

    # Development
    vscode
    jetbrains-toolbox
    nodejs_22
    python3
    claude-code

    # Fonts
    corefonts
    vista-fonts
    dejavu_fonts
  ];
}