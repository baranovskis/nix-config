# Zoxide — smart cd that learns from usage (use 'z' to jump anywhere)
{...}: {
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
