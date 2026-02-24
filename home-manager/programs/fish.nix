{...}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # MOTD — show welcome and available commands on new interactive shells
      if status is-interactive; and not set -q __motd_shown
        set -g __motd_shown 1
        set_color brwhite; echo ""; echo "  Erebor — NixOS Configuration"; set_color normal
        set_color brblack; echo "  github.com/baranovskis/nix-config"; echo ""; set_color normal
        set_color yellow;  echo "  System"; set_color normal
        echo "    njust system         Build and switch system configuration"
        echo "    njust user           Build and switch home-manager configuration"
        echo "    njust update         Update all flake inputs"
        echo "    njust changelogs     Show diff between generations"
        echo "    njust clean          Clean old generations, containers, flatpaks"
        echo "    njust bios           Reboot into BIOS/UEFI firmware setup"
        echo ""
        set_color yellow;  echo "  Containers"; set_color normal
        echo "    njust distrobox-create   Create a new Distrobox container"
        echo "    njust distrobox-enter    Enter a Distrobox container"
        echo ""
        set_color yellow;  echo "  Backup"; set_color normal
        echo "    njust backup         Run backup now"
        echo "    njust backup-status  Check backup status"
        echo "    njust backup-list    List backup snapshots"
        echo "    njust backup-restore Restore latest backup"
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
