{...}: {
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "small";
        source = builtins.toFile "erebor.txt" ''
              ▲
             ╱ ╲
            ╱   ╲
           ╱  ◆  ╲
          ╱  ╱ ╲  ╲
         ╱  ╱   ╲  ╲
        ╱__╱_____╲__╲
           EREBOR
        '';
        color = {
          "1" = "yellow";
          "2" = "white";
        };
        padding = {
          top = 1;
          left = 2;
          right = 2;
        };
      };
      display = {
        separator = "  ";
        color = {
          keys = "yellow";
        };
      };
      modules = [
        "break"
        {
          type = "title";
          format = "{user-name}@{host-name}";
        }
        "separator"
        {
          type = "os";
          key = "🐧 OS";
        }
        {
          type = "kernel";
          key = "🔧 Kernel";
        }
        {
          type = "packages";
          key = "📦 Packages";
        }
        {
          type = "shell";
          key = "🐚 Shell";
        }
        {
          type = "de";
          key = "🖥️  DE";
        }
        {
          type = "wm";
          key = "🪟 WM";
        }
        {
          type = "terminal";
          key = "💻 Terminal";
        }
        "break"
        {
          type = "cpu";
          key = "🧠 CPU";
        }
        {
          type = "gpu";
          key = "🎮 GPU";
        }
        {
          type = "memory";
          key = "🧮 Memory";
        }
        {
          type = "disk";
          key = "💾 Disk";
        }
        {
          type = "uptime";
          key = "⏱️  Uptime";
        }
        "break"
        "colors"
      ];
    };
  };
}
