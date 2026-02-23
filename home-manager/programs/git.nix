{...}: {
  programs.git = {
    enable = true;
    settings.user = {
      name = "Andrejs Baranovskis";
      email = "info@baranovskis.dev";
    };
  };
}
