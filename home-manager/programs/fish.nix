# Fish shell — abbreviations and shell-specific settings
#
# Individual CLI tool modules (bat, eza, zoxide, etc.) live in their own files.
# Fish integration for each tool is handled by the tool's home-manager module.
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
}
