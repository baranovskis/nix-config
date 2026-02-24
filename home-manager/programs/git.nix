{...}: {
  programs.git = {
    enable = true;
    settings.user = {
      name = "Andrejs Baranovskis";
      email = "info@baranovskis.dev";
    };

    delta = {
      enable = true;
      options = {
        navigate = true;
        side-by-side = true;
      };
    };
  };
}
