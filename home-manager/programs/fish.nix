{...}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      if status is-interactive; and not set -q __motd_shown
        set -g __motd_shown 1
        fastfetch
        echo ""
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
      ".." = "cd ..";
      "..." = "cd ../..";
    };
    shellAliases = {
      njust = "just --justfile /etc/nixos/Justfile --working-directory /etc/nixos";
    };
  };
}
