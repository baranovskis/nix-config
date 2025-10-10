{
  config,
  lib,
  pkgs,
  username,
  ...
}:
{
  services = {
    desktopManager.plasma6 = {
      enable = true;
    };

    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };

      # Set KDE as default session
      defaultSession = "plasma";

      # Enable autologin
      autoLogin = {
        enable = true;
        user = username;
      };
    };

    # Configure keyboard layout for Wayland
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    kdePackages.kate
    kdePackages.kcalc
    kdePackages.partitionmanager
  ];

  # KDE Plasma integrations
  programs.kdeconnect.enable = true;
}
