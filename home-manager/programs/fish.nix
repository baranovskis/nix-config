{...}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # MOTD — show welcome and available commands on new interactive shells
      if status is-interactive; and not set -q __motd_shown
        set -g __motd_shown 1
        echo ""
        set_color brwhite; echo "  🏔️  Erebor — NixOS Configuration"; set_color normal
        set_color brblack; echo "  github.com/baranovskis/nix-config"; echo ""; set_color normal
        echo "    🔨 njust system    Build and switch system"
        echo "    🏠 njust user      Build and switch home-manager"
        echo "    📦 njust update    Update flake inputs"
        echo "    🧹 njust clean     Clean old generations"
        echo ""
        set_color brblack; echo "  Run 'njust' for all commands"; set_color normal
        echo ""
      end
    '';
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
    shellAliases = {
      njust = "just --justfile ~/nix-config/Justfile --working-directory ~/nix-config";
    };
  };
}
