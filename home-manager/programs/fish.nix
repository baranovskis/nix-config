# Modern shell experience — Bluefin-inspired CLI with Fish
#
# Uses home-manager program modules for tools that have them (eza, zoxide, bat, btop).
# These modules handle shell integration automatically.
# Shell abbreviations cover the rest (fd, rg, dust, duf, procs).
{...}: {
  programs.fish = {
    enable = true;

    # Abbreviations expand inline — you see the real command before running it
    shellAbbrs = {
      cat = "bat";
      find = "fd";
      grep = "rg";
      du = "dust";
      df = "duf";
      ps = "procs";
      top = "btop";
      ".." = "cd ..";
      "..." = "cd ../..";
    };
  };

  # Starship prompt — fast, informative, cross-shell
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  # Modern ls with git status and icons
  programs.eza = {
    enable = true;
    extraOptions = [
      "--group-directories-first"
    ];
  };

  # Smart cd that learns from usage — use 'z' to jump anywhere
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  # Better cat with syntax highlighting
  programs.bat.enable = true;

  # Better top with per-process metrics
  programs.btop.enable = true;

  # System info
  programs.fastfetch.enable = true;
}
