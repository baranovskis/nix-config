{...}: {
  programs.fish = {
    enable = true;
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
