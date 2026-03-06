{pkgs, ...}: {
  home.packages = with pkgs; [
    # Media
    ffmpeg
    imagemagick

    # Productivity
    realesrgan-ncnn-vulkan
    eloquent
    mission-center

    # Development
    nodejs_22
    python3
    claude-code
    zed-editor

    # Fonts
    corefonts
    vista-fonts
    dejavu_fonts
  ];
}
