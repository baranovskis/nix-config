{ fullName, email, ... }: {
  programs.git = {
    enable = true;
    settings.user = {
      name = fullName;
      inherit email;
    };
  };
  
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      side-by-side = true;
    };
  };
}
