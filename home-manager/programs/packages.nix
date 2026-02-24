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

    # Modern CLI tools (Bluefin-inspired replacements)
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
