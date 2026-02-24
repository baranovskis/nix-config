# Atuin — shell history search and sync
{...}: {
  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    flags = ["--disable-up-arrow"]; # Don't override up arrow, use Ctrl+R
  };
}
