{pkgs, ...}: {
  home.packages = with pkgs; [
    # Media
    ffmpeg
    imagemagick

    # Productivity
    realesrgan-ncnn-vulkan
    eloquent

    # Development
    nodejs_22
    python3
    claude-code

    # CLI tools
    fd
    ripgrep
    dust
    duf
    procs
    sd
    tealdeer

    # Fonts
    corefonts
    vista-fonts
    dejavu_fonts
  ];
}
