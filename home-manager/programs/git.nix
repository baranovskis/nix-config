{...}: {
  programs.git = {
    enable = true;
    settings.user = {
      name = "Andrejs Baranovskis";
      email = "info@baranovskis.dev";
    };

    # Delta — syntax-highlighted git diffs
    delta = {
      enable = true;
      options = {
        navigate = true;
        side-by-side = true;
      };
    };
  };
}
