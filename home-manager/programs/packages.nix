# Packages without dedicated home-manager modules
#
# Programs that have home-manager modules (bat, eza, git, yazi, etc.)
# live in their own files. This file is for raw packages only.
{pkgs, ...}: {
  home.packages = with pkgs; [
    # Media (CLI tools — GUI media apps live in Flatpak)
    ffmpeg
    imagemagick

    # Productivity (Nix-only — not available or unsuitable for Flatpak)
    realesrgan-ncnn-vulkan
    eloquent

    # Development
    zed-editor
    jetbrains-toolbox
    nodejs_22
    python3
    claude-code

    # Modern CLI tools (no home-manager modules — just packages)
    fd # find replacement
    ripgrep # grep replacement
    dust # du replacement
    duf # df replacement
    procs # ps replacement
    sd # sed replacement
    tealdeer # tldr pages

    # Fonts
    corefonts
    vista-fonts
    dejavu_fonts
  ];
}
