{pkgs, inputs, ...}: {
  home.packages = with pkgs; [
    # Media & Communication
    ffmpeg
    imagemagick
    spotify

    # Security & Utilities

    # Productivity
    remmina
    gimp
    inkscape
    realesrgan-ncnn-vulkan
    eloquent

    # Development
    zed-editor
    jetbrains-toolbox
    nodejs_22
    python3
    claude-code
    fastfetch

    # Fonts
    corefonts
    vista-fonts
    dejavu_fonts
  ];
}
