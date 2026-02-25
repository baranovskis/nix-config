{ fullName, email, ... }: {
  programs.git = {
    enable = true;
    settings.user = {
      name = fullName;
      inherit email;
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
