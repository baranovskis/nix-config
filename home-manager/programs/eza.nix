# Eza — modern ls with git status and icons
{...}: {
  programs.eza = {
    enable = true;
    extraOptions = [
      "--group-directories-first"
    ];
  };
}
