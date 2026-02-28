{...}: {
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "kitty-direct";
        source = ../logo/erebor.png;
        width = 22;
        height = 14;
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
